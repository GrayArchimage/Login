using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LoginTest : MonoBehaviour
{
    public Button btnLogin;
    public Button btnShare;
    
    void Start()
    {
        btnLogin.onClick.AddListener(() =>
        {
            WeChatLogin.SendWxLogin();
        });
        
        btnShare.onClick.AddListener(() =>
        {
            WeChatLogin.Share();
        });
    }
}
