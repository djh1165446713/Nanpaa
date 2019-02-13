//
//  AppDelegate.m
//  隐藏NacVCBar
//
//  Created by bianKerMacBook on 16/8/12.
//  Copyright © 2016年 bianKerMacBook. All rights reserved.
//
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)



#import "AppDelegate.h"
#import "KBTabbarController.h"
#import "LoginViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>
#import <AdSupport/ASIdentifierManager.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "EMSDK.h"
#import "Reachability.h"

#define urlPhone @"app/startup/saveLog"
@interface AppDelegate ()<EMChatManagerDelegate>
{
    CTTelephonyNetworkInfo *phoneInfo;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [[NSUserDefaults standardUserDefaults] setObject:@"appRunningNow" forKey:@"app"];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                            settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];

    
    BOOL switOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"pushOn"];
    if (switOn) {
        EMPushOptions *options = [[EMClient sharedClient] pushOptions];
        options.noDisturbStatus = EMPushNoDisturbStatusClose;
        //        options.noDisturbingStartH = 9;
        //        options.noDisturbingEndH = 22;
        EMError *error = [[EMClient sharedClient] updatePushOptionsToServer];
        NSLog(@" ----关闭 OR 打开push通知的错误 %@ --------- ",error);
    }else {
        EMPushOptions *options = [[EMClient sharedClient] pushOptions];
        options.noDisturbStatus = EMPushNoDisturbStatusClose;
        EMError *error = [[EMClient sharedClient] updatePushOptionsToServer];
        NSLog(@" ----关闭 OR 打开push通知的错误 %@ --------- ",error);
    }
    
//    AppKey:注册的AppKey，
//    apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"videoartists#nanpaa"];
    options.apnsCertName = @"nanpaaDEV";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    

    
    //iOS8 注册APNS
    if ([application respondsToSelector:@selector(registerForRemoteNotifications)]) {
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    else{
        [application registerForRemoteNotifications];
        UIUserNotificationType notificationTypes = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound |
        UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:notificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    

    // 获取用户SIM卡信息
    phoneInfo = [[CTTelephonyNetworkInfo alloc] init];
    NSString *countryMCC = phoneInfo.subscriberCellularProvider.mobileCountryCode;
    [[NSUserDefaults standardUserDefaults] setObject:countryMCC forKey:@"mcc"];
    NSString *networkMNC = phoneInfo.subscriberCellularProvider.mobileNetworkCode;
    phoneInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier * carrier)
    {
        // 当用户更换 SIM 卡时会调用这个回调
    };

    
    // 获取唯一标识,苹果私有API获取IMEI号,可能会改变
    NSString *identifierForAd = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    // 手机型号收集
    NSString *phoneModel = [[UIDevice currentDevice] model];
    
    // 系统版本
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    // 获取应用的版本
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];

   
    // 获取数据连接状态/网络类型
    NSString *interNet = [self internetStatus];
    NSString *userid = @"";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user"] == nil) {
        userid = @"";
    }else {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        userid = dic[@"userid"];
    }
    
    // 获取系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSString *zoneStr = [NSString stringWithFormat:@"%@",zone];
    NSDictionary *par = @{@"appVersion":appVersion,
                          @"channelCode":@"",
                          @"deviceId":identifierForAd,
                          @"imei":identifierForAd,
                          @"imsi":identifierForAd,
                          @"mcc":countryMCC,
                          @"mnc":networkMNC,
                          @"model":phoneModel,
                          @"networkType":interNet,
                          @"osVersion":phoneVersion,
                          @"timeZone":zoneStr,
                          @"userid":userid};
    
    [[DJHttpApi shareInstance] POST:SaveLogUrl dict:par succeed:^(id data) {
        NSLog(@"%@",data);
    } failure:^(NSError *error) {
        
    }];
    
    
    [ShareSDK registerApp:@"18135308fcbb0"
          activePlatforms:@[@(SSDKPlatformTypeTwitter),
                            @(SSDKPlatformTypeInstagram),
                            @(SSDKPlatformTypeFacebook),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),]
                 onImport:^(SSDKPlatformType platformType)
     {     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeFacebook:
                 [appInfo SSDKSetupFacebookByApiKey:@"1674127226236747" appSecret:@"85c9100f6749e18ac2d1ced475622576" authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeTwitter:
                 [appInfo SSDKSetupTwitterByConsumerKey:@"LRBM0H75rWrU9gNHvlEAA2aOy" consumerSecret:@"gbeWsZvA9ELJSdoBzJ5oLKX0TU09UOwrzdGfo9Tg7DjyGuMe8G" redirectUri:@"http://mob.com"];
                 break;
            
            case SSDKPlatformTypeInstagram:
                 [appInfo SSDKSetupInstagramByClientID:@"" clientSecret:@"" redirectUri:@""];
                 break;
             default:
                 break;
         }
     }];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user"] != nil) {
        self.window.rootViewController = [[KBTabbarController alloc] init];

    }else {
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        
    }
    [self.window makeKeyAndVisible];

    return YES;
}


#pragma mark - 获取网络状态
- (NSString *)internetStatus {
    
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.apple.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"wifi";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"wifi";
            break;
            
        case ReachableViaWWAN:
            net = @"wwan";
            break;
            
        case NotReachable:
            net = @"notReachable";
            
        default:
            break;
    }
    
    return net;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];
    
}


// APP 将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[EMClient sharedClient] bindDeviceToken:deviceToken];
}

// 注册deviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"error -- %@",error);
}



-(NSString *)showText:(NSString *)key
{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLanguage"];
    if ( language == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        return [[NSBundle bundleWithPath:path] localizedStringForKey:key value:nil table:@"NanpaaLanguage"];
    }else {
        NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
        return [[NSBundle bundleWithPath:path] localizedStringForKey:key value:nil table:@"NanpaaLanguage"];
    }
    
}



@end
