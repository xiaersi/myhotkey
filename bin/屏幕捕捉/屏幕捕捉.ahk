/*
 *   1. Keep script running.
 *   2. Limit to one running copy.
 *   3. Run script without pauses.
 */
#Persistent
#SingleInstance ignore
SetBatchLines, 10ms

#include ..\..\
#include .\inc\capture.aik


/*
 *-------------------------------------------------------------------------------------
 *       Use hotkey:    Win + PrtScr
 *-------------------------------------------------------------------------------------
 */
#PrintScreen::

   /*
    * Create folder.
    */
   IfNotExist, PrintScreen
   {
      FileCreateDir, PrintScreen
   }


   /*
    * Reset counter.
    */
   countLoop := 1


   /*
    * Repeat until we have unused name for file.
    */
   loopFileName:

      /*
       * Reset string.
       */
      countLoopString := countLoop
      
      /*
       * Add leading zeroes to string.
       */
      loopStringAddZeroes:
         if (StrLen(countLoopString) < 4)
         {
            countLoopString := "0" countLoopString
            Goto, loopStringAddZeroes
         }
      
      /*
       * Form the name of new file.
       */
      newFileName := "PrintScreen\img_" countLoopString ".jpg"
      
      /*
       * Check if file name is taken.
       */
      IfExist, % newFileName
      {
         countLoop++
         Goto, loopFileName
      }

      
   /*
    * Capture screenshot.
    */
   CaptureScreen(0, False, newFileName, 100)
return

