//
//  DJHttpApi.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/31.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;

@interface DJHttpApi : NSObject

+ (DJHttpApi *)shareInstance;
- (void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;

- (void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;
@end
