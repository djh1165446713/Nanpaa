//
//  BulletBackGroundView.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/12/26.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BulletView;
@interface BulletBackGroundView : UIView
- (void)dealTapGesture:(UITapGestureRecognizer *)gesture block:(void(^)(BulletView *bulletView))block;
@end
