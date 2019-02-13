//
//  UIScrollView+TouchAction.m
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/18.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import "UIScrollView+TouchAction.h"

@implementation UIScrollView (TouchAction)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.dragging)
        [self.nextResponder touchesEnded: touches withEvent:event];
    else
        [super touchesEnded: touches withEvent: event];
}


@end
