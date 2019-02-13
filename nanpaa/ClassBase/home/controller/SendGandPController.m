//
//  SendGandPController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/9.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "SendGandPController.h"
#import "KVTimer.h"
#import "PayMentController.h"
#import "EFCircularSlider.h"
@interface SendGandPController ()<KVTimerDelegate,UITextViewDelegate>

@property (nonatomic, strong)UILabel *toLabel;
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIView *line1;
@property (nonatomic, strong)UITextView *meesageText;
@property (nonatomic, strong)UIView *line2;
@property (nonatomic, strong)UIButton *sendButton;;
@property (nonatomic, strong) NSString *replyCoin;
@property (nonatomic, strong) EFCircularSlider* circularSlider;

@end

@implementation SendGandPController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"Gift Nanpaa Points";
    self.view.backgroundColor = RGB(23, 27, 44);
    [self initUI];
}

- (void)initUI{
    ______WS();
    _toLabel = [[UILabel alloc] init];
    _toLabel.font = [UIFont systemFontOfSize:16];
    _toLabel.text = @"To:";
    _toLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_toLabel];
    [_toLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(20);
        make.top.equalTo(wSelf.view.mas_top).offset(70);
        make.width.height.offset(30);
        
    }];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.text = _model.nickname;
    _nameLabel.textColor = RGB(212, 39, 82);
    [self.view addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.toLabel.mas_right).offset(10);
        make.centerY.equalTo(wSelf.toLabel);
        make.right.equalTo(wSelf.view.mas_right).offset(-10);
        make.height.offset(30);
    }];
    

    _line1= [[UIView alloc] init];
    _line1.backgroundColor = RGB(213, 217, 220);
    [self.view addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.toLabel.mas_bottom).offset(15);
    }];
    

    _meesageText = [[UITextView alloc] init];
    _meesageText.textColor = [UIColor whiteColor];
    _meesageText.delegate = self;
    _meesageText.backgroundColor = [UIColor clearColor];
    _meesageText.textAlignment = NSTextAlignmentLeft;
    _meesageText.font = [UIFont systemFontOfSize:14];
    _meesageText.text = @"leave a message...";
    [self.view addSubview:_meesageText];
    [_meesageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.line1.mas_bottom).offset(15);
        make.height.offset(200);
        make.centerX.equalTo(wSelf.view);
        make.width.offset(kScreenWidth - 40);
    }];
    
    _line2= [[UIView alloc] init];
    _line2.backgroundColor =RGB(83, 83, 83);
    [self.view addSubview:_line2];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.meesageText.mas_bottom).offset(10);
    }];
    
    
    
    CGRect sliderFrame = CGRectMake(60, 150, 250, 250);
    _circularSlider = [[EFCircularSlider alloc] initWithFrame:sliderFrame];
    _circularSlider.handleType = bigCircle;
    [_circularSlider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_circularSlider];
    [_circularSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(250);
        make.top.equalTo(wSelf.line2.mas_bottom).offset(20);
        make.centerX.equalTo(wSelf.view);
        
    }];
    
    
    _valueLab = [[UILabel alloc] init];
    _valueLab.textAlignment = NSTextAlignmentCenter;
    _valueLab.font = [UIFont systemFontOfSize:35];
    _valueLab.textColor = [UIColor whiteColor];
    [self.view addSubview:_valueLab];
    [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.centerX.equalTo(wSelf.circularSlider);
        make.centerY.equalTo(wSelf.circularSlider);
        make.height.offset(36);
        
    }];
    
    
    _sendButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _sendButton.layer.borderColor = RGB(211, 39, 82).CGColor;
//    _sendButton.layer.borderWidth = 1;
    _sendButton.backgroundColor =  RGB(211, 39, 82);
    [_sendButton setTitle:@"Send" forState:(UIControlStateNormal)];
    [_sendButton addTarget:self action:@selector(SendAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_sendButton ];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40);
        make.width.offset(kScreenWidth);
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
    }];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _meesageText.text = @"";
}


- (void)SendAction {
    ______WS();
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    NSDictionary *messgeDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *messgeDic1 = [NSMutableDictionary dictionary];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:userDic[@"userid"]] == nil) {
        _replyCoin = @"200";
        
    }else{
        _replyCoin = [[NSUserDefaults standardUserDefaults] objectForKey:userDic[@"userid"]];
    }
    
    [messgeDic1 setObject:_replyCoin forKey:@"replycoin"];
    [messgeDic1 setObject:messgeDic[@"avatarUrl"] forKey:@"avatarUrl"];
    [messgeDic1 setObject:messgeDic[@"nickname"] forKey:@"nickname"];
    [messgeDic1 setObject:_meesageText.text forKey:@"inputText"];
    [messgeDic1 setObject:userDic[@"userid"] forKey:@"userid"];
    [messgeDic1 setObject:from forKey:@"hxAccount"];
    [messgeDic1 setObject:@"3" forKey:@"typeMessage"];
    [messgeDic1 setObject:_valueLab.text forKey:@"price"];

    NSString *price = _valueLab.text ;
    NSString *coin = [NSString stringWithFormat:@"%@",messgeDic[@"coin"]];
//    NSString *incoin = [NSString stringWithFormat:@"%@",messgeDic[@"income"]];

    if ([coin integerValue] > [price integerValue] == YES ) {
        // 生成message
        EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:self.meesageText.text];
        EMMessage *message = [[EMMessage alloc] initWithConversationID:_model.hxAccount from:from to:_model.hxAccount body:body ext:messgeDic1];
        message.chatType = EMChatTypeChat;// 设置为单聊消息
        [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
        } completion:^(EMMessage *message, EMError *error) {
            NSDictionary *par = @{@"coin":price,
                                  @"targetId":_model.userid,
                                  @"type":@"3",
                                  @"token":userDic[@"token"],
                                  @"userid":userDic[@"userid"]};
            [[DJHttpApi shareInstance] POST:payMentUrl dict:par succeed:^(id data) {
                [[DJHManager shareManager] toastManager:@"Sending successful" superView:windowKey];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"postUpdateMessage" object:wSelf userInfo:messgeDic1];
                [wSelf.navigationController popViewControllerAnimated:YES];
            }failure:^(NSError *error) {
            }];
        }];
    }else {
        NSLog(@"-------------可使用金币不足------------");
        self.hidesBottomBarWhenPushed = YES;
        PayMentController *vc = [[PayMentController alloc] init];
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    }
}

-(void)valueChanged:(EFCircularSlider*)slider {
    //    float value = slider.currentValue * 5;
    NSInteger value = roundf(slider.currentValue);
    NSLog(@"%f",slider.currentValue);
    _valueLab.text = [NSString stringWithFormat:@"%ld",(long)value * 5];
}


@end
