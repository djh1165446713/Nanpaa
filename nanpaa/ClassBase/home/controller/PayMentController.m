//
//  PayMentController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/15.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "PayMentController.h"
#import "PointTopView.h"
#import "MBProgressHUD.h"


#define ProductID_NP600 @"lvl1.points"      //600
#define ProductID_NP1200 @"lvl2.points"     //1200
#define ProductID_NP3000 @"lvl3.points"     //3000
#define ProductID_NP6800 @"lvl4.points"     //6800
#define ProductID_NP9800 @"lvl5.points"     //9800
#define ProductID_NP14800 @"lvl6.points"    //14800



@interface PayMentController ()<SKPaymentTransactionObserver,SKRequestDelegate,SKProductsRequestDelegate,MBProgressHUDDelegate>
@property (nonatomic, strong) NSMutableArray *coinArr;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, assign) BOOL isPayOk;
@property (nonatomic, strong) MBProgressHUD *HUD;
@property (nonatomic, strong) NSString *coinNum;
@property (nonatomic, assign) NSNumber *price;
@property (nonatomic, assign) CGFloat widthAndHeight;

@end

@implementation PayMentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArr = [NSMutableArray array];
    _isPayOk = NO;
    
    if (kScreenWidth < 375) {
        self.widthAndHeight = 130;
    }else{
        self.widthAndHeight = 150;
    }
    _coinArr = [NSMutableArray arrayWithObjects:ProductID_NP14800,ProductID_NP9800,ProductID_NP6800,ProductID_NP3000,ProductID_NP1200,ProductID_NP600,nil];
    
    self.titleLabel.text = @"Points";
    //    [self.leftNavBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    self.bgImg.backgroundColor = RGB(18, 21, 33);
    [self initUI];
    self.leftNavBtn.enabled = NO;
    for (NSString *productid in _coinArr) {
        [self payMentAction:productid];
    }
    
    
    
}

//- (void)backAction {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


- (void)initUI{
    ______WS();
    PointTopView *topView = [[PointTopView alloc] init];
    NSDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    topView.numPoints.text = [NSString stringWithFormat:@"%@",user[@"coin"]];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.view);
        make.width.offset(180);
        make.height.offset(30);
        make.top.equalTo(wSelf.view.mas_top).offset(84);
    }];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pay14800MentAction)];
    _btn1 = [[PayMentView alloc] init];
    _btn1.tag = 101;
    _btn1.productId = ProductID_NP14800;
    [_btn1 addGestureRecognizer:tap1];
    _btn1.pointNumLab.text = @"14800";
    [self.view addSubview:_btn1];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(24);
        make.top.equalTo(topView.mas_bottom).offset(20);
        make.width.offset(wSelf.widthAndHeight);
        make.height.offset(wSelf.widthAndHeight);
    }];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pay9800MentAction)];
    _btn2 = [[PayMentView alloc] init];
    _btn2.pointNumLab.text = @"9800";
    _btn2.productId = ProductID_NP9800;
    _btn2.tag = 102;
    [_btn2 addGestureRecognizer:tap2];
    [self.view addSubview:_btn2];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view.mas_right).offset(-24);
        make.top.equalTo(topView.mas_bottom).offset(20);
        make.width.offset(wSelf.widthAndHeight);
        make.height.offset(wSelf.widthAndHeight);
    }];
    
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pay6800MentAction)];
    _btn3 = [[PayMentView alloc] init];
    _btn3.tag = 103;
    _btn3.productId = ProductID_NP6800;
    _btn3.pointNumLab.text = @"6800";
    [_btn3 addGestureRecognizer:tap3];
    [self.view addSubview:_btn3];
    [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(24);
        make.top.equalTo(wSelf.btn1.mas_bottom).offset(25);
        make.width.offset(wSelf.widthAndHeight);
        make.height.offset(wSelf.widthAndHeight);
    }];
    
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pay3000MentAction)];
    _btn4 = [[PayMentView alloc] init];
    _btn4.productId = ProductID_NP3000;
    _btn4.tag = 104;
    _btn4.pointNumLab.text = @"3000";
    [_btn4 addGestureRecognizer:tap4];
    [self.view addSubview:_btn4];
    [_btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view).offset(-24);
        make.top.equalTo(wSelf.btn1.mas_bottom).offset(25);
        make.width.offset(wSelf.widthAndHeight);
        make.height.offset(wSelf.widthAndHeight);
    }];
    
    
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pay1200MentAction)];
    _btn5 = [[PayMentView alloc] init];
    _btn5.pointNumLab.text = @"1200";
    _btn5.productId = ProductID_NP1200;
    _btn5.tag = 105;
    [_btn5 addGestureRecognizer:tap5];
    [self.view addSubview:_btn5];
    [_btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(24);
        make.top.equalTo(wSelf.btn3.mas_bottom).offset(25);
        make.width.offset(wSelf.widthAndHeight);
        make.height.offset(wSelf.widthAndHeight);
    }];
    
    
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pay600MentAction)];
    _btn6 = [[PayMentView alloc] init];
    _btn6.tag = 106;
    _btn6.productId = ProductID_NP600;
    _btn6.pointNumLab.text = @"600";
    [_btn6 addGestureRecognizer:tap6];
    [self.view addSubview:_btn6];
    [_btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.view).offset(-24);
        make.top.equalTo(wSelf.btn3.mas_bottom).offset(25);
        make.width.offset(wSelf.widthAndHeight);
        make.height.offset(wSelf.widthAndHeight);
    }];
    
    _HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    //    _HUD.activityIndicatorColor =
    _HUD.color = [UIColor blackColor];
    _HUD.delegate =self;
    [_HUD show:YES];
    
}



