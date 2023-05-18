//
//  Native.h
//  iosPlugins
//
//  Created by os on 2020/4/10.
//  Copyright © 2020 os. All rights reserved.
//
#include "UI/UnityViewControllerBase.h"
#include "UnityAppController+ViewHandling.h"
@interface Native:NSObject
@end
extern "C"
{
void _WechatLogin(char* appid,char* message);
bool _isWechatInstalled();
void _ShareByIos(int type, char* url);
}