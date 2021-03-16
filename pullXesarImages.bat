@echo off
echo You will type the Softwareversion and the Repository. Take care that the versions of the other images must be handled manually in the script atm
echo ---
SET /p version=Please type the Software Version_
SET /p repo=Please type the Repository_
SET /p fw=Please type the Firmware_
SET /p apk=Please type the APK Version_
SET /p pm=Please type the Version of the Periphery Manager_
SET /p im=Please type the Version of the Installation Manager_

echo "Login to %repo%"
docker login %repo%

echo "Pull and Save images"
mkdir %version%
docker pull %repo%/xs3-version-info:latest
docker save %repo%/xs3-version-info:latest > %version%/xs3-version-info-latest.tar

docker pull %repo%/xs3-backend:%version%
docker save %repo%/xs3-backend:%version% > %version%/xs3-backend-%version%.tar

docker pull %repo%/xs3-postgres:%version%
docker save %repo%/xs3-postgres:%version% > %version%/xs3-postgres-%version%.tar

docker pull %repo%/xs3-message-broker:%version%
docker save %repo%/xs3-message-broker:%version% > %version%/xs3-message-broker-%version%.tar

docker pull %repo%/xs3-vault:%version%
docker save %repo%/xs3-vault:%version% > %version%/xs3-vault-%version%.tar

docker pull %repo%/xs3-vault-setup:%version%
docker save %repo%/xs3-vault-setup:%version% > %version%/xs3-vault-setup-%version%.tar

docker pull %repo%/xs3-och2mqtt:%version%
docker save %repo%/xs3-och2mqtt:%version% > %version%/xs3-och2mqtt-%version%.tar

docker pull %repo%/xs3-import-xs22:latest
docker save %repo%/xs3-import-xs22:latest > %version%/xs3-import-xs22-latest.tar

docker pull %repo%/export-xesar22-tool:latest
docker save %repo%/export-xesar22-tool:latest > %version%/export-xesar22-tool-latest.tar

docker pull %repo%/xs3-firmware:%fw%
docker save %repo%/xs3-firmware:%fw% > %version%/xs3-firmware-%fw%.tar

docker pull %repo%/xs3-maintenance-component:%apk%
docker save %repo%/xs3-maintenance-component:%apk% > %version%/xs3-maintenance-component-%apk%.tar

docker pull %repo%/xs3-periphery-manager:%pm%
docker save %repo%/xs3-periphery-manager:%pm% > %version%/xs3-periphery-manager-%pm%.tar

docker pull %repo%/xs3-installation-manager:%im%
docker save %repo%/xs3-installation-manager:%im% > %version%/xs3-installation-manager-%im%.tar

pause
