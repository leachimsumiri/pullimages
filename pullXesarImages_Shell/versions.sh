#!/bin/sh
REPO=$2
VERSION=$1
NEXUS="false"
SFW="false"

mkdir versions
cd versions
git init
git remote add origin https://bach1.evva.com/bitbucket/scm/xs3/version-info.git

if [[ $REPO == "xesar-staging" ]]
then
  SFW="true"
  echo Using Harbor STAGING Versions
  git pull origin staging
fi
if [[ $REPO == "xesar-development" ]]
then
  SFW="true"
  echo Using Harbor DEV Versions
  git pull origin develop
fi
if [[ $REPO == "xesar" ]]
then
	SFW="true"
  echo Using Harbor PROD Versions
  git pull origin production
fi
if [[ $REPO == "nexus3" ]]
then
  NEXUS="true"
  echo Using NEXUS3 Versions
  # NEXUS Version info is running on dev branch
  git pull origin develop
fi

cd version-info

XSR_FW_VERSION=$(jq -a -r '.components | .firmware' ${VERSION}.json)
XSR_IM_VERSION=$(jq -a -r '.components | ."installation-manager"' ${VERSION}.json)
XSR_APK_VERSION=$(jq -a -r '.components | ."maintenance-component-apk"' ${VERSION}.json)
XSR_PM_VERSION=$(jq -a -r '.components | ."periphery-manager"' ${VERSION}.json)
XSR_AC_VERSION=$(jq -a -r '.components | ."administration-component"' ${VERSION}.json)
XSR_IMPORT_VERSION=$(jq -a -r '.components | ."import-xs22"' ${VERSION}.json)
XSR_EXPORT_VERSION=$(jq -a -r '.components | ."export-xs22"' ${VERSION}.json)

export XSR_FW_VERSION XSR_IM_VERSION XSR_APK_VERSION XSR_PM_VERSION 
export XSR_AC_VERSION XSR_IMPORT_VERSION XSR_EXPORT_VERSION

cd ..
cd ..