//
//  AppDelegate.m
//  TestSupportEnvDemo
//
//  Created by chenting on 2021/6/29.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate
 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    RN_ENVIRONMENT_INIT;
#ifdef PROD
    NSLog(@"PROD");
#elif DEV
    NSLog(@"DEV");
#elif TEST
    NSLog(@"TEST");
#else
    NSLog(@"test");
#endif

    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0){
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
            [application registerUserNotificationSettings:settings];
            [application registerForRemoteNotifications];
        } else {
            [application registerForRemoteNotificationTypes: UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge];
        }
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    }
    //【注册通知】通知回调代理（可选）
//     JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//     entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
//     [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//
//    [JPUSHService setupWithOption:launchOptions appKey:@"2da9723e0a28d39b3233151e" channel:nil apsForProduction:NO];
//    NSSet *set = [NSSet setWithArray:@[@"123456789"]];
//    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
//        if(resCode == 0)
//        {
//            // iOS10获取registrationID放到这里了, 可以存到缓存里, 用来标识用户单独发送推送
//            NSLog(@"registrationID获取成功：%@",registrationID);
////            [[NSUserDefaults standardUserDefaults] setObject:registrationID forKey:@"registrationID"];
////            [[NSUserDefaults standardUserDefaults] synchronize];
//        }
//        else
//        {
//            NSLog(@"registrationID获取失败，code：%d",resCode);
//        }
//    }];
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *devToken2 = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0) {
        devToken2 = [self stringFromDeviceToken:deviceToken];
    }
    
//    [JPUSHService registerDeviceToken:deviceToken];
}

- (NSString *)stringFromDeviceToken:(NSData *)deviceToken {
    NSUInteger length = deviceToken.length;
    if (length == 0) {
        return nil;
    }
    const unsigned char *buffer = deviceToken.bytes;
    NSMutableString *hexString  = [NSMutableString stringWithCapacity:(length * 2)];
    for (int i = 0; i < length; ++i) {
        [hexString appendFormat:@"%02x", buffer[i]];
    }
    return [hexString copy];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSLog(@"%@",apsInfo);
//    printf("\nRemote Notification: %s", apsInfo);
//
//    [[RinnaiController sharedInstance] dismissKeyboard];
//
//    if (application.applicationState == UIApplicationStateActive) {
//        [[PushServiceManager sharedInstance] processWithData:apsInfo];
//    }else {
//        [[PushServiceManager sharedInstance] processWithData:apsInfo];
//    }
}
@end
