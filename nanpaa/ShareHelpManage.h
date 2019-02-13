//
//  ShareHelpManage.h
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/5.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareHelpManage : NSObject
+ (ShareHelpManage *)shareInstance;

- (void)shareSDKarray:(NSArray *)imageAarray shareText:(NSString *)text  shareURLString:(NSString *)urlString shareTitle:(NSString *)title;

@end
