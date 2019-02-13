//
//  BulletView.m
//  RootView
//
//  Created by bianKerMacBook on 16/8/10.
//  Copyright © 2016年 bianKerMacBook. All rights reserved.
//

#import "BulletView.h"

#define Padding 5
#define imgHeightOrWidth 20

@interface BulletView()


@end


@implementation BulletView


// 初始化弹幕的方法
- (instancetype)initWithComment: (NSString *)comment name:(NSString *)name imageUrl:(NSString *)iamgeUrl
{
    if(self = [super init]){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        self.backgroundColor = RGB(173, 177, 202);
        // 计算弹幕的实际宽度
        NSDictionary *attr = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGFloat width = [comment sizeWithAttributes:attr].width;
        CGFloat widthName = [name sizeWithAttributes:attr].width;
        
        self.lbComment = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lbComment.textAlignment = NSTextAlignmentCenter;
        self.bounds = CGRectMake(0, 0, width + widthName + 50, 30);
        self.lbComment.text = comment;
        self.lbComment.userInteractionEnabled = YES;
        self.lbComment.font = [UIFont systemFontOfSize:13];
        self.lbComment.frame = CGRectMake(40 + widthName, 0, width + 2, 30);
        self.lbComment.layer.cornerRadius = 10;
        self.lbComment.layer.masksToBounds = YES;
        self.lbComment.textColor = [UIColor blackColor];
        [self.lbComment addGestureRecognizer:tap];
        [self addSubview:self.lbComment];
        
        self.lbNickname = [[UILabel alloc] initWithFrame:CGRectZero];
        self.lbNickname.userInteractionEnabled = YES;
        self.lbNickname.textAlignment = NSTextAlignmentCenter;
        self.lbNickname.text = name;
        self.lbNickname.font = [UIFont systemFontOfSize:13];
        self.lbNickname.frame = CGRectMake(40, 0, widthName, 30);
        self.lbNickname.layer.cornerRadius = 10;
        self.lbNickname.layer.masksToBounds = YES;
        self.lbNickname.textColor = RGB(212, 39, 82);
        [self addSubview:self.lbNickname];
        
        self.headerImg = [UIImageView new];
        self.headerImg.clipsToBounds = YES;
        self.headerImg.contentMode = UIViewContentModeScaleToFill;
         self.headerImg.frame = CGRectMake(0, 0, 30,30);
        self.headerImg.userInteractionEnabled = YES;
        self.headerImg.layer.cornerRadius = 15;
        self.headerImg.layer.masksToBounds = YES;
        [self.headerImg sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:[UIImage imageNamed:@"placeholderImg"]];
        [self addSubview:self.headerImg ];

        [self.lbComment addGestureRecognizer:tap];
        [self.lbNickname addGestureRecognizer:tap];
        [self.headerImg addGestureRecognizer:tap];

    }
    return self;
}
// 开始动画
- (void)startANnimation
{
    // 根据弹幕长度执行动画效果
    // 弹幕越长,弹幕速度越快
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    CGFloat duration1 = 5.0f;
    
    // 弹幕开始
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Start);
    }
    
    // 弹幕速度
    CGFloat s = screenWidth / duration1;
    
    CGFloat duration = wholeWidth / s;

    // 结束时间
    CGFloat enterDuration = CGRectGetWidth(self.bounds) / s;
//    CGFloat enterDuration = 5.0F;
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration + 1];
    

    __block CGRect frame = self.frame;
   
    [UIView animateWithDuration:duration  animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.moveStatusBlock) {
            self.moveStatusBlock(End);
        }
    }];
   
}

- (void)enterScreen{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(Enter);
    }
}


// 结束动画
- (void)stopAnimation
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    // 动画说到底都是在View 的 layer 层的上动画,移除之
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}


- (void)tapAction:(UITapGestureRecognizer *)tapGesture{
    CGPoint touchPoint = [tapGesture locationInView:self];
    if ([self.movingLayer.presentationLayer hitTest:touchPoint]) {
        NSLog(@"--------------------------");

    }
}

@end
