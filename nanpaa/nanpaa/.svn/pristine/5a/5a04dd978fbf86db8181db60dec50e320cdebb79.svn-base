//
//  TKSegementedView.m
//  SampleDemo
//
//  Created by qiukai on 15/7/28.
//  Copyright (c) 2015年 TK. All rights reserved.
//

#import "TKSegementedView.h"
#import "Masonry.h"
#import "UIView+Extension.h"
#import <CoreGraphics/CoreGraphics.h>
#import "TKSegementedItemStatus.h"

#define RGBCOLOR(r, g, b)                                                      \
[UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]

#define TKRedLineGap [self perSubButtonWidthPercent] * self.redLineGapRate

@interface TKSegementedViewPrivateItem : NSObject

@property (strong, nonatomic) TKSegementedItem *item;
@property (strong, nonatomic) UIButton *subButton;
/**
 *  statusIndex
 *  normal = 0, select = 1, others > 2
 */
@property (assign, nonatomic) NSInteger statusIndex;
@end

@implementation TKSegementedViewPrivateItem

+ (instancetype)privateItemWithItem:(TKSegementedItem *)item subButton:(UIButton *)subButton
{
    TKSegementedViewPrivateItem *privateItem = [[TKSegementedViewPrivateItem alloc] init];
    privateItem.item = item;
    privateItem.subButton = subButton;
    privateItem.statusIndex = StatusIndexNormal;
    return privateItem;
}

- (void)setStatusIndex:(NSInteger)statusIndex
{
    void(^execStatusChangeBlock)(NSInteger statusIndex) = ^(NSInteger statusIndex){
        
        if (_statusIndex == -1) return;
        
        if (statusIndex == StatusIndexNormal) {
            if (self.item.normalStatus.becomeCurrentStatusBlock) {
                self.item.normalStatus.becomeCurrentStatusBlock();
            }
        } else if (statusIndex == StatusIndexSelected) {
            if (self.item.selectedStatus.becomeCurrentStatusBlock) {
                self.item.selectedStatus.becomeCurrentStatusBlock();
            }
        } else {
            TKSegementedItemStatus *otherStatus = self.item.otherStatus[statusIndex - 2];
            !otherStatus.becomeCurrentStatusBlock?:otherStatus.becomeCurrentStatusBlock();
        }
    };
    
    execStatusChangeBlock(statusIndex);
    
    _statusIndex = statusIndex;
}

- (instancetype)init
{
    if (self == [super init]) {
        _statusIndex = -1;
    }
    return self;
}

@end

@interface TKSegementedView ()

@property (assign, nonatomic) NSInteger selectedPrivateItemIndex;
@property (strong, nonatomic) NSMutableArray *privateItemArray;

@property (strong, nonatomic) CAShapeLayer *redLine;
@property (strong, nonatomic) CAShapeLayer *bottomBlackLine;
@property (strong, nonatomic) NSMutableArray *dividerArray;

@end

@implementation TKSegementedView

+ (instancetype)segementedViewWithSegementedItem:(TKSegementedItem *)segementedItem, ...
{
    TKSegementedView *segementedView = [[TKSegementedView alloc] initWithFrame:CGRectZero];
    
    void(^addSubButton)(TKSegementedItem *segementedItem) = ^(TKSegementedItem *segementedItem){
        
        UIButton *subButton = [segementedView subButtonAtInitialStatusWithSegementedItem:segementedItem];
        [subButton addTarget:segementedView action:@selector(clickSubButton:) forControlEvents:UIControlEventTouchUpInside];
        
        TKSegementedViewPrivateItem *privateItem = [TKSegementedViewPrivateItem privateItemWithItem:segementedItem subButton:subButton];
        
        subButton.tag = segementedView.privateItemArray.count;
        
        [segementedView.privateItemArray addObject:privateItem];
    };
    
    va_list arguments;
    id eachObject;
    if (segementedItem) {
        
        addSubButton(segementedItem);
        
        va_start(arguments, segementedItem);
        while ((eachObject = va_arg(arguments, id))) {
            NSParameterAssert([eachObject isKindOfClass:[TKSegementedItem class]]);
            addSubButton((TKSegementedItem *)eachObject);
        }
        va_end(arguments);
    }
    
    [segementedView initDivider];
    
    return segementedView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _redLineGapRate = 0.17;
        _redLineHeight = 2;
        _bottomBlackLineHeight = 0.2;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)initDivider
{
    for (NSInteger i = 0; i < self.privateItemArray.count; ++i) {
        CAShapeLayer *divider = [[CAShapeLayer alloc] init];
        [self.dividerArray addObject:divider];
    }
}

