using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using UnityEngine;
using UnityEngine.Networking;

public class WeChatLogin
{
    [DllImport("__Internal")]
    private static extern bool _isWechatInstalled();
    [DllImport("__Internal")]
    private static extern void _WechatLogin(string appid, string state);
    
    public static void SendWxLogin()
    {
        bool isInstalled = false;
        // "", "d78e67a15f7e4cbfd124b22f9fc2acad.share2dlink.com"
        string wx_appid = "wx617c77c82218ea2c";
        string state = "WeChatLogin";
#if !UNITY_EDITOR
#if UNITY_IOS
       isInstalled = _isWechatInstalled();
#endif
#endif
        if (isInstalled)
        {
#if !UNITY_EDITOR
#if UNITY_IOS
       _WechatLogin(wx_appid,state);
#endif
#endif
        }
        else
        {
            Debug.Log("请先安装微信客户端");
        }
    }
    
    private static int shareType = 0;
    
    UnityWebRequest webRequest;
 
    [DllImport("__Internal")]
    private static extern void _ShareByIos(int type, string url);
 
    /// <summary>
    /// 图片类型分享至微信
    /// </summary>
    /// <param name="_type">0:表示分享到聊天；1：表示分享到朋友圈</param>
    private void OnShareWXByIOS(int _type)
    {
        shareType = _type;
    }

    public static void Share()
    {
        _ShareByIos(shareType, "https://oss-odds-common-cn-hangzhou.oss-cn-hangzhou.aliyuncs.com/Assets/007d5f13-3b6a-4fe2-97fc-9371233a39ce.png");
    }
}
