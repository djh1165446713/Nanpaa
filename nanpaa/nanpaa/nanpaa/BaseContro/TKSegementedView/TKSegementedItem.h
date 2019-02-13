//
//  TKSegementedItem.h
//  SampleDemo
//
//  Created by qiukai on 15/8/6.
//  Copyright (c) 2015年 TK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKSegementedItemStatus.h"

@interface TKSegementedItem : NSObject

@property (strong, nonatomic) TKSegementedItemStatus *normalStatus;
@property (strong, nonatomic) TKSegementedItemStatus *selectedStatus;
@property (strong, nonatomic) NSMutableArray *otherStatus;
/**
 *  statusIndex
 *  normal = 0, selected = 1, others > 2
 */
//@property (copy, nonatomic) void(^clickBlock)(NSInteger statusIndex);

+ (instancetype)itemWithNormalStatus:(TKSegementedItemStatus *)normalStatus selectedStatus:(TKSegementedItemStatus *)selectedStatus otherStatus:(NSArray *)otherStatus;

//- (void)setClickBlock:(void (^)(NSInteger statusIndex))clickBlock;

@end

