REM Tests from Part 2 of my series on Secure Boot.
REM Creates a PK and a KEK and then signs copies of 
REM HelloWorld.efi.unsigned with each key.

REM When PkRoot and KekRoot are enrolled as PK and KEK
REM respectively, HelloWorldKek.efi is authorized but
REM HelloWorldPk.efi is not.

SETLOCAL
PATH=%PATH%;C:\Program Files (x86)\Windows Kits\8.0\bin\x64

makecert -n "CN=PkRoot" -r -sv PkRoot.pvk PkRoot.cer
pvk2pfx -pvk PkRoot.pvk -spc PkRoot.cer -pfx PkRoot.pfx
copy HelloWorld.efi.unsigned HelloWorldPk.efi
signtool sign /f PkRoot.pfx /fd sha256 HelloWorldPk.efi

makecert -n "CN=KekRoot" -r -sv KekRoot.pvk KekRoot.cer
pvk2pfx -pvk KekRoot.pvk -spc KekRoot.cer -pfx KekRoot.pfx
copy HelloWorld.efi.unsigned HelloWorldKek.efi
signtool sign /f KekRoot.pfx /fd sha256 HelloWorldKek.efi

copy HelloWorld.efi.unsigned HelloWorld.efi

ENDLOCAL
