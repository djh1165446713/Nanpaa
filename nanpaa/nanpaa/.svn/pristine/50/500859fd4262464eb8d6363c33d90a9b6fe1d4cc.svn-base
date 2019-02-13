//
//  DJHManager.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/29.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "DJHManager.h"

@implementation DJHManager

static DJHManager *manager = nil;

+ (DJHManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [[self alloc] init];
        }
    });
    return manager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    });
    return manager;
}


- (instancetype)copyWithZone:(NSZone *)zone
{
    return manager;
}


- (void)toastManager:(NSString *)tosat superView:(UIView *)view {
    [self showTosat:tosat superView:view];
}

-(void)showTosat:(NSString *)str superView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = str;
    hud.color = RGB(23, 27, 44);
    hud.alpha = 0.8;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}


@end
