//
//  TKSegementedItem.m
//  SampleDemo
//
//  Created by qiukai on 15/8/6.
//  Copyright (c) 2015年 TK. All rights reserved.
//

#import "TKSegementedItem.h"

@implementation TKSegementedItem

+ (instancetype)itemWithNormalStatus:(TKSegementedItemStatus *)normalStatus selectedStatus:(TKSegementedItemStatus *)selectedStatus otherStatus:(NSArray *)otherStatus
{
    TKSegementedItem *item = [[TKSegementedItem alloc] init];
    item.normalStatus = normalStatus;
    item.selectedStatus = selectedStatus;
    item.otherStatus = [otherStatus mutableCopy];
    return item;
}

- (NSMutableArray *)otherStatus
{
    if (!_otherStatus) {
        _otherStatus = [NSMutableArray array];
    }
    return _otherStatus;
}

@end

