//
//  Native.mm
//  iosPlugins
//
//  Created by os on 2020/4/10.
//  Copyright © 2020 os. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Native.h"
#import "Libraries/Plugins/iOS/WXApi.h"
@interface Native()
@end
@implementation Native : NSObject
 
//判断是否安装微信
bool _isWechatInstalled()
{
    return [WXApi isWXAppInstalled];
}
 
//微信登录
void _WechatLogin(char* appid,char* message)
{
    //向微信注册appid:填写自己微信开放平台的appid信息
    NSString *weichatId = [NSString stringWithFormat:@"%s", appid];
    NSString *UNIVERSAL_LINK = [NSString stringWithFormat:@"%s", "对应申请微信平台上的Universal Links"];
    [WXApi registerApp:weichatId universalLink:UNIVERSAL_LINK];
    
    if([WXApi isWXAppInstalled] ==false)
    {
        NSLog(@"请先安装微信客户端");
        return;
    }
    //登录
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = [NSString stringWithFormat:@"%s", message];
    //[WXApi sendReq:req];
    [WXApi sendReq:req completion:^(BOOL success) { NSLog(@"唤起微信:%@", success ? @"成功" : @"失败");  }];
}

//分享图片类型接口示例
//参数：type表示分享类型（0：分享某个好友聊天；1：分享到微信朋友圈）
//参数：url为图片本地地址，当然也可以用远程地址然后下载下来。
//具体分享其他类型（如文宇类型，音乐类型，视频类型可参考微信官网API）
void _ShareByIos(int type, char* url)
{
    NSString *sharePicUrl = [NSString stringWithFormat:@"%s", url];
    //UIImage *image = [UIImage imageNamed:sharePicUrl];
    //NSData* imageData = UIImageJPEGRepresentation(image, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = [NSData dataWithContentsOfFile:sharePicUrl];
    
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"xzqShare.png"]];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = type ==0? WXSceneSession : WXSceneTimeline;//0表示聊天，1，表示朋友圈
    [WXApi sendReq:req completion:^(BOOL success) { NSLog(@"微信分享:%@", success ? @"成功" : @"失败");  }];
    
}
@end
 