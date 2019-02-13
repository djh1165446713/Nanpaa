
//
//  ShareHelpManage.m
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/5.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import "ShareHelpManage.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@implementation ShareHelpManage

static ShareHelpManage *shareManage = nil;

+ (ShareHelpManage *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareManage == nil) {
            shareManage = [[self alloc] init];
        }
    });
    return shareManage;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareManage == nil) {
            shareManage = [super allocWithZone:zone];
        }
    });
    return shareManage;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return shareManage;
}


- (void)shareSDKarray:(NSArray *)imageAarray shareText:(NSString *)text  shareURLString:(NSString *)urlString shareTitle:(NSString *)title {
    NSArray* imageArr = @[[UIImage imageNamed:@"placeholderImg.png"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArr) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:text
                                         images:imageArr
                                            url:[NSURL URLWithString:urlString]
                                          title:title
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        SSUIShareActionSheetController *sheet =  [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                                                          items:nil
                                                                    shareParams:shareParams
                                                            onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                                
                                                                switch (state) {
                                                                    case SSDKResponseStateSuccess:
                                                                    {
                                                                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sharing success"
                                                                                                                            message:nil
                                                                                                                           delegate:nil
                                                                                                                  cancelButtonTitle:@"OK"
                                                                                                                  otherButtonTitles:nil];
                                                                        [alertView show];
                                                                        break;
                                                                    }
                                                                    case SSDKResponseStateFail:
                                                                    {
                                                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sharing failure"
                                                                                                                        message:[NSString stringWithFormat:@"%@",error]
                                                                                                                       delegate:nil
                                                                                                              cancelButtonTitle:@"OK"
                                                                                                              otherButtonTitles:nil, nil];
                                                                        [alert show];
                                                                        break;
                                                                    }
                                                                    default:
                                                                        break;
                                                                }
                                                            }
                                                  ];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeFacebook)];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeTwitter)];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeInstagram)];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeMail)];
        [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSMS)];

    }

}


@end
