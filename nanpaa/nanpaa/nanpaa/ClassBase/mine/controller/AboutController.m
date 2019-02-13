//
//  AboutController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/4.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(18, 21, 33);
    self.titleLabel.text = @"About";
    [self initUI];
    
}


- (void)initUI {
    ______WS();
    
    _iconImg = [[UIImageView alloc] init];
    _iconImg.image = [UIImage imageNamed:@"NANPAA"];
    [self.view addSubview:_iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.bgView.mas_bottom).offset(80);
        make.height.offset(80);
        make.width.offset(100);
    }];
    
    
    _labelOne = [[UILabel alloc] init];
    _labelOne.textColor = [UIColor whiteColor];
    _labelOne.text = @"V1.0.1";
    _labelOne.textAlignment = NSTextAlignmentCenter;
    _labelOne.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_labelOne];
    [_labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.offset(kScreenWidth);
        make.height.offset(20);
        make.top.equalTo(wSelf.iconImg.mas_bottom).offset(80);
    }];
    
    
    
    _labelTwo = [[UILabel alloc] init];
    _labelTwo.textAlignment = NSTextAlignmentCenter;
    _labelTwo.text = @"Copyright 2016 Nanpaa all rights reserved";
    _labelTwo.lineBreakMode = UILineBreakModeWordWrap;
    _labelTwo.numberOfLines = 0;
    
    _labelTwo.textColor = [UIColor whiteColor];
    _labelTwo.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_labelTwo];
    [_labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.offset(kScreenWidth - 100);
        make.height.offset(50);
        make.top.equalTo(wSelf.labelOne.mas_bottom).offset(20);
    }];
    
    
    _labelThree = [[UILabel alloc] init];
    _labelThree.textColor = [UIColor whiteColor];
    _labelThree.text = @"For more information visit";
    _labelThree.textAlignment = NSTextAlignmentCenter;
    _labelThree.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_labelThree];
    [_labelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.offset(kScreenWidth);
        make.height.offset(20);
        make.top.equalTo(wSelf.labelTwo.mas_bottom).offset(24);
    }];
    
    
    _labelFour = [[UILabel alloc] init];
    _labelFour.textColor = RGB(212, 39, 82);
    _labelFour.text = @"www.nanpaa.com";
    _labelFour.textAlignment = NSTextAlignmentCenter;
    _labelFour.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_labelFour];
    [_labelFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.offset(kScreenWidth);
        make.height.offset(20);
        make.top.equalTo(wSelf.labelThree.mas_bottom).offset(18);
    }];
    
    _labelFive = [[UILabel alloc] init];
    _labelFive.textColor = [UIColor whiteColor];
    _labelFive.text = @"For support";
    _labelFive.textAlignment = NSTextAlignmentCenter;
    _labelFive.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_labelFive];
    [_labelFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.offset(kScreenWidth);
        make.height.offset(20);
        make.top.equalTo(wSelf.labelFour.mas_bottom).offset(24);
    }];
    
    
    _labelSix = [[UILabel alloc] init];
    _labelSix.textColor = RGB(212, 39, 82);
    _labelSix.text = @"nanpaa@bianker.com";
    _labelSix.textAlignment = NSTextAlignmentCenter;
    _labelSix.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_labelSix];
    [_labelSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.offset(kScreenWidth);
        make.height.offset(20);
        make.top.equalTo(wSelf.labelFive.mas_bottom).offset(18);
    }];
    
}



@end
