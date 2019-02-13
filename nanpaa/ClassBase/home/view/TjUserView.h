//
//  TjUserView.h
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/17.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendModel.h"
#import "DynamicModel.h"

@interface TjUserView : UIView
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UIImageView *lineView2;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *followBtn;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView  *backImg;
@property (nonatomic, strong) UIImageView  *headIconImg;
@property (nonatomic, strong) UILabel *followLab;
@property (nonatomic, strong) UILabel *fowllowingLab;
@property (nonatomic, strong) DynamicModel *model;
@property (nonatomic, assign) BOOL isFollow;
@end
