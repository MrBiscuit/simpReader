//
//  LoginViewController.m
//  ProjectAlpha
//
//  Created by lanou3g on 10/26/15.
//  Copyright © 2015 com.sunshuaiqi. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomTextField.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AVOSCloudSNS.h"

@interface LoginViewController ()<UITextFieldDelegate, UIScrollViewDelegate>
#pragma mark UI控件
@property(nonatomic, strong) CustomTextField *usernameLabel;
@property(nonatomic, strong) CustomTextField *userPasswordLabel;
@property(nonatomic, strong) CustomTextField *confirmPasswordLabel;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIView *bottomLine;
@property(nonatomic, strong) UIView *bottomLineAnimation;
@property(nonatomic, strong) UITextView *protocolView;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIButton *weiboLoginButton;
@property(nonatomic, strong) UIButton *QQloginButton;

#pragma mark 全局变量
@property(nonatomic, assign) CGFloat keyboardHeight;
@property(nonatomic, assign) BOOL keyboardHasShown;
@property(nonatomic, assign) BOOL alertLock;
@property(nonatomic, assign) BOOL registerLock;
@property(nonatomic, assign) BOOL correctPassword;

@end

@implementation LoginViewController

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            [self setNavigationBarTransformProgress:1];
        } else {
            [self setNavigationBarTransformProgress:(offsetY / 44)];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress{
    [self.navigationController.navigationBar lt_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    _scrollView.delegate = self;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isNightMode"]) {
        self.scrollView.backgroundColor = NightBackgroundColor;
    }else{
        self.scrollView.backgroundColor = [UIColor clearColor];
    }
    [self.view addSubview:_scrollView];
    
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfBackArrowWithFrame:CGRectMake(0, 0, 30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    _scrollView.decelerationRate = 0.1f;
    _usernameLabel = [CustomTextField textFiledWithFrame:CGRectMake(50, 100, 250, 60) Name:@"用户名" color:[UIColor colorWithRed:0.0 green:0.6784 blue:0.8980 alpha:1.0]];
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView addSubview:_usernameLabel];
    
    _userPasswordLabel = [CustomTextField textFiledWithFrame:CGRectMake(50, 150, 250, 60) Name:@"密码" color:[UIColor colorWithRed:0.8093 green:0.1066 blue:0.1367 alpha:1.0]];
    [_scrollView addSubview:_userPasswordLabel];
    _userPasswordLabel.secureTextEntry = YES;
    
    _confirmPasswordLabel = [CustomTextField textFiledWithFrame:CGRectMake(50, 200, 250, 60) Name:@"确认密码" color:[UIColor colorWithRed:0.8093 green:0.1066 blue:0.1367 alpha:1.0]];
    
    [_scrollView addSubview:_confirmPasswordLabel];
    _confirmPasswordLabel.hidden = YES;
    _confirmPasswordLabel.secureTextEntry = YES;
    
    _titleLabel = [UILabel new];
    _titleLabel.text = @"简    读";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [userDefaults boolForKey:@"isNightMode"] ? NightTextColor : [UIColor colorWithRed:0.1121 green:0.1121 blue:0.1121 alpha:1.0];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    [_scrollView addSubview:_titleLabel];
    
    _usernameLabel.textColor = [userDefaults boolForKey:@"isNightMode"] ? NightTextColor : [UIColor colorWithRed:0.1121 green:0.1121 blue:0.1121 alpha:1.0];
    _userPasswordLabel.textColor = [userDefaults boolForKey:@"isNightMode"] ? NightTextColor : [UIColor colorWithRed:0.1121 green:0.1121 blue:0.1121 alpha:1.0];;
    _confirmPasswordLabel.textColor = [userDefaults boolForKey:@"isNightMode"] ? NightTextColor : [UIColor colorWithRed:0.1121 green:0.1121 blue:0.1121 alpha:1.0];
    [_userPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.mas_equalTo(CGRectGetMidY(_scrollView.bounds)/32);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(self.view.frame.size.width * 0.6);
        make.height.mas_equalTo(60);
    }];
    
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_userPasswordLabel.mas_top).offset(-10);
        make.size.equalTo(_userPasswordLabel);
        make.left.equalTo(_userPasswordLabel);
    }];
    
    [_confirmPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.center.equalTo(_userPasswordLabel);
        make.size.equalTo(_userPasswordLabel);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(_usernameLabel.mas_top).offset(-55);
        make.centerX.equalTo(_userPasswordLabel);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(50);
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.usernameLabel.delegate = self;
    self.userPasswordLabel.delegate = self;
    self.confirmPasswordLabel.delegate = self;
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [_scrollView addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.top.equalTo(_confirmPasswordLabel.mas_bottom).offset(25);
        make.width.mas_equalTo(CGRectGetWidth(_confirmPasswordLabel.frame) / 2 +6);
        make.height.mas_equalTo(30);
    }];
    
    _loginButton.backgroundColor = [UIColor colorWithRed:0.0 green:0.6784 blue:0.8980 alpha:1.0];
    [_loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [_loginButton setTintColor:[UIColor whiteColor]];
    [_loginButton addTarget:self action:@selector(didClickLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.hidden = YES;
    
#pragma mark LeanCloud 属性初始化
    
    _alertLock = NO;
    _registerLock = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setTranslationY:0];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self registerForKeyboardNotifications];        //键盘响应方法
    
    [self.usernameLabel becomeFirstResponder];
}

