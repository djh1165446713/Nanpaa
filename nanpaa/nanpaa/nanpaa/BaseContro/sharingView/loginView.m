//
//  loginView.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/11.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "loginView.h"
@interface loginView()<UITextFieldDelegate>

@end
@implementation loginView

- (instancetype)init
{
    self = [super init];
    if (self) {
        ______WS();
        _userLabel = [[UILabel alloc] init];
        [self addSubview:_userLabel];
        _userLabel.textColor = [UIColor redColor];
        _userLabel.font = [UIFont systemFontOfSize:13];
        [_userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf).offset(0);
            make.left.equalTo(wSelf).offset(0);
            make.height.offset(15);
        }];
        
        _userText = [[UITextField alloc] init];
        _userText.delegate = self;
        [self addSubview:_userText];
        _userText.textColor = [UIColor whiteColor];
        _userText.tintColor = [UIColor redColor];
        _userText.font = [UIFont systemFontOfSize:14];
        [_userText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.userLabel.mas_bottom).offset(5);
            make.left.equalTo(wSelf).offset(0);
            make.right.equalTo(wSelf).offset(0);
            make.height.offset(20);
        }];
        
        
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        _lineView.backgroundColor = [UIColor whiteColor];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wSelf.userText.mas_bottom).offset(2);
            make.left.equalTo(wSelf).offset(0);
            make.right.equalTo(wSelf).offset(0);
            make.height.offset(1);
        }];
        
    }
    return self;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}



@end
