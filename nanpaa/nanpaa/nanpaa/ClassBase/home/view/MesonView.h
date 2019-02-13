//
//  MesonView.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/20.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoView.h"
@interface MesonView : UIView

@property (nonatomic, strong) UIImageView *setImg;
@property (nonatomic, strong) UIImageView *upImg;

@property (nonatomic, strong) VideoView *view;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *aboutLab;
@property (nonatomic, strong) UITextView *textView;

@end