- (void)layoutSubviews
{
    // subButton们的布局
    __weak typeof(self) weakSelf = self;
    UIButton *lastSubButton = nil;
    for (NSInteger i = 0; i < self.privateItemArray.count; ++i) {
        TKSegementedViewPrivateItem *privateItem = self.privateItemArray[i];
        UIButton *subButton = privateItem.subButton;
        
        CGFloat subButtonW = weakSelf.width / self.privateItemArray.count;
        if (!lastSubButton) {
            [subButton mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.equalTo(weakSelf.mas_left);
                make.top.equalTo(weakSelf.mas_top);
                make.bottom.equalTo(weakSelf.mas_bottom);
                make.width.mas_equalTo(@(subButtonW));
            }];
        } else {
            [subButton mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.equalTo(lastSubButton.mas_right);
                make.top.equalTo(weakSelf.mas_top);
                make.bottom.equalTo(weakSelf.mas_bottom);
                make.width.mas_equalTo(@(subButtonW));
            }];
        }
        lastSubButton = subButton;
        
        if (i == 0) {
            
            // 默认选中第1个
            void(^defaultSelectBlock)() = ^{
                self.selectedPrivateItemIndex = 0;
                TKSegementedViewPrivateItem *privateItem = self.privateItemArray[0];
                privateItem.statusIndex = StatusIndexSelected;
                [self updateStatus:privateItem.item.selectedStatus forSubButton:privateItem.subButton];
                
                self.redLine.strokeStart = [self strokeStartWithIndex:0];
                self.redLine.strokeEnd = [self strokeEndWithIndex:0];
            };
            
            defaultSelectBlock();
        }
        
        if (i < self.privateItemArray.count - 1) {
            UIEdgeInsets insets = self.verticalDividerInset;
            // 添加间隔线
            UIBezierPath *dividerPath = [[UIBezierPath alloc] init];
            [dividerPath moveToPoint:CGPointMake(subButtonW * (i + 1), insets.top)];
            [dividerPath addLineToPoint:CGPointMake(subButtonW * (i + 1), self.height - insets.bottom)];
            
            CAShapeLayer *divider = self.dividerArray[i];
            divider.lineWidth = 0.2;
            divider.path = dividerPath.CGPath;
            divider.fillColor = [UIColor clearColor].CGColor;
            divider.strokeColor = [UIColor grayColor].CGColor;
            [self.layer addSublayer:divider];
        }
    }
    
    [self.layer addSublayer:self.bottomBlackLine];
    [self.layer addSublayer:self.redLine];
    
    [super layoutSubviews];
}

- (CGFloat)strokeStartWithIndex:(NSInteger)index
{
    CGFloat perSubButtonWidthPercent = [self perSubButtonWidthPercent];
    return TKRedLineGap + perSubButtonWidthPercent * index;
}

- (CGFloat)strokeEndWithIndex:(NSInteger)index
{
    CGFloat perSubButtonWidthPercent = [self perSubButtonWidthPercent];
    CGFloat strokeEnd = perSubButtonWidthPercent - TKRedLineGap;
    return strokeEnd + perSubButtonWidthPercent * index;
}

- (CGFloat)perSubButtonWidthPercent
{
    return 1.00 / self.privateItemArray.count;
}

// 初始状态下的子按钮
- (UIButton *)subButtonAtInitialStatusWithSegementedItem:(TKSegementedItem *)segementedItem
{
    if (segementedItem.normalStatus) {
        UIButton *subButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self updateStatus:segementedItem.normalStatus forSubButton:subButton];
        [self addSubview:subButton];
        return subButton;
    } else {
        NSAssert(NO, @"item必须要有常规状态");
        return nil;
    }
}

