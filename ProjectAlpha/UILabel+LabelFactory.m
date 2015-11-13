//
//  UILabel+LabelFactory.m
//  ProjectAlpha
//
//  Created by lanou3g on 11/2/15.
//  Copyright © 2015 com.sunshuaiqi. All rights reserved.
//

#import "UILabel+LabelFactory.h"

@implementation UILabel (LabelFactory)
+ (UILabel *)modernLabelWithTitle:(NSString *)title Color:(UIColor *)color OnView:(UIView *)view{
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.and.width.equalTo(view);
        make.top.equalTo(view).offset(25 / 667.0 * ScreenHeight);
        make.height.mas_equalTo(30);
    }];
    return label;
}

+ (UILabel *)modernLabelLowerPlateWithTitle:(NSString *)title Color:(UIColor *)color OnView:(UIView *)view{
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make){
        make.centerX.and.width.equalTo(view);
        make.bottom.equalTo(view).offset(- 25 / 667.0 * ScreenHeight);
        make.height.mas_equalTo(30);
    }];
    return label;
}

+ (UILabel *)modernFacilitateLabelWithTitle:(NSString *)title Color:(UIColor *)color OnView:(UIView *)view Centered:(BOOL)centered{
    UILabel *label = [UILabel new];
    label.text = title;
    label.textColor = color;
    label.textAlignment = centered;
    [view addSubview:label];
    return label;
}
@end
