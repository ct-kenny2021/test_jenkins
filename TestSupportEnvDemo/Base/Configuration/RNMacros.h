//
//  RNMacros.h
//  Rinnai
//
//  Created by chenting on 2021/1/24.
//  Copyright © 2021 Hadlinks. All rights reserved.
//

#ifndef RNMacros_h
#define RNMacros_h

// W H
#define kSCREEN_SIZE [UIScreen mainScreen].bounds.size
#define kSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kIphone6ScaleWidth kSCREEN_WIDTH/375.0
#define kIphone6ScaleHeight kSCREEN_HEIGHT/667.0
#define kStandandIphone6ScaleHeight(h) (h * kIphone6ScaleHeight)
#define kStandandIphone6ScaleWidth(w) (w * kIphone6ScaleHeight)

#define kLeftMargin  (kSCREEN_WIDTH < 375) ? 15 : 30
#define kSTATUS_H    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?44:20) // 适配刘海屏状态栏
#define kTABBAR_H    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) // 适配刘海屏底栏高度
#define kBOTTOM_H    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)  // 适配刘海屏底部多出来的高度

//----------------判断当前的iPhone设备/系统版本---------------
// 判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//----------------判断系统版本---------------
// 获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
// 判断 iOS 9 或更高的系统版本
#define IOS_VERSION_9_OR_LATER           ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
// 判断 iOS 10 或更高的系统版本
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=10.0)? (YES):(NO))
// 判断 iOS 12 或更高的系统版本
#define IOS_VERSION_12_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=12.0)? (YES):(NO))


//----------------判断机型 根据尺寸---------------
// 判断是否为 iPhone 4/4S - 3.5 inch
#define IS_IPHONE4_4S [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 480.0f
// 判断是否为 iPhone 5/5SE - 4.0 inch
#define IS_IPHONE5_5S [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6S/7/8 - 4.7 inch
#define IS_IPHONE6_6S [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone 6Plus/6SPlus/7P/8P - 5.5 inch
#define IS_IPHONE6PLUS_6SPLUS [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f
// 判断是否为iPhoneX - 5.8 inch
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为iPhoneXS - 5.8 inch
#define IS_IPHONE_XS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为iPhoneXR - 6.1 inch
#define IS_IPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为iPhoneXS MAX - 6.5 inch
#define IS_IPHONE_XSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONE_6_OR_BIGGER (kSCREEN_HEIGHT >= 667.0 && !IS_IPHONE5_5S)
#define IS_STANDARD_IPHONE_X  (IS_IPHONE && LiuHaiPhone)

// 主要是用于区分是否是 刘海屏
#define LiuHaiPhone \
({BOOL isLiuHaiPhone = NO;\
if (@available(iOS 11.0, *)) {\
isLiuHaiPhone = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isLiuHaiPhone);})

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

//--------------沙盒目录文件路径---------------
// 获取沙盒主目录路径
#define RN_Path_Home = NSHomeDirectory();
//获取沙盒 Document
#define RN_Path_Document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Library
#define RN_Path_Library [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//获取沙盒 Cache
#define RN_Path_Cache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//获取temp
#define RN_Path_Temp NSTemporaryDirectory()

//--------------生成随机数---------------
#define RN_RandNum(i) arc4random()%i   // [0,i) 范围内随机数
#define RN_RandNum_FromTo(i,j) (i + (arc4random() % (j – i + 1)))

//---------------Colour-------------------
// 设置随机颜色
#define RN_RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
// 设置RGB颜色/设置RGBA颜色
#define RN_RGBAColor(r, g, b, a)  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RN_RGBColor(r, g, b)      LXRGBAColor(r,g,b,1.0f)
// 十六进制数值 eg:@"#3499DB"
#define RN_COLOR_WITH_HEX [UIColor colorFromHexString: hexValue]
#define RN_COLOR_WITH_HEX_1(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define SY_WATER_TITLE   @"反渗透直饮机"

//-------------- NSLog在release下不输出 ---------------
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

//-------------- 浮点数比较操作宏（不要使用==、!=来判断浮点数） -------------------
#define FLT_EQUAL(a, b) (fabs((a) - (b)) < FLT_EPSILON)
#define FLT_EQUAL_ZERO(a) (fabs(a) < FLT_EPSILON)

#define DBL_EQUAL(a, b) (fabs((a) - (b)) < DBL_EPSILON)
#define DBL_EQUAL_ZERO(a) (fabs(a) < DBL_EPSILON)

//------------ 创建imageview  ---------------------
#define RN_IMAGE(imageKey) ([UIImage imageNamed:(imageKey)])
//-------------- 非法数据检查宏 -------------------
#define CHECK_VALID_STRING(__aString)               (__aString && [__aString isKindOfClass:[NSString class]] && [__aString length])
#define CHECK_VALID_DATA(__aData)                   (__aData && [__aData isKindOfClass:[NSData class]] && [__aData length])
#define CHECK_VALID_NUMBER(__aNumber)               (__aNumber && [__aNumber isKindOfClass:[NSNumber class]])
#define CHECK_VALID_ARRAY(__aArray)                 (__aArray && [__aArray isKindOfClass:[NSArray class]] && [__aArray count])
#define CHECK_VALID_DICTIONARY(__aDictionary)       (__aDictionary && [__aDictionary isKindOfClass:[NSDictionary class]] && [__aDictionary count])

//--------------  各型数据默认值宏 -------------------
#define DEFAULT_STRING                              (@"")
#define DEFAULT_NUMBER                              ([NSNumber numberWithInteger:0])
#define DEFAULT_ARRAY                               ([NSArray array])
#define DEFAULT_DICTIONARY                          ([NSDictionary dictionary])

//--------------  单例定义和实现宏 -------------------
#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    IMP_SINGLETON
#define IMP_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}


//
// ARC下performSelector无法编译通过
//
#define RN_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#endif /* RNMacros_h */
