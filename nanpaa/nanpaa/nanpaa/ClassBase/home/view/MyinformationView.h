//
//  MyinformationView.h
//  nanpaa
//
//  Created by bianKerMacBook on 17/1/17.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyinformationView : UIView

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *headImgBtn;
@property (nonatomic, strong) UILabel *userNameLab;

@property (nonatomic, strong) UIImageView *shareIcon;

@property (nonatomic, strong) UIImageView *pointCoin;
@property (nonatomic, strong) UILabel *pointLab;
@property (nonatomic, strong) UIImageView *incomeCoin;
@property (nonatomic, strong) UILabel *incomeLab;

@property (nonatomic, strong) UILabel *pointNum;
@property (nonatomic, strong) UILabel *incomeNum;

@property (nonatomic, strong) UIButton *buyBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *gzLab;
@property (nonatomic, strong) UILabel *fsLab;

@property (nonatomic, strong) UIButton *gzBtn;
@property (nonatomic, strong) UIButton *fsBtn;
@end
