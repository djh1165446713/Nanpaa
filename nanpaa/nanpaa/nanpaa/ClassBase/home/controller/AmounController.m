//
//  AmounController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/10.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "AmounController.h"
#import "KVTimer.h"
#import "EFCircularSlider.h"

@interface AmounController ()

@property (nonatomic, strong) UILabel *titleAbout;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) EFCircularSlider* circularSlider;

@property (nonatomic, strong) NSDictionary *peopleDic;
@end

@implementation AmounController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = @"Amount To Reply";
//    self.titleLabel.text = CustomStr(@"CeShiText");

    _peopleDic = userMessage;
    self.view.backgroundColor = RGB(18, 21, 33);
    [self initUI];
}

- (void)initUI {
    ______WS();
    
    CGRect sliderFrame = CGRectMake(60, 150, 300, 300);
    _circularSlider = [[EFCircularSlider alloc] initWithFrame:sliderFrame];
    _circularSlider.handleType = bigCircle;
    [_circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_circularSlider];
    [_circularSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(300);
        make.centerX.equalTo(wSelf.view);
        make.centerY.equalTo(wSelf.view);
        
    }];
    

    _valueLab = [[UILabel alloc] init];
    _valueLab.textAlignment = NSTextAlignmentCenter;
    _valueLab.font = [UIFont systemFontOfSize:35];
    _valueLab.textColor = [UIColor whiteColor];
    [self.view addSubview:_valueLab];
    [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.centerX.equalTo(wSelf.view);
        make.centerY.equalTo(wSelf.view);
        make.height.offset(36);

    }];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:_peopleDic[@"userid"]] != nil) {
        
        _valueLab.text = [[NSUserDefaults standardUserDefaults] objectForKey:_peopleDic[@"userid"]];
    }
    
    _titleAbout = [[UILabel alloc] init];
    _titleAbout.textAlignment = NSTextAlignmentCenter;
    _titleAbout.text = @"This is the amount of Nanpaa points for someone to reply your message";
    _titleAbout.lineBreakMode = NSLineBreakByTruncatingTail;
    _titleAbout.numberOfLines = 0;
    _titleAbout.textColor = [UIColor whiteColor];
    _titleAbout.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_titleAbout];
    [_titleAbout mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.top.equalTo(wSelf.circularSlider.mas_bottom).offset(40);
        make.height.offset(50);
        make.width.offset(300);
    }];

    
    _submitButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _submitButton.backgroundColor = RGB(212, 39, 82);
    [_submitButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_submitButton setTitle:@"Submit" forState:(UIControlStateNormal)];
    [self.view addSubview:_submitButton];
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
        make.width.offset(kScreenWidth);
        make.height.offset(60);
    }];
}


-(void)valueChanged:(EFCircularSlider*)slider {
//    float value = slider.currentValue * 5;
    NSInteger value = roundf(slider.currentValue);
    _valueLab.text = [NSString stringWithFormat:@"%ld",(long)value * 5];
}


- (void)submitAction {
    [[NSUserDefaults standardUserDefaults] setObject:_valueLab.text forKey:_peopleDic[@"userid"]];
    [[DJHManager shareManager] toastManager:@"save success" superView:windowKey];
}

@end
