//
//  TransaHistoryController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/4.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "TransaHistoryController.h"
#import "TransaHistoryCell.h"
#import "TransaView.h"
#import "HistoryCoinModel.h"
#import <MessageUI/MessageUI.h>

@interface TransaHistoryController ()<UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TransaHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"Transaction History";
//    self.view.backgroundColor = RGB(23, 27, 44);
    [self initUI];
    [self loadData];
}

- (void)loadData {
    
    //    LocationInfo
    ______WS();
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSDictionary *dic = @{@"token":userInfo[@"token"],
                          @"userid":userInfo[@"userid"]
                          };
    [[DJHttpApi shareInstance] POST:getCoinList dict:dic succeed:^(id data) {
        
        NSArray *arr = data[@"rspObject"];
        if (arr.count > 0) {
            [self.view viewWithTag:1001].hidden = NO;
        }
        for (NSDictionary *dic in arr) {
            HistoryCoinModel *model = [[HistoryCoinModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [wSelf.dataArr addObject:model];
        }
        [wSelf.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)initUI{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    TransaView *view = [[TransaView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    view.tag = 1001;
    view.titleLabel.text = [NSString stringWithFormat:@"%@",userDic[@"income"]];
    [view.drawButton addTarget:self action:@selector(tixianAction) forControlEvents:(UIControlEventTouchUpInside)];
    view.hidden = YES;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = RGB(23, 27, 44);
    _tableView.tableHeaderView = view;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[TransaHistoryCell class] forCellReuseIdentifier:@"transCell"];
}

- (void)tixianAction{
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts" message:@"When your income reaches 10,000 points, you can contact nanpaa customer service to provide nanpaa account name to  receipt for cash \n Proportion of 200 nanpaa points = 1 dollar \n Service Email : nanpaa-withdraw@nanpaa.com" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        alert.tag = 101;
        [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 101) {
        if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
            [self sendEmailAction]; // 调用发送邮件的代码
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts" message:@"Please set up Mail account in order to send email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag = 102;
            [alert show];
        }
    }
}

-(void)sendEmailAction {
    // 邮件服务器
    MFMailComposeViewController *mailCompose = [[MFMailComposeViewController alloc] init];
    // 设置邮件代理
    [mailCompose setMailComposeDelegate:self];
    // 设置邮件主题
    [mailCompose setSubject:@"New mail"];
    // 设置收件人
    [mailCompose setToRecipients:@[@"nanpaa-report@nanpaa.com"]];
    /**
     *  设置邮件的正文内容
     */
    NSString *emailContent = @"";
    // 是否为HTML格式
    [mailCompose setMessageBody:emailContent isHTML:NO];
    // 如使用HTML格式，则为以下代码
    //	[mailCompose setMessageBody:@"<html><body><p>Hello</p><p>World！</p></body></html>" isHTML:YES];
    /**
     *  添加附件
     */
    //        UIImage *image = [UIImage imageNamed:@"image"];
    //        NSData *imageData = UIImagePNGRepresentation(image);
    //        [mailCompose addAttachmentData:imageData mimeType:@"" fileName:@"custom.png"];
    //        NSString *file = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
    //        NSData *pdf = [NSData dataWithContentsOfFile:file];
    //        [mailCompose addAttachmentData:pdf mimeType:@"" fileName:@"7天精通IOS233333"];
    // 弹出邮件发送视图
    
    [self.navigationController presentViewController:mailCompose animated:YES completion:nil];
    
}

#pragma mark ---- MFMailComposeViewControllerDelegate Action
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled: // 用户取消编辑
            NSLog(@"Mail send canceled...");
            break;
        case MFMailComposeResultSaved: // 用户保存邮件
            NSLog(@"Mail saved...");
            break;
        case MFMailComposeResultSent: // 用户点击发送
            NSLog(@"Mail sent...");
            break;
        case MFMailComposeResultFailed: // 用户尝试保存或发送邮件失败
            NSLog(@"Mail send errored: %@...", [error localizedDescription]);
            break;
    }
    // 关闭邮件发送视图
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransaHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"transCell" forIndexPath:indexPath];
    HistoryCoinModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

@end
