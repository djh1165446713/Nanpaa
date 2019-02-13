//
//  SetAppController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/24.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "SetAppController.h"
#import "SetAppCell.h"
#import "AboutController.h"
#import "BlackController.h"
#import "LoginViewController.h"
#import "AmounController.h"
#import "AppDelegate.h"
#import "NanpaaAboutController.h"
#import <MessageUI/MessageUI.h>
#import "ShareHelpManage.h"

@interface SetAppController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *personArr;
@property (nonatomic, strong) NSArray *aboutArr;
@property (nonatomic, strong) NSDictionary *userDic;
@property (nonatomic, assign) BOOL switchNet;
@property (strong,nonatomic) AppDelegate * appDelegate;

@end

@implementation SetAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _switchNet = YES;
    // Do any additional setup after loading the view.
    _personArr = [NSArray arrayWithObjects:@"Nanpaa ID",@"Notifications", @"Blacklist",nil];
    _aboutArr = [NSArray arrayWithObjects:@"Suggestion",@"Privacy policy", @"Terms of service",@"About Nanpaa",nil];
    _userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    self.view.backgroundColor = RGB(18, 21, 33);
    [self initUI];
}




- (void)initUI{
    ______WS();
    _bgImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds ];
    _bgImg.backgroundColor = RGB(36, 40, 73);
    [self.view addSubview:_bgImg];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = RGB(36, 40, 73);
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.view).offset(0);
        make.height.offset(64);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.text = @"Set up";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.bgView);
        make.centerY.equalTo(wSelf.bgView);
        make.width.offset(100);
        make.height.offset(34);
    }];
    
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.bgView).offset(15);
        make.centerY.equalTo(wSelf.bgView);
        make.width.offset(15);
        make.height.offset(20);
    }];

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, kScreenWidth, kScreenHeight - 64) style:(UITableViewStyleGrouped)];
    _tableView.backgroundColor = RGB(18, 21, 33);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[SetAppCell class] forCellReuseIdentifier:@"setAppCell"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SetAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setAppCell" forIndexPath:indexPath];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            cell.lblTitle.text = _personArr[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:20];
            [cell.swit setOn:_switchNet];
            [cell.swit addTarget:self action:@selector(switAction:) forControlEvents:(UIControlEventValueChanged)];
            return cell;
        }else if(indexPath.row == 0){
            cell.lblTitle.text  = _personArr[indexPath.row];
            cell.centerLabel.text = _userDic[@"userid"];
            cell.swit.hidden = YES;
            return cell;
        }else {
            cell.lblTitle.text  = _personArr[indexPath.row];
            cell.swit.hidden = YES;
            return cell;
        }
    }
    
    
    if (indexPath.section == 1) {
        cell.lblTitle.text = @"Amount to reply";
        cell.swit.hidden = YES;
        return cell;
    }
    
    if (indexPath.section == 2) {
        cell.lblTitle.text  = _aboutArr[indexPath.row];
        cell.swit.hidden = YES;
        return cell;
    }

    else {
        cell.centerLabel.text  = @"Login out";
        cell.swit.hidden = YES;
        return cell;
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    else if (section == 1) {
        return 1;
    }
    else if (section == 2) {
        return 4;
    }else {
        return 1;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        BlackController *vc = [[BlackController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   else if (indexPath.section == 1 && indexPath.row == 0) {
        AmounController *vc = [[AmounController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
   else if ( indexPath.section == 0 && indexPath.row == 1) {
       

   }
   else if ( indexPath.section == 0 && indexPath.row == 0) {
       [[ShareHelpManage shareInstance] shareSDKarray:nil shareText:shareInput shareURLString:shareURL shareTitle:shareTitText];
   }
    
    else if (indexPath.section == 2 && indexPath.row == 3) {
        AboutController *aboutVC = [[AboutController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        NanpaaAboutController *vc = [[NanpaaAboutController alloc] init];
        vc.strDj = UserAgreementUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if (indexPath.section == 2 && indexPath.row == 2) {
        NanpaaAboutController *vc = [[NanpaaAboutController alloc] init];
        vc.strDj = UserHelpMentUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if (indexPath.section == 2 && indexPath.row == 0) {
        if ([MFMailComposeViewController canSendMail]) { // 用户已设置邮件账户
            [self sendEmailAction]; // 调用发送邮件的代码
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Mail Accounts" message:@"Please set up Mail account in order to send email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alert.tag = 101;
            [alert show];
        }

    }
    else {
        
        NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
        NSDictionary *par = @{@"token":userDic[@"token"],
                              @"userid":userDic[@"userid"]};
        [[DJHttpApi shareInstance] POST:ExitUrl dict:par succeed:^(id data) {
            LoginViewController *logVC = [[LoginViewController alloc] init];
            UINavigationController *vc = [[UINavigationController alloc] initWithRootViewController:logVC];
            EMError *error = [[EMClient sharedClient] logout:YES];
            if (!error) {
                NSLog(@"退出成功");
            }
            [self.navigationController presentViewController:vc animated:YES completion:nil];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user"];
            [[NSUserDefaults standardUserDefaults] synchronize];

        } failure:^(NSError *error) {
            
        }];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Personal";
    }
    else if (section == 1) {
        return @"Points";
    }
    else if (section == 2) {
        return @"About";
    }else {
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 30;
    }else{
        return 20;
    }
}

- (void)switAction:(UISwitch *)swith{
    if (_switchNet == NO) {
        _switchNet = YES;
        [[NSUserDefaults standardUserDefaults] setBool:_switchNet forKey:@"pushOn"];
        // 设置全天免打扰，设置后，您将收不到任何推送
        EMPushOptions *options = [[EMClient sharedClient] pushOptions];
        options.noDisturbStatus = EMPushNoDisturbStatusClose;
        EMError *error = [[EMClient sharedClient] updatePushOptionsToServer];

    }else{
        _switchNet = NO;
        [[NSUserDefaults standardUserDefaults] setBool:_switchNet forKey:@"pushOn"];
        // 设置全天免打扰，设置后，您将收不到任何推送
        EMPushOptions *options = [[EMClient sharedClient] pushOptions];
        options.noDisturbStatus = EMPushNoDisturbStatusDay;
        EMError *error = [[EMClient sharedClient] updatePushOptionsToServer];

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



- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _switchNet = [[NSUserDefaults standardUserDefaults] boolForKey:@"pushOn"];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

@end
