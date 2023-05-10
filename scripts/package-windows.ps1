Write-Output "$WINDOWN_PFX"
Move-Item -Path $WINDOWS_PFX -Destination brigadachat.pem
certutil -decode brigadachat.pem brigadachat.pfx

flutter pub run msix:create -c brigadachat.pfx -p $WINDOWS_PFX_PASS --sign-msix true --install-certificate false
