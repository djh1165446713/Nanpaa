//
//  NearbyModel.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/7.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyModel : NSObject
@property (nonatomic, strong) NSString *avatarUrl;      // 头像URl
@property (nonatomic, strong) NSString *nickname;       // 用户昵称
@property (nonatomic, assign) double distance;      // 距离


@property (nonatomic, strong) NSString *backgroundUrl;      // 背景图URl

@property (nonatomic, strong) NSString *coin;           // 金币
@property (nonatomic, strong) NSString *indexVideoUrl;  // 用户个人视频简介URL
@property (nonatomic, strong) NSString *inputText;      // 消息内容
@property (nonatomic, strong) NSString *userid;      // id
@property (nonatomic, strong) NSString *hxAcount;      // 环信ID
//@property (nonatomic, assign) NSIndexPath *indexPath;

@end
