//
//  ShowPointView.h
//  nanpaa
//
//  Created by bianKerMacBook on 16/11/14.
//  Copyright © 2016年 bianKerMacBookDJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KVTimer.h"

@interface ShowPointView : UIView
@property (nonatomic, strong) KVTimer   *timer;
@property (nonatomic, strong)UILabel *topLab;
@property (nonatomic, strong)UILabel *bottomLab;
@end