- (void)registerForKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeShown:) name:UIKeyboardWillShowNotification object:nil]; // 获取键盘出现状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillBeShown:(NSNotification *)notification{
    CGSize keyboardSize = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size; // 获取键盘的Size
    self.keyboardHeight =  keyboardSize.height / 3.5;
    [UIView animateWithDuration:0.30 animations:^{
        if (is_iPhone4) {
            self.view.frame = CGRectMake(0, - keyboardSize.height / 2.0, self.view.frame.size.width, self.view.frame.size.height);
        }else{
            self.view.frame = CGRectMake(0, - keyboardSize.height / 3.5, self.view.frame.size.width, self.view.frame.size.height);
        }
    }];
    _keyboardHasShown = YES;
}

- (void)keyboardWillBeHidden:(NSNotification *)notification{
    [UIView animateWithDuration:0.30 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
    _keyboardHasShown = NO;
}

- (void)didClickLoginButton:(UIButton *)button {
    
    _correctPassword = NO;
    
    NSError *error = nil;
    [AVUser logInWithUsername:_usernameLabel.text password:_userPasswordLabel.text error:&error];
    if (error == nil) {
        _correctPassword = YES;
    }
    if (_registerLock && _correctPassword){  // 如果注册过并且密码输入正确
        print(@"登录成功");
        [self userLoggedIn:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }else if (_registerLock && !_correctPassword){      // 如果注册过但密码错误
        
        [self popAlertWithText:@"密码不正确"];
        return;
    }else if (!_registerLock && (![_userPasswordLabel.text isEqualToString:_confirmPasswordLabel.text])){
        [self popAlertWithText:@"两次输入密码不一致"];
        return;
    }
    
    if (!_registerLock && _usernameLabel.text && ![_userPasswordLabel.text isEqualToString:@""] && ![_confirmPasswordLabel.text isEqualToString:@""] && ([_confirmPasswordLabel.text isEqualToString:_userPasswordLabel.text] && ![[NSPredicate predicateWithFormat:@"text BEGINSWITH '0' || text BEGINSWITH '1' || text BEGINSWITH '2' || text BEGINSWITH '3' || text BEGINSWITH '4' || text BEGINSWITH '5' || text BEGINSWITH '6' || text BEGINSWITH '7' || text BEGINSWITH '8' || text BEGINSWITH '9'"] evaluateWithObject:self.usernameLabel])){ // 如果未注册过并且用户名或密码已填正确
#pragma mark 数据存储
        AVUser *user = [AVUser user];
        user.username = _usernameLabel.text;
        user.password =  _userPasswordLabel.text;
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                [self userLoggedIn:user];  // 传值到服务器
                _registerLock = YES;
                
                print(@"注册成功");
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
    }else if([_confirmPasswordLabel.text isEqualToString:@""] || [_userPasswordLabel.text isEqualToString:@""]){
        [self popAlertWithText:@"密码不能为空"];
    }else if ([[NSPredicate predicateWithFormat:@"text BEGINSWITH '0' || text BEGINSWITH '1' || text BEGINSWITH '2' || text BEGINSWITH '3' || text BEGINSWITH '4' || text BEGINSWITH '5' || text BEGINSWITH '6' || text BEGINSWITH '7' || text BEGINSWITH '8' || text BEGINSWITH '9'"] evaluateWithObject:self.usernameLabel]){
        [self popAlertWithText:@"用户名不能以数字开头"];
    }else{
         [self popAlertWithText:error.userInfo[@"NSLocalizedDescription"]];
    }
}

- (void)userLoggedIn:(AVUser *)user{
    
    if (user) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogIn" object:self userInfo:@{@"user":user,@"username":user.username}];  // 传值回上级界面
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"userLogIn" object:self userInfo:@{@"username":_usernameLabel.text}];  // 传值回上级界面
    }
    
}

