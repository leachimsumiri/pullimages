#!/bin/sh

# $1 is the version to be released
# It is used to extract version information for the images
source versions.sh

XSR_AC_VERSION="${XSR_AC_VERSION%\"}"
XSR_AC_VERSION="${XSR_AC_VERSION#\"}"

XSR_IM_VERSION="${XSR_IM_VERSION%\"}"
XSR_IM_VERSION="${XSR_IM_VERSION#\"}"

XSR_FW_VERSION="${XSR_FW_VERSION%\"}"
XSR_FW_VERSION="${XSR_FW_VERSION#\"}"

XSR_APK_VERSION="${XSR_APK_VERSION%\"}"
XSR_APK_VERSION="${XSR_APK_VERSION#\"}"

XSR_PM_VERSION="${XSR_PM_VERSION%\"}"
XSR_PM_VERSION="${XSR_PM_VERSION#\"}"

XSR_IMPORT_VERSION="${XSR_IMPORT_VERSION%\"}"
XSR_IMPORT_VERSION="${XSR_IMPORT_VERSION#\"}"

XSR_EXPORT_VERSION="${XSR_EXPORT_VERSION%\"}"
XSR_EXPORT_VERSION="${XSR_EXPORT_VERSION#\"}"

VERSION="${VERSION%\"}"
VERSION="${VERSION#\"}"

REPO="${REPO%\"}"
REPO="${REPO#\"}"

mkdir ${VERSION}_${REPO}

SaveImages(){
	REG=$1

	docker pull $REG/xs3-version-info:latest
	docker save $REG/xs3-version-info:latest > ${VERSION}_${REPO}/xs3-version-info.tar
	
	docker pull $REG/xs3-installation-manager:${XSR_IM_VERSION}
	docker save $REG/xs3-installation-manager:${XSR_IM_VERSION} > ${VERSION}_${REPO}/xs3-installation-manager.tar

	docker pull $REG/xs3-maintenance-component:${XSR_APK_VERSION}
	docker save $REG/xs3-maintenance-component:${XSR_APK_VERSION} > ${VERSION}_${REPO}/xs3-maintenance-component.tar

	docker pull $REG/xs3-periphery-manager:${XSR_PM_VERSION}
	docker save $REG/xs3-periphery-manager:${XSR_PM_VERSION} > ${VERSION}_${REPO}/xs3-periphery-manager.tar

	docker pull $REG/xs3-firmware:${XSR_FW_VERSION}
	docker save $REG/xs3-firmware:${XSR_FW_VERSION} > ${VERSION}_${REPO}/xs3-firmware.tar

	docker pull $REG/xs3-backend:${XSR_AC_VERSION}
	docker save $REG/xs3-backend:${XSR_AC_VERSION} > ${VERSION}_${REPO}/xs3-backend.tar

	docker pull $REG/xs3-postgres:${XSR_AC_VERSION}
	docker save $REG/xs3-postgres:${XSR_AC_VERSION} > ${VERSION}_${REPO}/xs3-postgres.tar

	docker pull $REG/xs3-message-broker:${XSR_AC_VERSION}
	docker save $REG/xs3-message-broker:${XSR_AC_VERSION} > ${VERSION}_${REPO}/xs3-message-broker.tar

	docker pull $REG/xs3-vault:${XSR_AC_VERSION}
	docker save $REG/xs3-vault:${XSR_AC_VERSION} > ${VERSION}_${REPO}/xs3-vault.tar

	docker pull $REG/xs3-vault-setup:${XSR_AC_VERSION}
	docker save $REG/xs3-vault-setup:${XSR_AC_VERSION} > ${VERSION}_${REPO}/xs3-vault-setup.tar

	docker pull $REG/xs3-och2mqtt:${XSR_AC_VERSION}
	docker save $REG/xs3-och2mqtt:${XSR_AC_VERSION} > ${VERSION}_${REPO}/xs3-och2mqtt.tar

	docker pull $REG/xs3-import-xs22:${XSR_IMPORT_VERSION}
	docker save $REG/xs3-import-xs22:${XSR_IMPORT_VERSION} > ${VERSION}_${REPO}/xs3-import-xs22.tar

	docker pull $REG/export-xesar22-tool:${XSR_EXPORT_VERSION}
	docker save $REG/export-xesar22-tool:${XSR_EXPORT_VERSION} > ${VERSION}_${REPO}/export-xesar22-tool.tar
	
	read -p "Finished! Press any Key to Exit..."
}


if [[ $NEXUS == "true" ]]
then
	docker login nexus3.evva.com:18450
	SaveImages nexus3.evva.com:18450
elif [[ $SFW == "true" ]]
then
	if [[ "$OSTYPE" == "win32" ]]
	then
		winpty docker login sfw.evva.com/$2
	elif [[ "$OSTYPE" == "win64" ]]
	then
		winpty docker login sfw.evva.com/$2
# this one below you get using git for windows / Mingw
	elif [[ "$OSTYPE" == "msys" ]]
	then
		winpty docker login sfw.evva.com/$2
	else
		docker login sfw.evva.com/$2
	fi
	SaveImages sfw.evva.com/$2
fi
