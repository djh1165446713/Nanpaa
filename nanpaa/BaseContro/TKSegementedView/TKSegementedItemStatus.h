//
//  TKSegementedItemStatus.h
//  SampleDemo
//
//  Created by qiukai on 15/8/6.
//  Copyright (c) 2015年 TK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^BecomeCurrentStatusBlock)();

@interface TKSegementedItemStatus : NSObject

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIFont *titleFont;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (copy, nonatomic) BecomeCurrentStatusBlock becomeCurrentStatusBlock;

+ (instancetype)statusWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)titleFont
                          image:(UIImage *)image
                backgroundImage:(UIImage *)backgroundImage
       becomeCurrentStatusBlock:(BecomeCurrentStatusBlock)block;

@end
