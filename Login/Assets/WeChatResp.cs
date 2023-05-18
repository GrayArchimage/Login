using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WeChatResp : MonoBehaviour
{
    public void LoginCallBack(string callBackInfo)
    {
        if(string.IsNullOrEmpty(callBackInfo))
        {
            Debug.Log("error!!");
        }
        else
        {
            Debug.Log(callBackInfo);
        }
    }
    
    public void ShareCallBack(string callBackInfo)
    {
        if(string.IsNullOrEmpty(callBackInfo))
        {
            Debug.Log("error!!");
        }
        else
        {
            Debug.Log(callBackInfo);
        }
    }
}
