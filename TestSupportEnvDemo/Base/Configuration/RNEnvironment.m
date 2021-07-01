//
//  RNEnvironment.m
//  Rinnai
//
//  Created by chenting on 2021/6/29.
//  Copyright © 2021 Hadlinks. All rights reserved.
//

#import "RNEnvironment.h"

@interface RNEnvironment()

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, copy) NSString *configsCachePath;


- (void)loadEnvironmentDict:(NSDictionary *)dict;

@end

@implementation RNEnvironment

IMP_SINGLETON(RNEnvironment);

-(instancetype)init{
    self = [super init];
    if (self) {
        self.configsCachePath = [[NSBundle mainBundle] pathForResource:@"environment" ofType:@"plist"];
        self.dict = [NSDictionary dictionaryWithContentsOfFile:self.configsCachePath];
        // 为防止plist文件被意外破坏（非越狱app应该不会出现）
        if (!CHECK_VALID_DICTIONARY(_dict)) {
            NSLog(@"Invalid environment plist");
            return nil;
        }

        // 从dict中读取并设置APP环境变量
        [self loadEnvironmentDict:_dict];
        
        // 打印环境配置
        __block NSString *envars = @"";
        [_dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            envars = [envars stringByAppendingFormat:@"  %@: %@\n", key, obj];
        }];
        NSLog(@"%@", [NSString stringWithFormat:@"Start environment configuration\n*************** %@ ***************\n%@****************************************\n", [self cnEnvironmentNameWithEnName:_environmentName], envars]);
    }
    return self;
}

- (void)synchronize
{
    NSMutableDictionary *dict = [_dict mutableCopy];
    [dict setObject:_environmentName forKey:@"environment"];
    [dict setObject:_apiBaseURLString forKey:@"apiBaseUrl"];
    [dict writeToFile:self.configsCachePath atomically:YES];
}


- (void)loadEnvironmentDict:(NSDictionary *)dict
{
    _environmentName = dict[@"environment"];
    _appName = dict[@"appName"];
    _apiBaseURLString = dict[@"apiBaseUrl"];
    
}

-(NSString *)description{
    return _desc;
}

- (NSString *)cnEnvironmentNameWithEnName:(NSString *)enName
{
    if ([enName isEqualToString:RN_ENV_PROD])
        return @"生产环境";
    else if ([enName isEqualToString:RN_ENV_TEST])
        return @"测试环境";
    else if ([enName isEqualToString:RN_ENV_DEV])
        return @"开发环境";
    else
        return enName;
}
@end
