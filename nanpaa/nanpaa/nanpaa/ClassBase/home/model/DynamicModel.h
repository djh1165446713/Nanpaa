//
//  DynamicModel.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/2.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMMessage.h"
@interface DynamicModel : NSObject


@property (nonatomic, strong) NSString *videoRemote;  //视频远程路径
@property (nonatomic, strong) NSString *imageRomote;  //缩略图远程路径
@property (nonatomic, strong) NSString *localPath;  //视频本地路径
//@property (nonatomic, strong) NSString *imagelocalPath;


@property (nonatomic, strong) NSString *avatarUrl;      // 头像URl
@property (nonatomic, strong) NSString *backgroundUrl;      // 背景图URl
@property (nonatomic, assign) double distance;      // 距离
@property (nonatomic, assign) NSInteger coin;           // 金币
@property (nonatomic, strong) NSString *indexVideoUrl;  // 用户个人视频简介URL
@property (nonatomic, strong) NSString *replycoin;      // 回复价格

@property (nonatomic, strong) NSString *nickname;       // 发送者昵称
@property (nonatomic, strong) NSString *targetname;       // 接收者昵称

@property (nonatomic, strong) NSString *inputText;      // 消息内容
@property (nonatomic, strong) NSString *userid;      // id
@property (nonatomic, strong) NSString *hxAccount;      // 环信ID
@property (nonatomic, strong) NSString *introduce;      // 简介

@property (nonatomic, strong) NSString *isFollowing;      // 已经关注
@property (nonatomic, strong) NSString *isFollower;      // 是否为粉丝
@property (nonatomic, strong) NSString *price;      // 价格信息

@property (nonatomic, strong) NSString *messageId;      // 信息Id

@property (nonatomic, strong) NSString *conversationId;      // 会话Id

@property (nonatomic, strong) NSString *sendGiftTitle; // 赠送礼物

@property (nonatomic, strong) NSString *messageType; // 消息类型

@property (nonatomic, strong) NSString *typeMessage; // 消息类型


@property (nonatomic, assign) BOOL isRead;      //是否已读
@property (nonatomic, strong) EMMessage *message; //消息
@property (nonatomic, assign) NSIndexPath *indexPath;

@end
