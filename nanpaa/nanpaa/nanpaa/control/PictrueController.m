
//
//  PictrueController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/17.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "PictrueController.h"
#import "KBTabbarController.h"
#import "SendUerViewController.h"
#import "UIImage+ImageCat.h"
#import "ChooseCourViewController.h"

@interface PictrueController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,CLLocationManagerDelegate,MKMapViewDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *leftNavBtn;
@property (nonatomic, strong) UIButton *rightNavBtn;
@property (nonatomic, strong) UILabel *titleLabel;;
@property (nonatomic, strong) UIImageView *bgImg;
@property (nonatomic, strong) UIButton *picBtn;
@property (nonatomic, strong) UIButton *nextButton;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL locationOpen;
@property (nonatomic, strong) UIImagePickerController *pickContro;

@end

@implementation PictrueController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _locationOpen = NO;
    [self getUSerLocation];
    [self initUI];
    
    

}


- (void)initUI {
    ______WS();
    
    _bgImg = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds ];
    _bgImg.image = [UIImage imageNamed:@"bigpic"];
    [self.view addSubview:_bgImg];
    
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.view).offset(0);
        make.width.offset(kScreenWidth);
        make.top.equalTo(wSelf.view).offset(0);
        make.height.offset(64);
    }];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.text = @"Sign Up";
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(wSelf.bgView);
        make.top.equalTo(wSelf.bgView.mas_top).offset(34);
        make.width.offset(100);
        make.height.offset(34);
    }];
    
    _leftNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftNavBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
    [_leftNavBtn  addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_leftNavBtn];
    [_leftNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.bgView).offset(15);
        make.centerY.equalTo(wSelf.titleLabel);
        make.width.offset(12);
        make.height.offset(24);
    }];
    
    _rightNavBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_rightNavBtn setTitle:@"Skip" forState:(UIControlStateNormal)];
    [_rightNavBtn setTitleColor:RGB(179, 45, 83) forState:(UIControlStateNormal)];
    _rightNavBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightNavBtn  addTarget:self action:@selector(SkipAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_bgView addSubview:_rightNavBtn];
    [_rightNavBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.bgView.mas_right).offset(-15);
        make.centerY.equalTo(wSelf.titleLabel);
        make.width.offset(50);
        make.height.offset(24);
    }];
    

    _picBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_picBtn setImage:[UIImage imageNamed:@"picture"] forState:(UIControlStateNormal)];
    [_picBtn addTarget:self action:@selector(picChooseAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_picBtn];
    [self.picBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.view);
        make.centerX.equalTo(wSelf.bgView);
        make.width.height.offset(kScreenWidth / 3);
        _picBtn.layer.masksToBounds = YES;
        _picBtn.layer.cornerRadius = kScreenWidth / 6;
    }];
    
    _nextButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _nextButton.backgroundColor = RGB(179, 45, 83);
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 20;
    [_nextButton setTitle:@"Next" forState:(UIControlStateNormal)];
    [_nextButton addTarget:self action:@selector(subActionNext) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.picBtn.mas_bottom).offset(162);
        make.left.equalTo(wSelf.view).offset(30);
        make.right.equalTo(wSelf.view).offset(-30);
        make.height.offset(80);
    }];

    
    
}


#pragma mark --- viewAction
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark --- 自定义方法

