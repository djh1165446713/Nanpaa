
//
//  EditMessageController.m
//  nanpaa
//
//  Created by bianKerMacBook on 17/2/24.
//  Copyright © 2017年 bianKerMacBookDJH. All rights reserved.
//

#import "EditMessageController.h"
#define MAX_INPUT_LENGTH 50

@interface EditMessageController ()<UITextViewDelegate>

@end

@implementation EditMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initUI];
    

}

- (void)initUI{
    ______WS();
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setImage:[UIImage imageNamed:@"editBack"] forState:(UIControlStateNormal)];
    _leftNavBtn.exclusiveTouch = YES;
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.top.equalTo(wSelf.view).offset(0);
        make.width.offset(51);
        make.height.offset(51);
    }];
    
    
    _rightNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_rightNavBtn setTitle:@"Save" forState:(UIControlStateNormal)];
    [_rightNavBtn setTitleColor:RGB(223, 63, 101) forState:(UIControlStateNormal)];
    [_rightNavBtn  addTarget:self action:@selector(saveAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_rightNavBtn];
    [_rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-16);
        make.top.equalTo(wSelf.view).offset(20);
        make.width.offset(50);
        make.height.offset(24);
    }];
    
    self.aboutLab = [[UILabel alloc] init];
    self.aboutLab.text = @"about me";
    self.aboutLab.font = [UIFont systemFontOfSize:12];
    self.aboutLab.textColor = RGB(206, 206, 206);
    [self.view addSubview:self.aboutLab];
    [self.aboutLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(27);
        make.top.equalTo(wSelf.view.mas_top).offset(51);
        make.width.offset(150);
        
    }];
    
    _textView = [[UITextView alloc] init];
    _textView.textColor = RGB(102, 102, 102);
    _textView.delegate = self;
    _textView.text = self.text;
    _textView.textAlignment = NSTextAlignmentCenter;
    _textView.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(47);
        make.right.equalTo(wSelf.view.mas_right).offset(-47);
        make.top.equalTo(wSelf.view.mas_top).offset(86);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-32);

    }];
}



- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > MAX_INPUT_LENGTH) {
        textView.text = [textView.text substringToIndex:MAX_INPUT_LENGTH];
    }
   self.text = textView.text;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAction{
    ______WS();
    NSDictionary *userDic = userMessage;
    NSDictionary *par = @{@"introduce":self.text,
                          @"token":userDic[@"token"],
                          @"userid":userDic[@"userid"]};
    [[DJHttpApi shareInstance] POST:ModifyUserInfoUrl dict:par succeed:^(id data) {
        NSDictionary *dic = @{@"text":self.text};
        [[DJHManager shareManager] toastManager:@"Saved successfully" superView:wSelf.view];
        [wSelf.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"editIntroPost" object:wSelf userInfo:dic];

    } failure:^(NSError *error) {
        
    }];
}
@end
