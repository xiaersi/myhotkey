@echo off
@REG Delete HKCU/Software/Microsoft/VCExpress/9.0/FileMRUList /va /f
@REG Delete HKCU/Software/Microsoft/VCExpress/9.0/ProjectMRUList /va /f

