//
//  UIView+Extension.m
//  SampleDemo
//
//  Created by qiukai on 15/6/17.
//  Copyright (c) 2015年 TK. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)adjustFrameX:(CGFloat)xOffset
{
    CGRect frame = self.frame;
    frame.origin.x += xOffset;
    self.frame = frame;
}

- (void)adjustY:(CGFloat)yOffset
{
    CGRect frame = self.frame;
    frame.origin.y += yOffset;
    self.frame = frame;
}

- (void)adjustFrameWidth:(CGFloat)widthOffset
{
    CGRect frame = self.frame;
    frame.size.width += widthOffset;
    self.frame = frame;
}

- (void)adjustFrameWidth:(CGFloat)widthOffset alignment:(UIControlContentHorizontalAlignment)alignment
{
    CGRect frame = self.frame;
    frame.size.width += widthOffset;
    
    if (alignment == UIControlContentHorizontalAlignmentRight)
        frame.origin.x += -widthOffset;
    else if (alignment == UIControlContentHorizontalAlignmentCenter)
        frame.origin.x += roundf(-widthOffset / 2);
    
    self.frame = frame;
}

- (void)adjustFrameHeight:(CGFloat)heightOffset
{
    CGRect frame = self.frame;
    frame.size.height += heightOffset;
    self.frame = frame;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)batchAddSubview:(UIView *)subview, ...
{
    va_list arguments;
    id eachObject;
    if (subview) {
        va_start(arguments, subview);
        
        while ((eachObject = va_arg(arguments, id))) {
            [self addSubview:subview];
        }
        va_end(arguments);
    }
}

- (void)batchAddSubviews:(NSArray *)subviews
{
    for (id obj in subviews) {
        if ([obj isKindOfClass:[UIView class]]) {
//            [(UIView *)obj setBackgroundColor:MSRandomColor];
            [self addSubview:(UIView *)obj];
        } else {
            NSAssert(NO, @"参数必须全是UIView类型的对象");
        }
    }
}
#pragma mark - 转换成纯色图片
- (UIImage *)imageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();    CGContextSetFillColorWithColor(context, [color CGColor]);    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();    UIGraphicsEndImageContext();
    return img;
}


@end