- (void)payMentAction:(NSString *)productid{
    
    if ([SKPaymentQueue canMakePayments]) {
        [self requestProductData:productid];
    }
}


- (void)requestProductData:(NSString *)type {
    
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [NSArray arrayWithObjects:type, nil];
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    ______WS();
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    
    [_dataArr addObject:product];
    NSLog(@"%@",product);
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        NSLog(@"%@", [pro priceLocale]);
        
        for (int k = 1; k < 7; k++) {
            NSInteger index = k + 100;
            PayMentView *view = (PayMentView *)[self.view  viewWithTag:index];
            if ([view.productId isEqualToString:pro.productIdentifier]) {
                view.priceLab.text = [NSString stringWithFormat:@"%@%@",[pro priceLocale].currencySymbol,[pro price]];
            }
            if (_isPayOk) {
                if([pro.productIdentifier isEqualToString:view.productId]){
                    p = pro;
                    SKPayment *payment = [SKPayment paymentWithProduct:p];
                    _price = pro.price;
                    NSLog(@"发送购买请求");
                    [[SKPaymentQueue defaultQueue] addPayment:payment];
                }
            }
            
            if (k == 6) {
                double delayInSeconds = 2.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    wSelf.leftNavBtn.enabled = YES;
                });
            }
        }
        //        [_HUD removeFromSuperview];
        [_HUD hideAnimated:YES];
        
    }
    
}


//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
}


//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    
    NSLog(@"-----paymentQueue--------");
    
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                //交易完成
                [self  completeTransaction:transaction];
                
                NSLog(@"-----交易完成 --------");
                
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"" message:@"buy success" delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
                NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
                NSDictionary *dict = @{@"coin":_coinNum,
                                       @"orderChannel":@"ApplePay",
                                       @"orderId":transaction.transactionIdentifier,
                                       @"pay":_price,
                                       @"token":userDict[@"token"],
                                       @"userid":userDict[@"userid"]};
                
                [[DJHttpApi shareInstance] POST:payCoinUrl dict:dict succeed:^(id data) {
                    NSLog(@"%@",data);
                } failure:^(NSError *error) {
                    
                }];
                [alerView show];
                _isPayOk = NO;
            } break;
            case SKPaymentTransactionStateFailed://交易失败
                
            {
                [self failedTransaction:transaction];
                NSLog(@"-----交易失败 --------");
                UIAlertView *alerView2 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"购买失败，请重新尝试购买" delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
                [alerView2 show];
                _isPayOk = NO;
                
            }break;
                
            case SKPaymentTransactionStateRestored://已经购买过该商品 [self restoreTransaction:transaction];
                NSLog(@"-----已经购买过该商品 --------");
                _isPayOk = NO;
                
            case SKPaymentTransactionStatePurchasing:
                //商品添加进列表
                NSLog(@"-----商品添加进列表 --------");
                
                break
                ; default:
                break;
        }
    }
}


#pragma mark --- 手势方法
- (void)pay600MentAction{
    if (_isPayOk) {
        
    }else{
        if ([SKPaymentQueue canMakePayments]) {
            _coinNum = @"600";
            _isPayOk = YES;
            [self requestProductData:ProductID_NP600];
        }else{
            [self userUnMakeAppIdAction];
        }
    }
}


- (void)pay1200MentAction{
    if (_isPayOk) {
        
    }else{
        if ([SKPaymentQueue canMakePayments]) {
            _coinNum = @"1200";
            _isPayOk = YES;
            [self requestProductData:ProductID_NP1200];
            
            
        }else{
            [self userUnMakeAppIdAction];
        }}
}


- (void)pay3000MentAction{
    if (_isPayOk) {
        
    }else{
        if ([SKPaymentQueue canMakePayments]) {
            _coinNum = @"3000";
            _isPayOk = YES;
            [self requestProductData:ProductID_NP3000];
        }else{
            [self userUnMakeAppIdAction];
            
        }}
}

- (void)pay6800MentAction{
    if (_isPayOk) {
        
    }else{
        if ([SKPaymentQueue canMakePayments]) {
            _coinNum = @"6800";
            _isPayOk = YES;
            [self requestProductData:ProductID_NP6800];
            
        }else{
            [self userUnMakeAppIdAction];
        }}
}

- (void)pay9800MentAction{
    if (_isPayOk) {
        
    }else{
        if ([SKPaymentQueue canMakePayments]) {
            _coinNum = @"9800";
            _isPayOk = YES;
            [self requestProductData:ProductID_NP9800];
            
        }else{
            [self userUnMakeAppIdAction];
        }}
}

- (void)pay14800MentAction{
    if (_isPayOk) {
        
    }else{
        if ([SKPaymentQueue canMakePayments]) {
            _coinNum = @"14800";
            _isPayOk = YES;
            [self requestProductData:ProductID_NP14800];
            
        }else{
            [self userUnMakeAppIdAction];
        }}
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束 ---- %@",transaction);
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}



- (void)dealloc{
    NSLog(@"%@ ___________ 已经销毁",self);
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}



//记录交易
-(void)recordTransaction:(NSString *)product{
    NSLog(@"-----记录交易--------");
    
}

//处理下载内容
-(void)provideContent:(NSString *)product{
    NSLog(@"-----下载--------");
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"失败");
    if (transaction.error.code != SKErrorPaymentCancelled) { }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}



-(void) paymentQueue:(SKPaymentQueue *) paymentQueue restoreCompletedTransactionsFailedWithError:(NSError *)error{
    NSLog(@"-------paymentQueue----");
}


#pragma mark ---- 当正在或者结束购买的处理流程

- (void)userUnMakeAppIdAction{
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"You can‘t purchase in app store"
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close（关闭）",nil) otherButtonTitles:nil];
    [alerView show];
}
@end
