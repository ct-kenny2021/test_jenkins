//
//  RNEnvironment.h
//  Rinnai
//
//  Created by chenting on 2021/6/29.
//  Copyright © 2021 Hadlinks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RNMacros.h"

// App环境初始化宏
#define RN_ENVIRONMENT_INIT  ENV

//App环境单例对象
#define ENV  [RNEnvironment sharedInstance]

// 环境定义
#define RN_ENV_DEV                  @"DEV"
#define RN_ENV_TEST                 @"TEST"
#define RN_ENV_PRE                  @"PRE"
#define RN_ENV_PROD                 @"PROD"

#if DEBUG
#define ENV_PROP_DESC (nonatomic, copy)
#else
#define ENV_PROP_DESC (nonatomic, copy, readonly)
#endif

@interface RNEnvironment : NSObject

DEF_SINGLETON(RNEnvironment);

@property ENV_PROP_DESC NSString *environmentName;

@property ENV_PROP_DESC NSString *appName;

@property ENV_PROP_DESC NSString *apiBaseURLString;

@end

