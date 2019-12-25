
; -------------------------------------------------
; ------------SERVERSCRIPT------------------
; -------------------------------------------------
; CONFIGURATION SECTION:

; Specify Your own Network's address and port.
Network_Address = 10.79.3.151
Network_Port = 8765
; ----------------------------
; END OF CONFIGURATION SECTION
; ----------------------------

Gui, Add, Edit, w100 vSendText
Gui, Add, Button, gSendviaNet, Send
Gui, Show

Gosub Connection_Init

return


Connection_Init:
OnExit, ExitSub  ; For connection cleanup purposes.

; set up a very basic server:
socket := PrepareForIncomingConnection(Network_Address, Network_Port)
if socket = -1  ; Connection failed (it already displayed the reason).
    ExitApp

; Find this script's main window:
Process, Exist  ; This sets ErrorLevel to this script's PID (it's done this way to support compiled scripts).
DetectHiddenWindows On
ScriptMainWindowId := WinExist("ahk_class AutoHotkey ahk_pid " . ErrorLevel)
DetectHiddenWindows Off

; When the OS notifies the script that there is incoming data waiting to be received,
; the following causes a function to be launched to read the data:
NotificationMsg = 0x5555  ; An arbitrary message number, but should be greater than 0x1000.
OnMessage(NotificationMsg, "ReceiveData")

; Set up the connection to notify this script via message whenever new data has arrived.
; This avoids the need to poll the connection and thus cuts down on resource usage.
FD_READ = 1     ; Received when data is available to be read.
FD_CLOSE = 32   ; Received when connection has been closed.
FD_CONNECT = 20 ; Recieved when connection has been made.
if DllCall("Ws2_32\WSAAsyncSelect", "UInt", socket, "UInt", ScriptMainWindowId, "UInt", NotificationMsg, "Int", FD_READ|FD_CLOSE|FD_CONNECT)
{
    MsgBox % "WSAAsyncSelect() indicated Winsock error " . DllCall("Ws2_32\WSAGetLastError")
    ExitApp
}

Loop ; Wait for incomming connections
{
; accept requests that are in the pipeline of the socket   
   conectioncheck := DllCall("Ws2_32\accept", "UInt", socket, "UInt", &SocketAddress, "Int", SizeOfSocketAddress)
; Ws2_22/accept returns the new Connection-Socket if a connection request was in the pipeline
; on failure it returns an negative value
    if conectioncheck > 1
    {
       MsgBox Incoming connection accepted
       break   
   }
    sleep 500 ; wait half 1 second then accept again
}   
return

SendviaNet:
Gui, Submit, NoHide
SendData(conectioncheck,SendText)
SentText =
return



PrepareForIncomingConnection(IPAddress, Port)
; This can connect to most types of TCP servers, not just Network.
; Returns -1 (INVALID_SOCKET) upon failure or the socket ID upon success.
{
    VarSetCapacity(wsaData, 32)  ; The struct is only about 14 in size, so 32 is conservative.
    result := DllCall("Ws2_32\WSAStartup", "UShort", 0x0002, "UInt", &wsaData) ; Request Winsock 2.0 (0x0002)
    ; Since WSAStartup() will likely be the first Winsock function called by this script,
    ; check ErrorLevel to see if the OS has Winsock 2.0 available:
    if ErrorLevel
    {
        MsgBox WSAStartup() could not be called due to error %ErrorLevel%. Winsock 2.0 or higher is required.
        return -1
    }
    if result  ; Non-zero, which means it failed (most Winsock functions return 0 upon success).
    {
        MsgBox % "WSAStartup() indicated Winsock error " . DllCall("Ws2_32\WSAGetLastError")
        return -1
    }

    AF_INET = 2
    SOCK_STREAM = 1
    IPPROTO_TCP = 6
    socket := DllCall("Ws2_32\socket", "Int", AF_INET, "Int", SOCK_STREAM, "Int", IPPROTO_TCP)
    if socket = -1
    {
        MsgBox % "socket() indicated Winsock error " . DllCall("Ws2_32\WSAGetLastError")
        return -1
    }

    ; Prepare for connection:
    SizeOfSocketAddress = 16
    VarSetCapacity(SocketAddress, SizeOfSocketAddress)
    InsertInteger(2, SocketAddress, 0, AF_INET)   ; sin_family
    InsertInteger(DllCall("Ws2_32\htons", "UShort", Port), SocketAddress, 2, 2)   ; sin_port
    InsertInteger(DllCall("Ws2_32\inet_addr", "Str", IPAddress), SocketAddress, 4, 4)   ; sin_addr.s_addr

    ; Bind to socket:
    if DllCall("Ws2_32\bind", "UInt", socket, "UInt", &SocketAddress, "Int", SizeOfSocketAddress)
    {
        MsgBox % "bind() indicated Winsock error " . DllCall("Ws2_32\WSAGetLastError") . "?"
        return -1
    }
    if DllCall("Ws2_32\listen", "UInt", socket, "UInt", "SOMAXCONN")
    {
        MsgBox % "LISTEN() indicated Winsock error " . DllCall("Ws2_32\WSAGetLastError") . "?"
        return -1
    }
   
    return socket  ; Indicate success by returning a valid socket ID rather than -1. 
}