- (void)popAlertWithText:(NSString *)text{
    UILabel * alertView = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - (self.view.frame.size.width * 0.8) /2, [UIScreen mainScreen].bounds.origin.y-80, self.view.frame.size.width * 0.8, 80)];
    alertView.textAlignment = NSTextAlignmentCenter;
    alertView.numberOfLines = 0;
    alertView.text = text;
    alertView.backgroundColor = [UIColor colorWithRed:0.8093 green:0.1066 blue:0.1367 alpha:0.8];
    alertView.font = [UIFont fontWithName:@"Helvetica" size:20];
    alertView.textColor = [UIColor whiteColor];
    [self.view addSubview:alertView];
    
    [UIView animateWithDuration:0.25 animations:^{
        if (_keyboardHasShown) {
            alertView.frame = CGRectMake(CGRectGetMidX(self.view.frame) - (self.view.frame.size.width * 0.8) /2, CGRectGetMaxY(self.navigationController.navigationBar.frame) + _keyboardHeight, self.view.frame.size.width * 0.8, 80);
        }else{
        alertView.frame = CGRectMake(CGRectGetMidX(self.view.frame) - (self.view.frame.size.width * 0.8) /2, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width * 0.8, 80);
        }
    }completion:^(BOOL finished) {
        [self performSelector:@selector(dismissAlert:) withObject:alertView afterDelay:2.0];
    }];
    
}

- (void)dismissAlert:(UILabel *)alert{
    [UIView animateWithDuration:0.25 animations:^{
        alert.frame = CGRectMake(CGRectGetMidX(self.view.frame) - (self.view.frame.size.width * 0.8) /2, [UIScreen mainScreen].bounds.origin.y-80, self.view.frame.size.width * 0.8, 80);
    }completion:^(BOOL finished) {
        [alert removeFromSuperview];
    }];
}

