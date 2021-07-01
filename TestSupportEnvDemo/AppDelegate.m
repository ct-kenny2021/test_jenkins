//
//  AppDelegate.m
//  TestSupportEnvDemo
//
//  Created by chenting on 2021/6/29.
//

#import "AppDelegate.h"
#import "RNEnvironment.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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
//    01001011
    //01010011
    UInt8 mode = Hex2UInt8(@"53");
    BOOL openMode = mode & 0x01; //开关
    BOOL seasonMode = mode & 0x02; //冬暖键
    BOOL energyMode = mode & 0x08; //节能模式
    BOOL outdoorMode = mode & 0x10; //外出模式
    BOOL timingMode = mode & 0x20; //预约模式
    BOOL rapidHeatingMode = mode & 0x40; //快速采暖
    return YES;
}

/** 十六进制字符串转字节数 */
UInt8 Hex2UInt8(NSString *str) {
    UInt8 byte = 0x00;
    Hex2UInt8s(str, &byte);
    return byte;
}
/** 十六进制字符串转字节数组 */
void Hex2UInt8s(NSString *str, UInt8 *bytes) {
    NSUInteger size = str.length;
    NSData *data = [[str uppercaseString] dataUsingEncoding:NSASCIIStringEncoding];
    UInt8 *buffer = (UInt8 *)[data bytes];
    for (int i = 0, j = 0; j < size - 1; ++ i, j += 2) {
        UInt8 a = buffer[j], b = buffer[j + 1];
        UInt8 high = (a >= 'A') ? (a - 'A' + 10) : (a - '0' + 0);
        UInt8 low = (b >= 'A') ? (b - 'A' + 10) : (b - '0' + 0);
        bytes[i] = (high << 4 | low);
    }
}
@end
