//
//  RecommendModel.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/3.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DynamicModel.h"

@interface RecommendModel : NSObject
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, assign) BOOL isFollow;
@property (nonatomic, strong) NSString *backgroundUrl;
@property (nonatomic, strong) NSString *followerNum;
@property (nonatomic, strong) NSString *followingNum;
@property (nonatomic, strong) NSString *isFollowing;

@end