-(BOOL)textFieldShouldBeginEditing:(CustomTextField *)textField{
    
    [UIView animateWithDuration:0.35 animations:^{
        textField.bottomLineAnimation.frame = CGRectMake(0, CGRectGetMaxY(textField.bounds)-2, CGRectGetWidth(textField.frame), 2);
        textField.nameLabel.frame = CGRectMake(0, CGRectGetMinY(textField.bounds), CGRectGetWidth(textField.frame), 30);
        textField.nameLabel.textColor = [UIColor lightGrayColor];
        if (textField.text.length == 0 && ![textField.nameLabel.text containsString:@":"]) {
            textField.nameLabel.text = [textField.nameLabel.text stringByAppendingString:@":"];
        }
    }];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(CustomTextField *)textField{
    _registerLock = NO;
    if (textField.text.length == 0) {  // textFiled为空占位符回落动画
        [UIView animateWithDuration:0.35 animations:^{
            textField.bottomLineAnimation.frame = CGRectMake(0, CGRectGetMaxY(textField.bounds)-2, 0, 2);
            textField.nameLabel.frame = CGRectMake(0, CGRectGetMidY(textField.bounds) - _nameLabel.frame.size.height / 2, CGRectGetWidth(textField.frame), 30);
            textField.nameLabel.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
            textField.nameLabel.text = [textField.nameLabel.text stringByReplacingOccurrencesOfString:@":" withString:@""];
        }completion:^(BOOL finished) {
            [_loginButton setTitle:@"注册" forState:UIControlStateNormal];
            textField.bottomLineAnimation.frame = CGRectMake(0, CGRectGetMaxY(textField.bounds)-2, 0, 2);
        }];
    }
    
    if([textField isEqual:_usernameLabel]){
        // 判断注册项是否需要出现
        NSError *error = nil;
        AVQuery *query = [AVUser query];
        [query whereKey:@"username" equalTo:_usernameLabel.text];
        NSArray *array = [query findObjects:&error];
        if (array) {
            for (AVUser *user in array) {
                if ([user.username isEqualToString:_usernameLabel.text]) {
                    // 如果用户存在
                    _loginButton.hidden = NO;
                    _registerLock = YES;
                    break;
                }
            }
        }else{
            print(@"%@",error);
        }
        
        if (!_usernameLabel.text.length || _registerLock) { // 如果帐号栏为空 或者用户注册过
#pragma mark 转为登录状态
        // 注册控件回落
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.25 animations:^{
            [_confirmPasswordLabel mas_remakeConstraints:^(MASConstraintMaker *make){
                make.center.equalTo(_userPasswordLabel);
                make.size.equalTo(_userPasswordLabel);
            }];
            _confirmPasswordLabel.alpha = 0;
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            _loginButton.hidden = !_registerLock;
            _confirmPasswordLabel.hidden = YES;
        }];
    }
        if (_registerLock == NO && _usernameLabel.text.length) { // 没有注册过的用户输入用户名后注册控件滑出
            [_loginButton setTitle:@"注册" forState:UIControlStateNormal];
            _loginButton.hidden = NO;
            _confirmPasswordLabel.hidden = NO;
            [UIView animateWithDuration:0.25 animations:^{
                [_confirmPasswordLabel mas_remakeConstraints:^(MASConstraintMaker *make){
                    make.size.equalTo(_userPasswordLabel);
                    make.left.equalTo(_userPasswordLabel);
                    make.top.equalTo(_userPasswordLabel.mas_bottom).offset(10);
                }];
                _confirmPasswordLabel.alpha = 1;
                // 弹出协议
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    _protocolView = [[UITextView alloc] initWithFrame:CGRectZero];
                    _protocolView.text = @"用户协议\n    本应用不会涉及您的个人隐私, 我们不会以任何形式收集、存储、分享您的个人信息或者与您的设备相关的信息, 或收集任何统计数据和分析数据，也不会跟踪用户的行为。";
                    
                    _protocolView.backgroundColor = [UIColor clearColor];
                    _protocolView.textColor = [userDefaults boolForKey:@"isNightMode"] ? NightTextColor : [UIColor colorWithRed:0.1121 green:0.1121 blue:0.1121 alpha:1.0];
                    _protocolView.textAlignment = NSTextAlignmentCenter;
                    
                    [_scrollView addSubview:_protocolView];
                    [_protocolView mas_remakeConstraints:^(MASConstraintMaker *make){
                        make.top.equalTo(_loginButton.mas_bottom).offset(5 /375.0 * ScreenHeight);
                        make.left.equalTo(self.view).offset(44 /375.0 * ScreenWidth);
                        make.right.equalTo(self.view).offset(-44 / 375.0 * ScreenWidth);
                        make.height.mas_equalTo(100);
                    }];
                });
                [self.view layoutIfNeeded];

                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"text BEGINSWITH '0' || text BEGINSWITH '1' || text BEGINSWITH '2' || text BEGINSWITH '3' || text BEGINSWITH '4' || text BEGINSWITH '5' || text BEGINSWITH '6' || text BEGINSWITH '7' || text BEGINSWITH '8' || text BEGINSWITH '9'"];
                if ([predicate evaluateWithObject:self.usernameLabel]) {
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self popAlertWithText:@"用户名不能以数字开头"];
                    });
                }
               // 如果没有注册过再上滚一个label的高度
                if (is_iPhone4 | [textField isEqual:_usernameLabel]){
                    _scrollView.contentOffset = CGPointMake(0, CGRectGetHeight(_usernameLabel.frame) *1.5);
                }else if([textField isEqual:_usernameLabel]){
                _scrollView.contentOffset = CGPointMake(0, CGRectGetHeight(_usernameLabel.frame));
                }
            }];
        }
    }
    return YES;
}

- (void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
