//
//  UIButton+ButtonFactory.m
//  ProjectAlpha
//
//  Created by lanou3g on 10/22/15.
//  Copyright © 2015 com.sunshuaiqi. All rights reserved.
//

#import "UIButton+ButtonFactory.h"
#import "AlphaIcons.h"

@implementation UIButton (ButtonFactory)

+ (UIButton *)roundButtonWithColor:(UIColor *)color PlacedAtButton:(UIButton *)rootButton addToView:(UIView *)view{
    CGFloat width = 55 / 375.0 * view.frame.size.width;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMidX(rootButton.frame)-width/2, CGRectGetMidY(rootButton.frame)-width/2, width, width);
    [button setBackgroundImage:[AlphaIcons imageOfColorBallWithFrame:CGRectMake(0, 0, CGRectGetWidth(button.frame), CGRectGetHeight(button.frame))] forState:UIControlStateNormal];
    button.tintColor = color;
    button.layer.cornerRadius = width / 2;
    button.clipsToBounds = YES;
    button.alpha = 0.1;
    [view addSubview:button];
    
    return button;
}

+ (UIButton *)roundButtonWithImage:(UIImage *)image PlacedAtButton:(UIButton *)rootButton addToView:(UIView *)view{
    CGFloat width = 100 / 375.0 * view.frame.size.width;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMidX(rootButton.frame)-width/2, CGRectGetMidY(rootButton.frame)-width/2, width, width);
    [button setImage:image forState:UIControlStateNormal];
    
    button.layer.cornerRadius = width / 2;
    button.clipsToBounds = YES;
    button.alpha = 0;
    [view addSubview:button];
    return button;
}

+ (UIButton *)modernRectangleButtonOnView:(UIView *)view withBackgroundColor:(UIColor *)color{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button];
    button.backgroundColor = color;
    return button;
}

+ (UIButton *)modernSqureButtonOnView:(UIView *)view{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button];
    button.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.50];
    return button;
}

+ (UIButton *)modernColorButtonWithColor:(UIColor *)color PlacedAtSpot:(int)spotNumber addToView:(UIView *)view{
    CGFloat width = 35 / 375.0 * ScreenWidth;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 2;
    [view addSubview:button];
    [button mas_remakeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(view).mas_offset(-8 / 375.0 * ScreenWidth - spotNumber * width);
        make.size.mas_equalTo(width);
        make.centerY.equalTo(view);
    }];
    button.backgroundColor = color;
    return button;
}

+ (UIButton *)modernPortraitButtonWithImage:(UIImage *)image PlacedAtSpot:(int)spotNumber addToView:(UIView *)view{
    CGFloat width = 44 / 375.0 * ScreenWidth;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 2;
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(view).mas_offset(-8 / 375.0 * ScreenWidth - spotNumber * width * 1.7);
        make.size.mas_equalTo(width);
        make.centerY.equalTo(view);
    }];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}
@end
