//
//  XX运动-Bridging-Header.h
//  XX运动
//
//  Created by Ying on 2016/12/5.
//  Copyright © 2016年 李英. All rights reserved.
//

#ifndef XX___Bridging_Header_h
#define XX___Bridging_Header_h

//为了链接服务器的aPPkey
#import <AMapFoundationKit/AMapFoundationKit.h>
//做地图显示和地图的基本功能处理
#import <MAMapKit/MAMapKit.h>
//导入查找头文件
#import <AMapSearchKit/AMapSearchAPI.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "AFNetWorking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "FMDatabase.h"


#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import <UShareUI/UShareUI.h>

#define HOME_URL @"http://api.izhangchu.com:/"
//屏幕宽
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
//屏幕高
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

//常用文字的灰色
#define TEXT_GRAYCOLOR [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]
//视图背景浅灰色
#define GRAY_COLOR [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1]


#endif /* XX___Bridging_Header_h */
