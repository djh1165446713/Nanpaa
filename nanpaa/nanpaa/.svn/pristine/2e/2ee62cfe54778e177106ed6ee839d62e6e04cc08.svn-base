//
//  BulletManager.h
//  RootView
//
//  Created by bianKerMacBook on 16/8/10.
//  Copyright © 2016年 bianKerMacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BulletView;
@interface BulletManager : NSObject

// 弹幕的数据来源
@property (nonatomic, strong)NSMutableArray *dataSouce;


@property (nonatomic, copy) void(^generateViewBlock)(BulletView *view);

// 弹幕开始执行
- (void)start;

// 弹幕停止执行
- (void)stop;

@end
