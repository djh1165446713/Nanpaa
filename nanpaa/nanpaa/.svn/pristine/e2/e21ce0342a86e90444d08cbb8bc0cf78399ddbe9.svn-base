//
//  TKSegementedView.h
//  SampleDemo
//
//  Created by qiukai on 15/7/28.
//  Copyright (c) 2015年 TK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKSegementedItem.h"

typedef NS_ENUM(NSInteger, StatusIndex) {
    StatusIndexNormal = 0,
    StatusIndexSelected = 1
};

@interface TKSegementedView : UIView

@property (assign, nonatomic) CGFloat redLineGapRate;
@property (assign, nonatomic) CGFloat redLineHeight;
@property (assign, nonatomic) CGFloat bottomBlackLineHeight;
@property (assign, nonatomic) UIEdgeInsets verticalDividerInset;

+ (instancetype)segementedViewWithSegementedItem:(TKSegementedItem *)segementedItem, ... NS_REQUIRES_NIL_TERMINATION;

@end
