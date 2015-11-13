//
//  MoodLogDetailViewController.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "MoodLogDetailViewController.h"

#import <AVOSCloud.h>
#import "LoginViewController.h"
#import <SVProgressHUD.h>
#import "FavoriteHandle.h"
#import "FavoriteModel.h"
#import "ProjectAlpha-Swift.h"
@interface MoodLogDetailViewController ()

@property(nonatomic,strong) UIImageView * imgView; // 图像

@property(nonatomic,strong) UITextView * textView; // 滚动视图

@end

@implementation MoodLogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 更改navigationController背景颜色
    if ([userDefaults boolForKey:@"isNightMode"]) {
        
        self.navigationController.navigationBar.barTintColor = NightBackgroundColor;
        
    }else {
        
        if ([userDefaults colorForKey:@"dark"]) {
            
            self.navigationController.navigationBar.barTintColor = [userDefaults colorForKey:@"dark"];
        
        }
    
    }
    
    
    
    [FavoriteHandle sharedHandle].isViaClickFavorite = NO;
    

    // 接收登录成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"userLogIn" object:nil];
    [self addSubViews];
    
}
-(void)dealloc
{
    // 接收登录成功的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"userLogIn" object:nil];
}

#pragma mark -- 添加控件
- (void)addSubViews
{
    
    // 返回按钮
    UIBarButtonItem * backBI = [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfBackArrowWithFrame:CGRectMake(0, 0, 30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(didClickBackBI)];
    backBI.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBI;
    
    // 收藏按钮
    UIBarButtonItem * favoriteBI = [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfFavoriteModernizedWithFrame:CGRectMake(0, 0, 25, 25)]  style:UIBarButtonItemStylePlain target:self action:@selector(didClickFavorite)];
    favoriteBI.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = favoriteBI;
    
    
    
    // 文本视图
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, ScreenHeight)];
    // 不显示滚动条
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.backgroundColor = [UIColor whiteColor];
    
    if ([userDefaults boolForKey:@"isNightMode"]) {
        
        self.textView.backgroundColor = NightBackgroundColor;
        
    }else {
        
        if ([userDefaults colorForKey:@"light"]) {
            
            self.textView.backgroundColor = [userDefaults colorForKey:@"light"];
            
        }
        
    }
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 显示文本内容
    self.textView.text = self.content;
    // 不能被编辑
    self.textView.editable = NO;
    [self.view addSubview:_textView];
    

    
    // 设置段落样式
    NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
    
    // 首行缩进
    paragraphStyle.firstLineHeadIndent = 20;
    
    // 段距
    paragraphStyle.paragraphSpacing = 10;
  
    // 行距
    paragraphStyle.lineSpacing = 5;
    
    // 添加属性样式 (NSKernAttributeName  字间距)
    if ([userDefaults boolForKey:@"isNightMode"]) {
        
        NSDictionary * attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:17],NSKernAttributeName:@1.0,NSForegroundColorAttributeName:DayTextColor};
         self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.content attributes:attributes];
    } else {
        
       NSDictionary * attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:17],NSKernAttributeName:@1.0};
       self.textView.attributedText = [[NSAttributedString alloc] initWithString:self.content attributes:attributes];
    }
   
    
    // 图片
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 200)];
    
     [_imgView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
    [self.textView addSubview:_imgView];
   
  
    CGRect rect = CGRectMake(0, 70, self.view.frame.size.width, 70);
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:rect];
    //添加需要排除的区域
    self.textView.textContainer.exclusionPaths = @[path];
    

}


#pragma mark -- 返回上一级视图
- (void)didClickBackBI
{

    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark -- 登录成功调用的方法
- (void)loginSuccess:(NSNotification *)notification
{

    if ([FavoriteHandle sharedHandle].isViaClickFavorite == YES) {
        
        [self didClickFavorite]; // 登录成功进入收藏
    }

}

#pragma mark -- 收藏事件
- (void)didClickFavorite
{
     // 用户已经登录直接收藏
    if ([AVUser currentUser]) {
        
        NSMutableArray * modelArray = [NSMutableArray array];
        NSArray * array = [[FavoriteHandle sharedHandle] qureyData];
        for (FavoriteModel * model in array) {
            
            if ([model.ID isEqualToString:self.ID]) {
                
                [modelArray addObject:model];
                
                [SVProgressHUD showSuccessWithStatus:@"已经收藏过了" maskType:SVProgressHUDMaskTypeBlack];
                [FavoriteHandle sharedHandle].isViaClickFavorite = NO;
            }
        }
        
        
        if (modelArray.count == 0) {
            
            [[FavoriteHandle sharedHandle] insertDataWithID:self.ID title:self.navigationItem.title imgUrl:self.imgUrl paragraph:self.content];
            
            [SVProgressHUD showSuccessWithStatus:@"收藏成功" maskType:SVProgressHUDMaskTypeGradient];
            
            [FavoriteHandle sharedHandle].isViaClickFavorite = NO;
        }
        
    }else {
    
        // 未登录先登录后收藏
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"温情提示" message:@"亲，登录后才能收藏哦" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 登录
            LoginViewController * loginVC = [LoginViewController new];
            [self.navigationController pushViewController:loginVC animated:YES];
            
        }];
        [alter addAction:action1];
        [alter addAction:action2];
        [self presentViewController:alter animated:YES completion:nil];
        
        [FavoriteHandle sharedHandle].isViaClickFavorite = YES;
        
        
    
    
    }



}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
