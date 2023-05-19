#import <Foundation/Foundation.h>
#import "Native.h"
#import "Libraries/Plugins/iOS/WXApi.h"
@interface Native ()
@end
@implementation Native :NSObject
//判断是否安装微信
bool _isWechatInstalled()
{
   return [WXApi isWXAppInstalled];
}
//微信登录
void WechatLogin()
{
   NSLog(@"微信登录");

   //向微信注册appid: 填写自己微信开放平台的appid信息
   NSString *weichatId = [NSString stringWithFormat:@"%s", appid];
   [WXApi registerApp:weichatId];

   if([WXApi isWXAppInstalled]==false)
   {
     NSLog(@"请先安装微信客户端");
     //UnitySendMessage("LaunchCanvas", "MessageError", "请先安装微信客户端");
     return;
   }
   
   //登录
   SendAuthReq* req = [[SendAuthReq alloc] init];
   req.scope = @"snsapi_userinfo";
   req.state = [NSString stringWithFormat:@"%s", "wechat_sdk_demo_test"];
   [WXApi sendReq:req];
}
//打开微信(注意：需要先注册appid)
void OpenWXApp()
{
 [WXApi openWXApp];
}
@end