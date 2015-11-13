//
//  FavoriteTableViewController.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "FavoriteTableViewCell.h"
#import "FavoriteHandle.h"
#import "LiteraryDetailViewController.h"
#import "MoodLogDetailViewController.h"
#import "MediaDetailsViewController.h"
#import "ProjectAlpha-Swift.h"
#import <AVOSCloud.h>
#import "LoginViewController.h"
@interface FavoriteTableViewController ()
@property (nonatomic,strong)NSMutableArray * array;
@end

@implementation FavoriteTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    
    if ([userDefaults boolForKey:@"isNightMode"]) {
        // 夜间模式（背景色）
        self.tableView.backgroundColor = NightBackgroundColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
    
        if ([userDefaults colorForKey:@"light"]) {
          // 跟随主题颜色改变
            self.tableView.backgroundColor = [userDefaults colorForKey:@"light"];
        }
    
    
    }
    
    // 返回按钮
    UIBarButtonItem * backBI = [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfBackArrowWithFrame:CGRectMake(0, 0, 30, 30)] style:UIBarButtonItemStylePlain target:self action:@selector(didBackBI)];
    backBI.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBI;

    
    // 添加清除按钮
    UIBarButtonItem * clearBI = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(didClickClearBI)];
    clearBI.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = clearBI;
    
    
    // 判断用户是否登录
    [self judgeUserIsLogin];

}

// 返回按钮
- (void)didBackBI
{

    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark -- 清除所有收藏
- (void)didClickClearBI
{

    // 操作数据库
    [[FavoriteHandle sharedHandle] deleteAllData];
    
    // 操作数据源
    [_array removeAllObjects];
    
    // 操作UI
    [self.tableView reloadData];


}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:@"userLogIn" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self  name:@"userLogIn" object:nil];
}
#pragma mark -- 判断用户是否登录 （登录过直接查看；未登录先登录，登录成功之后查看收藏）
- (void)judgeUserIsLogin
{
    
    if (![AVUser currentUser]) {
        
        UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"温情提示" message:@"亲，登录后才可查看收藏记录哦" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController * loginVC = [LoginViewController new];
            [self.navigationController pushViewController:loginVC animated:YES];
            
        }];
        [alter addAction:action1];
        [alter addAction:action2];
        [self presentViewController:alter animated:YES completion:nil];
        
    }else {
        
        // 初始化数组
        self.array =  [NSMutableArray array];
        self.array = [[FavoriteHandle sharedHandle] qureyData];
        [self.tableView reloadData];
        
    }
    
}

#pragma mark -- 登录成功之后调用的方法--
- (void)loginSuccess:(NSNotification *)notification
{
    
    [self judgeUserIsLogin];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   return self.array.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" ];
    if (cell == nil) {
        
        cell = [[FavoriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    FavoriteModel * model = _array[indexPath.row];
    cell.favoriteModel = model;
    
    // 给收藏的视频图片上添加播放按钮（用来区别文章）
    if ([model.paragraph isEqualToString:@"movie"]) {
        UIImageView * playImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        playImgView.image = [[AlphaIcons imageOfPlayButtonWithFrame:playImgView.bounds] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        playImgView.tintColor = [UIColor colorWithWhite:1.000 alpha:0.743];
        [cell.imgView addSubview:playImgView];
    }
    
    if ([userDefaults boolForKey:@"isNightMode"]) {
        
        cell.titleLabel.textColor = NightTextColor;
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60;

}   

#pragma mark -- 根据paragraph的值区别详情页控制器类型
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteModel * model = _array[indexPath.row];
    if (model.paragraph) {
        // 存在段落
        
        if ([model.paragraph isEqualToString:@"movie"]) {
            MediaDetailsViewController * mediaDetailVC = [MediaDetailsViewController new];
            UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:mediaDetailVC];
            mediaDetailVC.movieID = model.ID;
            mediaDetailVC.movieImgUrl = model.imgUrl;
            [self showViewController:NC sender:nil];
        }else{
        
        MoodLogDetailViewController * moodDetailVC = [MoodLogDetailViewController new];
        UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:moodDetailVC];
        moodDetailVC.content = model.paragraph;
        moodDetailVC.imgUrl = model.imgUrl;
        moodDetailVC.title = model.titleStr;
        moodDetailVC.ID = model.ID;
        [self showViewController:NC sender:nil];
        }
        
    }else {
       // 段落为空
        LiteraryDetailViewController * detailVC = [LiteraryDetailViewController new];
       
        detailVC.ID = [model.ID integerValue];
        detailVC.title = model.titleStr;
       [self.navigationController pushViewController:detailVC animated:YES];
        
    }


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}


#pragma mark -- 删除收藏记录
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        FavoriteModel * model = _array[indexPath.row];
        // 从数据库中删除
        [[FavoriteHandle sharedHandle] deleteDataWithID:model.ID];
        
        // 从数据源中删除，也就是从数组中删除
        [_array removeObjectAtIndex:indexPath.row];
        
        // 操作UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



@end
