REM Makes KekAlice and KekBob, and associated signed EFI files.

REM Run part2.bat to create PkRoot and KekRoot first, if you have not done so.

SETLOCAL
PATH=%PATH%;C:\Program Files (x86)\Windows Kits\8.0\bin\x64

makecert -n "CN=KekAlice" -iv KekRoot.pvk -ic KekRoot.cer -sv KekAlice.pvk KekAlice.cer
pvk2pfx -pvk KekAlice.pvk -spc KekAlice.cer -pfx KekAlice.pfx
copy HelloWorld.efi.unsigned HelloWorldAlice.efi
signtool sign /f KekAlice.pfx /fd sha256 HelloWorldAlice.efi

makecert -n "CN=KekBob" -iv KekRoot.pvk -ic KekRoot.cer -sv KekBob.pvk KekBob.cer
pvk2pfx -pvk KekBob.pvk -spc KekBob.cer -pfx KekBob.pfx
copy HelloWorld.efi.unsigned HelloWorldBob.efi
signtool sign /f KekBob.pfx /fd sha256 HelloWorldBob.efi

ENDLOCAL