- (void)SkipAction{
    if (_locationOpen) {
        SendUerViewController *vc = [[SendUerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        ChooseCourViewController *vc = [[ChooseCourViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)subActionNext {
    
    NSDictionary *userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    //1。创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    NSString *Url = [NSString stringWithFormat:@"%@%@",URLdomain,AvatarURL];
    [manager POST:Url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传文件参数
        NSData *data;
        if (UIImagePNGRepresentation(_picBtn.imageView.image) == nil) {
            
            data = UIImageJPEGRepresentation(_picBtn.imageView.image, 1);
            
        } else {
            
            data = UIImagePNGRepresentation(_picBtn.imageView.image);
        }

        //这个就是参数
        [formData appendPartWithFileData:data name:@"avatar" fileName:@"headIcon.png" mimeType:@"image/png"];
        [formData appendPartWithFormData:[userData[@"token"] dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"token"];
        [formData appendPartWithFormData:[@".png" dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"type"];
        [formData appendPartWithFormData:[userData[@"userid"] dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"userid"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        if (_locationOpen) {
            SendUerViewController *vc = [[SendUerViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            ChooseCourViewController *vc = [[ChooseCourViewController alloc] init];      
            [self.navigationController pushViewController:vc animated:YES];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败  处理
        NSLog(@"请求失败：%@",error);
    }];
    
}

//获取定位信息
-(void)getUSerLocation{
    //初始化定位管理类
    _locationManager = [[CLLocationManager alloc] init];
    //delegate
    _locationManager.delegate = self;
    //The desired location accuracy.//精确度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //Specifies the minimum update distance in meters.
    //距离
    _locationManager.distanceFilter = 10;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
        
    }
    //开始定位
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    ______WS();
    for(CLLocation *location in locations){
        NSLog(@"---------%@-------",location);
    }
    CLLocation *currLocation=[locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];//反向解析，根据及纬度反向解析出地址
    CLLocation *location = [locations objectAtIndex:0];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        for(CLPlacemark *place in placemarks)
        {
            //取出当前位置的坐标
            NSLog(@"latitude : %f,longitude: %f",currLocation.coordinate.latitude,currLocation.coordinate.longitude);
            NSString *latStr = [NSString stringWithFormat:@"%f",currLocation.coordinate.latitude];
            NSString *lngStr = [NSString stringWithFormat:@"%f",currLocation.coordinate.longitude];
            NSDictionary *dict = [place addressDictionary];
            NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
            [resultDic setObject:dict[@"SubLocality"] forKey:@"xian"];
            [resultDic setObject:dict[@"City"] forKey:@"shi"];
            [resultDic setObject:latStr forKey:@"wei"];
            [resultDic setObject:lngStr forKey:@"jing"];
            [resultDic setObject:dict[@"State"] forKey:@"sheng"];
            [resultDic setObject:dict[@"Name"] forKey:@"all"];
            NSLog(@"------addressDictionary-%@------",dict);
//            self.searchController.searchBar.text = [NSString stringWithFormat:@"%@%@",[dict objectForKey:@"Country"],[dict objectForKey:@"City"]];
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"SubLocality"] forKey:@"XianUser"];
            [[NSUserDefaults standardUserDefaults] setObject:resultDic forKey:@"LocationInfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
            NSDictionary *par = @{@"latitude":latStr,
                                  @"longitude":lngStr,
                                  @"token":userDic[@"token"],
                                  @"userid":userDic[@"userid"]};
            [[DJHttpApi shareInstance] POST:postLocationUrl dict:par succeed:^(id data) {
                wSelf.locationOpen = YES;
                
            } failure:^(NSError *error) {
                
            }];
        }
    }];
}


#pragma mark - 检测应用是否开启定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
    switch([error code]) {
        case kCLErrorDenied:
            [self openGPSTips];
            break;
        case kCLErrorLocationUnknown:
            break;
        default:
            break;
    }
}

-(void)openGPSTips{
    UIAlertView *alet = [[UIAlertView alloc] initWithTitle:@"当前定位服务不可用" message:@"请到“设置->隐私->定位服务”中开启定位" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alet show];
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)picChooseAction{
    
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:nil
                            delegate:self
                            cancelButtonTitle:@"cancel"
                            destructiveButtonTitle:@"take Photos"
                            otherButtonTitles:@"take Camera", nil];
    sheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [sheet showInView:self.view];


}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        _pickContro = [[UIImagePickerController alloc] init];
        _pickContro.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _pickContro.delegate = self;
        _pickContro.allowsEditing = YES;
        [self presentViewController:_pickContro animated:YES completion:nil];
    }else if (buttonIndex == 1) {
        if ([self isCameraAvailable]) {
            _pickContro = [[UIImagePickerController alloc] init];
            _pickContro.sourceType = UIImagePickerControllerSourceTypeCamera;
            _pickContro.delegate = self;
            _pickContro.allowsEditing = YES;
            [self presentViewController:_pickContro animated:YES completion:nil];
        }
    }else if(buttonIndex == 2) {
        
    }
    
}



#pragma mark --- UIImagePickerController Delegate
// 判断设备是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL) isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {

    [_picBtn setImage: [UIImage handleImage:image withSize:CGSizeMake(200, 200)] forState:(UIControlStateNormal)];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
