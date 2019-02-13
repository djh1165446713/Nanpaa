//
//  BulletView.h
//  RootView
//
//  Created by bianKerMacBook on 16/8/10.
//  Copyright © 2016年 bianKerMacBook. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, MoveStatus) {
    Start,
    Enter,
    End
};

@interface BulletView : UIView

@property (nonatomic, assign)int trajectory; // 弹道
@property (nonatomic, copy) void(^moveStatusBlock)(); // 弹幕状态回调

// 弹幕label
@property (nonatomic, strong) UILabel *lbComment;
@property (nonatomic, strong) UILabel *lbNickname;
@property (nonatomic, strong) UIImageView *headerImg;

@property (nonatomic, strong) CALayer *movingLayer;

// 初始化弹幕的方法
- (instancetype)initWithComment: (NSString *)comment name:(NSString *)name imageUrl:(NSString *)iamgeUrl;

// 开始动画
- (void)startANnimation;

// 结束动画
- (void)stopAnimation;
@end
