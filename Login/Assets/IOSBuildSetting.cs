using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEditor.iOS.Xcode;
using UnityEngine;
using System.IO;

public class IOSBuildSetting
{
    [PostProcessBuild]
    public static void OnPostProcessBuild(BuildTarget buildTarget, string path)
    {
        if (buildTarget == BuildTarget.iOS)
        {
            //获得proj文件
            string projPath = PBXProject.GetPBXProjectPath(path);
            PBXProject xcodeProj = new PBXProject();
            xcodeProj.ReadFromString(File.ReadAllText(projPath));
        
            string targetGuid = xcodeProj.GetUnityMainTargetGuid();
            string frameworkGuid = xcodeProj.GetUnityFrameworkTargetGuid();
            xcodeProj.AddFrameworkToProject(frameworkGuid, "WebKit.framework", true);
            xcodeProj.WriteToFile(projPath);
        
            xcodeProj.AddCapability(targetGuid, PBXCapabilityType.AssociatedDomains,"Unity-iPhone.entitlements",true);

            var plistPath = Path.Combine(path, "Info.plist");
            PlistDocument plist = new PlistDocument();
            plist.ReadFromString(File.ReadAllText(plistPath));
            var rootDict = plist.root;
        
            PlistElementArray loginChannelsArr;
            loginChannelsArr = rootDict.CreateArray("LSApplicationQueriesSchemes");
            loginChannelsArr.AddString("weixin");
            loginChannelsArr.AddString("wechat");
            loginChannelsArr.AddString("weixinULAPI");

            plist.WriteToFile(plistPath);
            File.WriteAllText(projPath,xcodeProj.WriteToString());
        }
    }
}
