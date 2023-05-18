//
//  ViewController.m
//  iosPlugins
//
//  Created by os on 2020/4/10.
//  Copyright © 2020 os. All rights reserved.
//
#import "ViewController.h"
 
@implementation ViewController
+(instancetype) shareManager
{
    static dispatch_once_t onceToken;
    static ViewController *instance;
    dispatch_once(&onceToken, ^{
        instance = [[ViewController alloc] init];
    });
    return instance;
}
//微信发送请求到第三方应用时，会回调到该方法
-(void) onReq:(BaseReq *)req {}
//第三方应用发送到微信的请求处理后的响应结果，会回调到该方法
-(void) onResp:(BaseResp *)resp
{
    NSLog(@"微信响应");
    //微信登录授权回调
    if([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *temp = (SendAuthResp*)resp;
        int errorCode = temp.errCode;
        switch (errorCode) {//[NSUTF8StringEncoding temp.code]
            case 0:
                {
                    printf("登录成功-xcode");
                    NSLog(@"code %@",temp.code);
                    NSString *message = [NSString stringWithFormat:@"%s;%@","0",temp.code];
                    const char* codeInfo = [message cStringUsingEncoding:NSASCIIStringEncoding];
                    OnShowMessage(codeInfo);
                    break;
                }
            case -2:
                printf("用户取消");
                OnShowMessage("-2;用户取消");
                break;
            case -4:
                printf("用户拒绝授权");
                OnShowMessage("-4;用户取消");
                break;
            default:
                printf("登录失败");
                OnShowMessage("-1;登录失败");
                break;
        }
    }
    //微信分享授权回调
    else if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //0成功，-2是取消，其他异常
        SendMessageToWXResp *rresp = (SendMessageToWXResp*)resp;
        NSString *code = [NSString stringWithFormat:@"%d",rresp.errCode];
        const char* codeInfo = [code cStringUsingEncoding:NSASCIIStringEncoding];
        OnShareShowMessage(codeInfo);
    }
}
 
//防止内存泄漏，崩溃，这里进行参数转换
char* MakeStringCopy(const char* string){
    if(string == NULL){
        return NULL;
    }
    char* res = (char*)malloc(strlen(string)+1);
    strcpy(res, string);
    return res;
}
//信息提示
void OnShowMessage(const char* msg)
{
    UnitySendMessage("WeChatResp","LoginCallBack",MakeStringCopy(msg));
}

void OnShareShowMessage(const char* msg)
{
    UnitySendMessage("WeChatResp","ShareCallBack",MakeStringCopy(msg));
}
@end