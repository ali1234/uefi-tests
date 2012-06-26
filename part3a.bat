REM Makes KekChild and KekChildChild, and associated signed EFI files.

REM Run part2.bat to create PkRoot and KekRoot first, if you have not done so.

SETLOCAL
PATH=%PATH%;C:\Program Files (x86)\Windows Kits\8.0\bin\x64

makecert -n "CN=KekChild" -iv KekRoot.pvk -ic KekRoot.cer -sv KekChild.pvk KekChild.cer
pvk2pfx -pvk KekChild.pvk -spc KekChild.cer -pfx KekChild.pfx
copy HelloWorld.efi.unsigned HelloWorldChild.efi
signtool sign /f KekChild.pfx /fd sha256 HelloWorldChild.efi

makecert -n "CN=KekChildChild" -iv KekChild.pvk -ic KekChild.cer -sv KekChildChild.pvk KekChildChild.cer
cert2spc KekRoot.cer KekChild.cer KekChildChild.cer KekKids.spc
pvk2pfx -pvk KekChildChild.pvk -spc KekKids.spc -pfx KekChildChild.pfx
copy HelloWorld.efi.unsigned HelloWorldChildChild.efi
signtool sign /f KekChildChild.pfx /fd sha256 HelloWorldChildChild.efi

ENDLOCAL
