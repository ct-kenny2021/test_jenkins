#!/bin/bash

#自动更改版本号
#debug模式下会自动加上git当前分支的代码提交次数
#test和beta模式下会自动加上当前的日期
#release模式下不会修改

git=`sh /etc/profile; which git`
branchName=`"$git" rev-parse --abbrev-ref HEAD`

date=`date +%m%d`
appBuild=`"$git" rev-list --count "$branchName"`
appversion=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}")

if [ $CONFIGURATION = "Debug" ]; then

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $appversion" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"

elif [ $CONFIGURATION = "Test" ] || [ $CONFIGURATION = "Beta" ]; then

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $appversion.$date" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"

else

/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $appBuild" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString $appversion" "${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"

fi

echo "Updated ${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"