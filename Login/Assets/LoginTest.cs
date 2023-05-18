using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LoginTest : MonoBehaviour
{
    void Start()
    {
        WeChatLogin.Init();
        
        WeChatLogin.Login();
    }
}
