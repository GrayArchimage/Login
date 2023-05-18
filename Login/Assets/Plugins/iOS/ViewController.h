//
//  ViewController.h
//  iosPlugins
//
//  Created by os on 2020/4/10.
//  Copyright © 2020 os. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Libraries/Plugins/iOS/WXApi.h"
 
NS_ASSUME_NONNULL_BEGIN
@interface ViewController : UIResponder<UIApplicationDelegate, WXApiDelegate>
+ (instancetype)shareManager;
@end
NS_ASSUME_NONNULL_END