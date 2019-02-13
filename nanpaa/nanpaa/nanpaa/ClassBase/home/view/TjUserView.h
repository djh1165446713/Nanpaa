//
//  TjUserView.h
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/17.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TjUserView : UIView
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) BOOL isFollow;
@end
