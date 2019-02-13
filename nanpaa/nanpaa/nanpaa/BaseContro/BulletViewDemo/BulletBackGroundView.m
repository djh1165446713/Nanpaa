
//
//  BulletBackGroundView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/12/26.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "BulletBackGroundView.h"
#import "BulletView.h"

@implementation BulletBackGroundView

- (instancetype)init{
    if (self = [super init]) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (BulletView *)findClickBulletView:(CGPoint)point{
    BulletView *bulletView = nil;
    for (UIView *view in [self subviews]) {
        if ([view isKindOfClass:[BulletView class]]) {
            if ([view.layer.presentationLayer hitTest:point]) {
                bulletView = (BulletView *)view;
                break;
            }
        }
    }
    return bulletView;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if ([self findClickBulletView:point]) {
        return self;
    }
    return nil;
}


- (void)dealTapGesture:(UITapGestureRecognizer *)gesture block:(void (^)(BulletView *))block{
    CGPoint clickPoint = [gesture locationInView:self];
    BulletView *bulletView = [self findClickBulletView:clickPoint];
    if (bulletView) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((0.2 * NSEC_PER_SEC) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        });
        
        if (block) {
            block(bulletView);
        }
    }
}
@end
