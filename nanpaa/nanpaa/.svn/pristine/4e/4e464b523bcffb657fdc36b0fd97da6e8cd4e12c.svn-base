//
//  TKSegementedItemStatus.m
//  SampleDemo
//
//  Created by qiukai on 15/8/6.
//  Copyright (c) 2015年 TK. All rights reserved.
//

#import "TKSegementedItemStatus.h"

@implementation TKSegementedItemStatus

+ (instancetype)statusWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)titleFont
                          image:(UIImage *)image
                backgroundImage:(UIImage *)backgroundImage
       becomeCurrentStatusBlock:(BecomeCurrentStatusBlock)block
{
    TKSegementedItemStatus *status = [[TKSegementedItemStatus alloc] init];
    status.title = [title copy];
    status.image = image;
    status.backgroundImage = backgroundImage;
    
    if (titleColor) {
        status.titleColor = titleColor;
    }
    
    if (titleFont) {
        status.titleFont = titleFont;
    }
    
    if (block) {
        status.becomeCurrentStatusBlock = block;
    }
    
    return status;
}

- (instancetype)init
{
    if (self = [super init]) {
        _titleColor = [UIColor blackColor];
        _titleFont = [UIFont systemFontOfSize:17.0];
    }
    return self;
}

@end