- (void)clickSubButton:(UIButton *)subButton
{
    if (subButton.tag == self.selectedPrivateItemIndex) {  // 点击上次选中的按钮
        TKSegementedViewPrivateItem *selectedPrivateItem = self.privateItemArray[self.selectedPrivateItemIndex];
        
        if (selectedPrivateItem.statusIndex == selectedPrivateItem.item.otherStatus.count + 1) {  // 当前状态是otherStatus的最后1个
            selectedPrivateItem.statusIndex = StatusIndexSelected;
            
            [self updateStatus:selectedPrivateItem.item.selectedStatus forSubButton:selectedPrivateItem.subButton];
            
        } else {
            selectedPrivateItem.statusIndex ++;
            [self updateStatus:selectedPrivateItem.item.otherStatus[selectedPrivateItem.statusIndex - 2] forSubButton:selectedPrivateItem.subButton];
            
        }
        
    } else {
        // 取消上次选中
        TKSegementedViewPrivateItem *lastSelectedPrivateItem = self.privateItemArray[self.selectedPrivateItemIndex];
        lastSelectedPrivateItem.statusIndex = StatusIndexNormal;
        [self updateStatus:lastSelectedPrivateItem.item.normalStatus forSubButton:lastSelectedPrivateItem.subButton];
        
        // 选中当前点击按钮
        TKSegementedViewPrivateItem *newSelectedPrivateItem = self.privateItemArray[subButton.tag];
        newSelectedPrivateItem.statusIndex = StatusIndexSelected;
        [self updateStatus:newSelectedPrivateItem.item.selectedStatus forSubButton:subButton];
        
        // 更新selectedPrivateItemIndex
        self.selectedPrivateItemIndex = subButton.tag;
        
        // 移动redLine
        self.redLine.strokeStart = [self strokeStartWithIndex:self.selectedPrivateItemIndex];
        self.redLine.strokeEnd = [self strokeEndWithIndex:self.selectedPrivateItemIndex];
    }
}

- (void)updateStatus:(TKSegementedItemStatus *)status forSubButton:(UIButton *)subButton
{
    [subButton setTitle:status.title forState:UIControlStateNormal];
    [subButton setTitleColor:status.titleColor forState:UIControlStateNormal];
    subButton.titleLabel.font = status.titleFont;
    [subButton setImage:status.image forState:UIControlStateNormal];
    [subButton setBackgroundImage:status.backgroundImage forState:UIControlStateNormal];
}

#pragma mark - lazyLoad

- (CAShapeLayer *)redLine
{
    if (!_redLine) {
        _redLine = [[CAShapeLayer alloc] init];
        _redLine.lineWidth = self.redLineHeight;
        
        UIBezierPath *redLinePath = [[UIBezierPath alloc] init];
        [redLinePath moveToPoint:CGPointMake(0, self.height - 1)];
        [redLinePath addLineToPoint:CGPointMake(self.width, self.height- 1)];
        
        _redLine.path = redLinePath.CGPath;
        _redLine.fillColor = [UIColor clearColor].CGColor;
        _redLine.strokeColor = RGBCOLOR(250, 0, 0).CGColor;
    }
    return _redLine;
}

- (CAShapeLayer *)bottomBlackLine
{
    if (!_bottomBlackLine) {
        _bottomBlackLine = [[CAShapeLayer alloc] init];
        _bottomBlackLine.lineWidth = self.bottomBlackLineHeight;
        
        UIBezierPath *blackLinePath = [[UIBezierPath alloc] init];
        [blackLinePath moveToPoint:CGPointMake(0, self.height - 0.5)];
        [blackLinePath addLineToPoint:CGPointMake(self.width, self.height- 0.5)];
        
        _bottomBlackLine.path = blackLinePath.CGPath;
        _bottomBlackLine.fillColor = [UIColor clearColor].CGColor;
        _bottomBlackLine.strokeColor = [UIColor grayColor].CGColor;
    }
    return _bottomBlackLine;
}

- (NSMutableArray *)privateItemArray
{
    if (!_privateItemArray) {
        _privateItemArray = [NSMutableArray array];
    }
    return _privateItemArray;
}

- (NSMutableArray *)dividerArray
{
    if (!_dividerArray) {
        _dividerArray = [NSMutableArray array];
    }
    return _dividerArray;
}

@end
