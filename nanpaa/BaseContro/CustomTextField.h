//
//  CustomTextField.h
//  TextField自动换行
//
//  Created by yangqijia on 16/8/11.
//  Copyright © 2016年 yangqijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField<UITextFieldDelegate>

/**
 *  自定义初始化方法
 *
 *  @param frame       frame
 *  @param placeholder 提示语
 *  @param clear       是否显示清空按钮 YES为显示
 *  @param view        是否设置leftView不设置传nil
 *  @param font        设置字号
 *
 *  @return 
 */
-(id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder clear:(BOOL)clear leftView:(id)view fontSize:(CGFloat)font;

@end
