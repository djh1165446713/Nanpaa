//
//  ChooserUserController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/27.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "ChooserUserController.h"
#import "ChooseUserCell.h"
#import "ChooserModel.h"
#import "MessageController.h"
#import "SheZhiPointController.h"
@interface ChooserUserController ()<UITableViewDelegate,UITableViewDataSource,deleteChooseUserDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *broadcastBuuton;

@property (nonatomic, strong) UILabel *toLab;

@property (nonatomic, strong) UILabel *peopleLab;

@property (nonatomic, strong) NSDictionary *userDic;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *sendArr;
@property (nonatomic, strong) NSString *replyCoin;
@end

@implementation ChooserUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    _sendArr = [NSMutableArray array];

//    NSLog(@"%lu",(unsigned long)_sendArr.count);
    
    self.view.backgroundColor = RGB(18, 21, 33);
    self.titleLabel.text = @"Recipient";
    [self loadData];

    [self initUI];
}


- (void)initUI{
    
    ______WS();
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 110) style:(UITableViewStyleGrouped)];
    _tableView.backgroundColor = RGB(18, 21, 33);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[ChooseUserCell class] forCellReuseIdentifier:@"chooseCell"];
    
    
    _broadcastBuuton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _broadcastBuuton.backgroundColor = RGB(212, 39, 82);
    [_broadcastBuuton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_broadcastBuuton addTarget:self action:@selector(broadSendAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_broadcastBuuton setTitle:@"Broadcast" forState:(UIControlStateNormal)];
    [self.view addSubview:_broadcastBuuton];
    [_broadcastBuuton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(0);
        make.width.offset(kScreenWidth);
        make.height.offset(45);
    }];
    
    
    UIView *allPeople = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    allPeople.backgroundColor = RGB(18, 21, 33);
    _tableView.tableHeaderView = allPeople;
    _toLab = [[UILabel alloc] init];
    _toLab.font = [UIFont systemFontOfSize:16];
    _toLab.text = @"To:";
    _toLab.textColor = [UIColor whiteColor];
    [allPeople addSubview:_toLab];
    [_toLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(allPeople).offset(30);
        make.centerY.equalTo(allPeople);
        make.width.height.offset(30);
    }];
    
    _peopleLab = [[UILabel alloc] init];
    _peopleLab.font = [UIFont systemFontOfSize:15];
    _peopleLab.textColor = RGB(212, 39, 82);
    [allPeople addSubview:_peopleLab];
    [_peopleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.toLab.mas_right).offset(10);
        make.centerY.equalTo(wSelf.toLab);
        make.right.equalTo(allPeople.mas_right).offset(-10);
    }];
}


- (void)loadData{
    
    ______WS();
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *dict = @{@"token":userDic[@"token"],
                           @"userid":userDic[@"userid"]};

    [[DJHttpApi shareInstance] POST:GetFollowUrl dict:dict succeed:^(id data) {

        NSArray *array = data[@"rspObject"];
        for (NSDictionary *userDic in array) {
            ChooserModel *model = [[ChooserModel alloc] init];
            [model setValuesForKeysWithDictionary:userDic];
            [wSelf.dataArr addObject:model];
        }
        wSelf.peopleLab.text = [NSString stringWithFormat:@"All %lu Followers",(unsigned long)wSelf.dataArr.count];
        [wSelf.tableView reloadData];
    } failure:^(NSError *error) {
    
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChooseUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chooseCell" forIndexPath:indexPath];
    ChooserModel *model = _dataArr[indexPath.row];
    cell.Delegate = self;
    [cell setCellWithModel:model indexPath:indexPath];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (void)broadSendAction {
    ______WS();
    _userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSString *from = [[EMClient sharedClient] currentUsername];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:_userDic[@"userid"]] == nil) {
        _replyCoin = @"200";
        
    }else{
        _replyCoin = [[NSUserDefaults standardUserDefaults] objectForKey:_userDic[@"userid"]];
    }
    NSString *type = @"0";

    NSDictionary *messgeDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *messgeDic1 = [NSMutableDictionary dictionary];
    [messgeDic1 setObject:messgeDic[@"avatarUrl"] forKey:@"avatarUrl"];
    [messgeDic1 setObject:messgeDic[@"nickname"] forKey:@"nickname"];
    [messgeDic1 setObject:_textStr forKey:@"inputText"];
    [messgeDic1 setObject:_userDic[@"userid"] forKey:@"userid"];
    [messgeDic1 setObject:from forKey:@"hxAccount"];
    [messgeDic1 setObject:_priceStr forKey:@"price"];
    [messgeDic1 setObject:_replyCoin forKey:@"replycoin"];
    [messgeDic1 setObject:type forKey:@"typeMessage"];
    
    if (_sendArr.count > 0) {
        if (_img == nil) {
            for(int i = 0; i < _sendArr.count; i++) {
                ChooserModel *hxModel = _sendArr[i];
                // 发送信息
                EMVideoMessageBody *body = [[EMVideoMessageBody alloc] initWithLocalPath:videoPath displayName:@"video.mp4"];
                // 生成message
                EMMessage *message = [[EMMessage alloc] initWithConversationID:hxModel.hxAccount from:from to:hxModel.hxAccount body:body ext:messgeDic1];
                message.chatType = EMChatTypeChat;// 设置为单聊消息
                [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
                    
                } completion:^(EMMessage *message, EMError *error) {
                    NSLog(@"%@",message);
                    [wSelf.navigationController popToViewController:[wSelf.navigationController.viewControllers objectAtIndex:0]
                                                          animated:YES];

                }];
            }
            
        }else {
            NSData *imageDt = UIImageJPEGRepresentation(_img, 0.8);

            for(int i = 0; i < _sendArr.count; i++) {
                ChooserModel *hxModel = _sendArr[i];
                EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithData:imageDt displayName:[NSString stringWithFormat:@"%@.png",from]];
                // 生成message
                EMMessage *message = [[EMMessage alloc] initWithConversationID:hxModel.hxAccount from:from to:hxModel.hxAccount body:body ext:messgeDic1];
                message.chatType = EMChatTypeChat;// 设置为单聊消息
                
                [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
                } completion:^(EMMessage *message, EMError *error) {
                    NSLog(@"%@",message.conversationId);
                    [wSelf.navigationController popToViewController:[wSelf.navigationController.viewControllers objectAtIndex:0]
                                                          animated:YES];
                }];
            }
        }
        [[DJHManager shareManager] toastManager:@"Sending successful" superView:[UIApplication sharedApplication].keyWindow];


    }else {
        // 尚未选择发送用户的处理
        [[DJHManager shareManager] toastManager:@"No select people" superView:self.view];

    }
    
}

- (void)deleteArrayAtIndex:(NSIndexPath *)indexPath{
    ChooserModel *model = _dataArr[indexPath.row];
  
    for (int i = 0; i < _sendArr.count; i++) {
        ChooserModel *sendMoel = _sendArr[i];
        if ([model.hxAccount isEqualToString:sendMoel.hxAccount]) {
            [_sendArr removeObjectAtIndex:i];
        }
    }
    _peopleLab.text = [NSString stringWithFormat:@"All %lu Followers",(unsigned long)_sendArr.count];

}

- (void)addArrayAtIndex:(NSIndexPath *)indexPath{
    ChooserModel *model = _dataArr[indexPath.row];
    [_sendArr addObject:model];
    _peopleLab.text = [NSString stringWithFormat:@"All %lu Followers",(unsigned long)_sendArr.count];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)dealloc{
    NSLog(@"choose 销毁了");
}

@end