ReceiveData(wParam, lParam)
; By means of OnMessage(), this function has been set up to be called automatically whenever new data
; arrives on the connection. 
{
   global ShowRecieved
    socket := wParam
    ReceivedDataSize = 4096  ; Large in case a lot of data gets buffered due to delay in processing previous data.
    Loop  ; This loop solves the issue of the notification message being discarded due to thread-already-running.
    {
        VarSetCapacity(ReceivedData, ReceivedDataSize, 0)  ; 0 for last param terminates string for use with recv().
        ReceivedDataLength := DllCall("Ws2_32\recv", "UInt", socket, "Str", ReceivedData, "Int", ReceivedDataSize, "Int", 0)
        if ReceivedDataLength = 0  ; The connection was gracefully closed,
            ExitApp  ; The OnExit routine will call WSACleanup() for us.
        if ReceivedDataLength = -1
        {
            WinsockError := DllCall("Ws2_32\WSAGetLastError")
            if WinsockError = 10035  ; WSAEWOULDBLOCK, which means "no more data to be read".
                return 1
            if WinsockError <> 10054 ; WSAECONNRESET, which happens when Network closes via system shutdown/logoff.
                ; Since it's an unexpected error, report it.  Also exit to avoid infinite loop.
                MsgBox % "recv() indicated Winsock error " . WinsockError
            ExitApp  ; The OnExit routine will call WSACleanup() for us.
        }
        ; Otherwise, process the data received.
        Loop, parse, ReceivedData, `n, `r
        {
           ShowRecieved = %ShowRecieved%%A_LoopField%
           ;Tooltip % ShowRecieved
		   TrayTip Server Receive, %ShowRecieved%
        }
    }
    return 1  ; Tell the program that no further processing of this message is needed.
}

SendData(wParam,SendData)
{
socket := wParam
;MsgBox %socket%  %SendData%
SendDataSize := VarSetCapacity(SendData)
SendDataSize += 1
sendret := DllCall("Ws2_32\send", "UInt", socket, "Str", SendData, "Int", SendDatasize, "Int", 0)
;send( sockConnected,> welcome, strlen(welcome) + 1, NULL);
}


InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4)
; The caller must ensure that pDest has sufficient capacity.  To preserve any existing contents in pDest,
; only pSize number of bytes starting at pOffset are altered in it.
{
    Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data.
        DllCall("RtlFillMemory", "UInt", &pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF)
}



ExitSub:  ; This subroutine is called automatically when the script exits for any reason.
; MSDN: "Any sockets open when WSACleanup is called are reset and automatically
; deallocated as if closesocket was called."
DllCall("Ws2_32\WSACleanup")
ExitApp
