using System.Collections;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.UI;

public class LoginTest : MonoBehaviour
{
    public Button btnLogin;
    public Button btnShare;

    private void Start() {
        btnLogin.onClick.AddListener(()=>{
            WechatLogin();
        });
    }
    
    /// <summary>
   /// 微信登录
   /// </summary>
   [DllImport("__Internal")]
   private static extern void WechatLogin();

   /// <summary>
   /// code信息  
   /// </summary>
   private void funName(string code)
   {
       Debug.Log("code=  " + code);
   }
}
