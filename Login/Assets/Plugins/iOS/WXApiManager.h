#import <Foundation/Foundation.h>
#import "Libraries/Plugins/iOS/WXApi.h"
NS_ASSUME_NONNULL_BEGIN
@interface WXApiManager : UIResponder<UIApplicationDelegate, WXApiDelegate>
+ (instancetype)shareManager;
@end
NS_ASSUME_NONNULL_END