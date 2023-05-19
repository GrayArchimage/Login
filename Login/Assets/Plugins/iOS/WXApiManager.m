//  WXApiManager.m
#import "WXApiManager.h"
@implementation WXApiManager
+(instancetype) shareManager
{
   static dispatch_once_t onceToken;
   static WXApiManager *instance;
   dispatch_once(&onceToken, ^{
       instance = [[WXApiManager alloc] init];
   });
   return instance;
}
// 微信发送请求到第三方应用时，会回调到该方法
-(void) onReq:(BaseReq *)req {}
// 第三方应用发送到微信的请求处理后的响应结果，会回调到该方法
-(void) onResp:(BaseResp *)resp
{
    NSLog(@"微信响应");
   if([resp isKindOfClass:[SendAuthResp class]])
   {
       SendAuthResp *temp = (SendAuthResp*)resp;
       int errorCode = temp.errCode;
       switch (errorCode) {
           case 0:
               {
                   printf("登录成功-xcode");
                   NSLog(@"code %@",temp.code);
                   //UnitySendMessage(objName, funName, [NSUTF8StringEncoding temp.code]);
                   break;
               }
           case -2:
               printf("用户取消");
               UnitySendMessage("LaunchCanvas", "MessageError", "用户取消");
               break;
           case -4:
               printf("用户拒绝授权");
               UnitySendMessage("LaunchCanvas", "MessageError", "用户拒绝授权");
               break;
           default:
               printf("登录失败");
               UnitySendMessage("LaunchCanvas", "MessageError", "登录失败");
               break;
       }
   }
}
@end