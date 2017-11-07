#author by Goff

#注意：脚本目录和WorkSpace目录在同一个目录
#工程名字(Target名字)
Project_Name="MobileEditing"
#workspace的名字
Workspace_Name="MobileEditing"


#AdHoc版本的Bundle ID
AdHocBundleID="com.bravogo.hb.sjz.hbrb.News.Ydcb"
#AppStore版本的Bundle ID
AppStoreBundleID="com.bravogo.hb.sjz.hbrb.News.Ydcb"
#enterprise的Bundle ID
EnterpriseBundleID="com.bravogo.hb.sjz.hbrb.News.Ydcb"

# ADHOC证书名#描述文件
ADHOCCODE_SIGN_IDENTITY="iPhone Distribution: HeBei Haoxing Internet Technology Co., Ltd. (ZNJLJT34TA)"
ADHOCPROVISIONING_PROFILE_NAME="1718f79c-c9ea-4784-a961-233e46cfe458"

#AppStore证书名#描述文件
APPSTORECODE_SIGN_IDENTITY="iPhone Distribution: HeBei Haoxing Internet Technology Co., Ltd. (ZNJLJT34TA)"
APPSTOREROVISIONING_PROFILE_NAME="1718f79c-c9ea-4784-a961-233e46cfe458"

#企业(enterprise)证书名#描述文件
ENTERPRISECODE_SIGN_IDENTITY="iPhone Distribution: xxxx"
ENTERPRISEROVISIONING_PROFILE_NAME="xxxxx-xxxx-xxx-xxxx"

#加载各个版本的plist文件
ADHOCExportOptionsPlist=./ADHOCExportOptionsPlist.plist
AppStoreExportOptionsPlist=./AppStoreExportOptionsPlist.plist
EnterpriseExportOptionsPlist=./EnterpriseExportOptionsPlist.plist

ADHOCExportOptionsPlist=${ADHOCExportOptionsPlist}
AppStoreExportOptionsPlist=${AppStoreExportOptionsPlist}
EnterpriseExportOptionsPlist=${EnterpriseExportOptionsPlist}

echo "~~~~~~~~~~~~选择打包方式(输入序号)~~~~~~~~~~~~~~~"
echo "		1 adHoc"
echo "		2 AppStore"
echo "		3 Enterprise"

# 读取用户输入并存到变量里
read parameter
sleep 0.5
method="$parameter"

# 判读用户是否有输入
if [ -n "$method" ]
then
    if [ "$method" = "1" ]
    then
#配置环境，Release或者Debug,Adhoc,默认release
Configuration="Adhoc"
#adhoc脚本
xcodebuild -workspace $Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-adhoc.xcarchive clean archive build CODE_SIGN_IDENTITY="${ADHOCCODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ADHOCPROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AdHocBundleID}"
xcodebuild  -exportArchive -archivePath build/$Project_Name-adhoc.xcarchive -exportOptionsPlist ${ADHOCExportOptionsPlist} -exportPath ~/Desktop/$Project_Name-adhoc

firApiToken="13c422a873468db5d993949889823d2f"
fir publish ~/Desktop/$Project_Name-adhoc/$Project_Name.ipa -T "$firApiToken"
echo "\n\033[32;1m************************* 上传 $Project_Name-adhoc.ipa 包 到 fir 成功 🎉 🎉 🎉 *************************\033[0m\n"


    elif [ "$method" = "2" ]
    then
#配置环境，Release或者Debug,Adhoc,默认release
Configuration="Release"
#appstore脚本
xcodebuild -workspace $Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-appstore.xcarchive archive build CODE_SIGN_IDENTITY="${APPSTORECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${APPSTOREROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${AppStoreBundleID}"
xcodebuild  -exportArchive -archivePath build/$Project_Name-appstore.xcarchive -exportOptionsPlist ${AppStoreExportOptionsPlist} -exportPath ~/Desktop/$Project_Name-appstore

    elif [ "$method" = "3" ]
    then
#企业打包脚本
xcodebuild -workspace $Workspace_Name.xcworkspace -scheme $Project_Name -configuration $Configuration -archivePath build/$Project_Name-enterprise.xcarchive archive build CODE_SIGN_IDENTITY="${ENTERPRISECODE_SIGN_IDENTITY}" PROVISIONING_PROFILE="${ENTERPRISEROVISIONING_PROFILE_NAME}" PRODUCT_BUNDLE_IDENTIFIER="${EnterpriseBundleID}"
xcodebuild  -exportArchive -archivePath build/$Project_Name-enterprise.xcarchive -exportOptionsPlist ${EnterpriseExportOptionsPlist} -exportPath ~/Desktop/$Project_Name-enterprise.ipa
    else
    echo "参数无效...."
    exit 1
    fi
fi
