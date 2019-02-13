//
//  BulletManager.m
//  RootView
//
//  Created by bianKerMacBook on 16/8/10.
//  Copyright © 2016年 bianKerMacBook. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"
#import "RecommendModel.h"

@interface BulletManager ()



// 弹幕使用过程中的数组变量
@property (nonatomic, strong)NSMutableArray *bulletComments;

// 存储弹幕View的数组变量
@property (nonatomic, strong)NSMutableArray *bulletViews;

@property BOOL isStopOrStart;

@end
@implementation BulletManager

// 初始化方法
- (instancetype)init {
    if (self = [super init]) {
        self.isStopOrStart = YES;
//        [self loadData];
    }
    return self;
}

- (void)start{
    if (!self.isStopOrStart) {
        return;
    }
    
    _isStopOrStart = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSouce];
    [self initBullrtComment];
}

- (void)stop{
    if (_isStopOrStart) {
        return;
    }
    
    self.isStopOrStart = YES;
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        BulletView *view = obj;
        [view stopAnimation];
        view = nil;
        
    }];
    
    [self.bulletViews removeAllObjects];
    
}

// 初始化弹幕,随机分配弹幕轨迹
- (void)initBullrtComment {

    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@(0), @(1), @(2),@(3)]];
    for (int i = 0; i < 4; i++) {
        if (self.bulletComments > 0) {
            // 通过随机数取到弹幕的轨迹
            NSInteger index = arc4random() % trajectorys.count;
            int trajectory = [[trajectorys objectAtIndex:index] intValue];
            [trajectorys removeObjectAtIndex:index];
            
            // 从数组中逐一需求取出弹幕数据
            RecommendModel *model = [[RecommendModel alloc] init];
            model = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            
            // 创建弹幕View 第一个参数: 弹幕数据() 第二个参数: 头像() 第三个参数: 弹幕轨迹()
            NSString *introduceNickname = [NSString stringWithFormat:@": %@",model.introduce];
            NSString *nickname = [NSString stringWithFormat:@"%@",model.nickname];

            [self createBulletView:introduceNickname name:nickname imageUrl:model.avatarUrl trajectory:trajectory];
        }
    }
        
}


// 创建弹幕
- (void)createBulletView: (NSString *)comment name:(NSString *)name imageUrl: (NSString *)imageUrl trajectory: (int)trajectory {
    
    if (self.isStopOrStart) {
        return;
    }
    
    BulletView *view = [[BulletView alloc] initWithComment:comment name:name imageUrl:imageUrl];
    view.trajectory = trajectory;
    
    [self.bulletViews addObject:view];
    
    __weak typeof (view) weakView = view;
    __weak typeof (self) mySelf = self;
    
    view.moveStatusBlock = ^(MoveStatus status){
        if (self.isStopOrStart) {
            return ;
        }
        switch (status) {
            case Start: {
                
                // 弹幕开始进入屏幕,将view加入弹幕管理的变量中bulletViews
                [mySelf.bulletViews addObject:weakView];
                
                break;
            }
            case Enter:{
                
                RecommendModel *comment = [mySelf nextComment];
                
                if (comment) {
                    [mySelf createBulletView:comment.introduce name:comment.nickname imageUrl:comment.avatarUrl trajectory:trajectory];
                }
                
                break;
            }
            case End: {
                
                // 弹幕完全飞出屏幕后从bulletViews删除,释放资源
                if ([mySelf.bulletViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [mySelf.bulletViews removeObject:weakView];
                }
                
                if (mySelf.bulletViews.count == 0) {
                    
                    // 说明屏幕上已经没有弹幕了,开始循环滚动
                    self.isStopOrStart = YES;
                    [mySelf start];
                    
                }
                
                break;
            }
            default:
                break;
        }
    };
    
    if (self.generateViewBlock) {
        self.generateViewBlock(view);
    }
}

// 自动追加弹幕方法
- (RecommendModel *)nextComment {
    if (self.bulletComments.count == 0) {
        return nil;
    }
    
    RecommendModel *comment = [self.bulletComments firstObject];
    
    if (comment) {
        [self.bulletComments removeObjectAtIndex:0];
    }
    
    return comment;
}

// 懒加载
- (NSMutableArray *)dataSouce{
    if (!_dataSouce) {
        _dataSouce = [NSMutableArray array];

    }
    
    return _dataSouce;
}




- (NSMutableArray *)bulletComments {
    if (!_bulletComments) {
        _bulletComments = [NSMutableArray array];
    }
    
    return _bulletComments;
    
}

- (NSMutableArray *)bulletViews {
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray array];
    }
    
    return _bulletViews;
}
@end
