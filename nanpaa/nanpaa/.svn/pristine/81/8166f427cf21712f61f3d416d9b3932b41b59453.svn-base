//
//  NearbyController.m
//  nanpaa
//
//  Created by bianKerMacBook on 16/10/25.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import "NearbyController.h"
#import "NearbyView.h"
#import "NearbyCell.h"
#import "MessageController.h"
#import "NearbySearchController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "DynamicModel.h"
#import "HisViewController.h"
#import "ChooseJNView.h"
#import "CeshiViewController.h"
@interface NearbyController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate,MKMapViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic, strong)UICollectionView *collectView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL plusButtnEnable;
@property (nonatomic, strong) ChooseJNView *showView;
@property (nonatomic, strong) UIImagePickerController *pickContro;

@end

@implementation NearbyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _plusButtnEnable = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAction:) name:@"pushNoticSearch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationPicPush:) name:@"pushPicNearby" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tanchuan:) name:@"tanchuanSearch" object:nil];

    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSMutableArray array];
    [self initUI];
    
}


- (void)initUI{
    ______WS();
    NearbyView *view = [[NearbyView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    view.searchText.userInteractionEnabled = NO;
    [self.view addSubview:view];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 110) collectionViewLayout:flowLayout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.backgroundColor = [UIColor whiteColor];
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumInteritemSpacing = 30;
    flowLayout.minimumLineSpacing = 0;
    [self.view addSubview:_collectView];
    [_collectView registerClass:[NearbyCell class] forCellWithReuseIdentifier:@"nearbyCell"];

    _showView = [[ChooseJNView alloc] init];
    _showView.alpha = 1;
    _showView.hidden = YES;
    [_showView.pictureButton addTarget:self action:@selector(picActionPlay) forControlEvents:(UIControlEventTouchUpInside)];
    [_showView.videoButton addTarget:self action:@selector(videoActionPlay) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_showView];
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.view.mas_bottom).offset(-50);
        make.centerX.equalTo(wSelf.view);
        make.height.offset(kScreenHeight);
        make.width.offset(kScreenWidth);
        
    }];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [view addGestureRecognizer:tapGR];
    
}


- (void)loadData {

//    LocationInfo
    NSDictionary *location = [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationInfo"];
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    
    NSLog(@"%@",location);
    NSLog(@"%@",userInfo);

    
    NSDictionary *dic = @{@"latitude":location[@"wei"],
                          @"longitude":location[@"jing"],
                          @"token":userInfo[@"token"],
                          @"userid":userInfo[@"userid"]};
    [[DJHttpApi shareInstance] POST:nearByUrl dict:dic succeed:^(id data) {
        
        [_dataArr removeAllObjects];

        NSArray *arr = data[@"rspObject"];
        for (NSDictionary *dic in arr) {
            DynamicModel *model = [[DynamicModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [_dataArr addObject:model];
        }
        NSLog(@"%lu",(unsigned long)_dataArr.count);
        [_collectView reloadData];
        
    } failure:^(NSError *error) {
        
    }];

}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
 
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
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"SubLocality"] forKey:@"XianUser"];
            [[NSUserDefaults standardUserDefaults] setObject:resultDic forKey:@"LocationInfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self loadData];

    }];
    
    
    [_locationManager stopUpdatingLocation];

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


- (void)picActionPlay{
    NSLog(@"--------打开拍照--------");
    _pickContro = [[UIImagePickerController alloc] init];
    _pickContro.sourceType = UIImagePickerControllerSourceTypeCamera;
    _pickContro.delegate = self;
    _pickContro.allowsEditing = NO;
    [self presentViewController:_pickContro animated:YES completion:nil];
    
}

- (void)videoActionPlay{
    NSLog(@"--------打开拍摄--------");
    CeshiViewController *vc = [[CeshiViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}




- (void)tapAction:(UITapGestureRecognizer*)sender{
    
    self.hidesBottomBarWhenPushed = YES;
    NearbySearchController *searchVC = [[NearbySearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:NO];
    self.hidesBottomBarWhenPushed = NO;

    NSLog(@"我是轻拍手势");
}


#pragma mark    ------------通知处理---------------
- (void) notificationAction:(NSNotification *)notiction{
    NSLog(@"Nearby触发通知");
    NSData *data = notiction.userInfo[@"img"];
    self.hidesBottomBarWhenPushed=YES;
    MessageController *messVC = [[MessageController alloc] init];
    messVC.data = data;
    [self.navigationController pushViewController:messVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

- (void)notificationPicPush:(NSNotification *)notiction{
    NSData *data = notiction.userInfo[@"img"];
    self.hidesBottomBarWhenPushed = YES;
    MessageController *messVC = [[MessageController alloc] init];
    messVC.data = data;
    [self.navigationController pushViewController:messVC animated:NO];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)tanchuan:(NSNotification *)notic{
    if (_plusButtnEnable) {
        _showView.hidden = NO;
        _plusButtnEnable = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePlusBtnImg" object:@"Yes"];
        //        [NSNotificationCenter defaultCenter]  post
    }else{
        _showView.hidden = YES;
        _plusButtnEnable = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePlusBtnImg" object:@"No"];
    }

}

#pragma mark    ----------- collectView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NearbyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nearbyCell" forIndexPath:indexPath];
    cell.model = _dataArr[indexPath.row];
    return cell;
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(2, 2, 2, 2);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    DynamicModel *model = _dataArr[indexPath.row];
    HisViewController *vc = [[HisViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    self.hidesBottomBarWhenPushed = NO;

}


#pragma mark  ---------------------imagePickerController------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
    NSDictionary *dic = @{@"img":imageData};
    [[NSNotificationCenter defaultCenter] postNotificationName:[[NSUserDefaults standardUserDefaults] objectForKey:@"postPic"] object:self userInfo:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark --- ViewDelegate Action
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getUSerLocation];
    [[NSUserDefaults standardUserDefaults] setObject:@"pushNoticSearch" forKey:@"postHome"];
    [[NSUserDefaults standardUserDefaults] setObject:@"pushPicNearby" forKey:@"postPic"];
    [[NSUserDefaults standardUserDefaults] setObject:@"tanchuanSearch" forKey:@"tanchuan"];

//    [self.navigationController setNavigationBarHidden:YES];    set方法会关闭向左滑动 pop 返回
    self.navigationController.navigationBar.hidden = YES;

    self.hidesBottomBarWhenPushed = NO;


}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (!_plusButtnEnable) {
        self.showView.hidden = YES;
        _plusButtnEnable = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changePlusBtnImg" object:@"No"];
    }
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"pushNoticSearch"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"pushPicNearby"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"tanchuanSearch"];

}


@end
