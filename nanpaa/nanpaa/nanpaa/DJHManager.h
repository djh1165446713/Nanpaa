//
//  DJHManager.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/29.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DJHManager : NSObject

+ (DJHManager *)shareManager;
- (void)toastManager:(NSString *)tosat superView:(UIView *)view;
-(void)showTosat:(NSString *)str superView:(UIView *)view;


@end
