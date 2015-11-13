//
//  LiteraryTableViewController.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "LiteraryTableViewController.h"
#import "Literary.h"
#import "LiteraryTableViewCell.h"
#import "LiteraryNextTableViewController.h"

#import "ProjectAlpha-Swift.h"

@interface LiteraryTableViewController ()
@property (nonatomic,strong) NSMutableArray * modelArray;
@end

@implementation LiteraryTableViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([userDefaults boolForKey:@"isNightMode"]) {

        [[NSNotificationCenter defaultCenter] postNotificationName:@"night" object:nil];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
   // self.tableView.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeColorUpdate:) name:@"themeColorUpdate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nightMode:) name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dayMode:) name:@"day" object:nil];
    

    // 解析数据
    [self parseData];
    //给偏移量添加观察者
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    
    // 上拉加载，下拉刷新
    [self UpLoadingAndDownRefresh];
    
}

// 夜间模式
- (void)nightMode:(NSNotification *)notification
{

    self.tableView.backgroundColor = NightBackgroundColor;

    [self.tableView reloadData];
}

// 日间模式
- (void)dayMode:(NSNotification *)notification
{
    
    if ([userDefaults colorForKey:@"light"]) {
        
        self.tableView.backgroundColor = [userDefaults colorForKey:@"light"];
        
    }else {
    
        self.tableView.backgroundColor = [UIColor whiteColor];
    
    }
    
    [self.tableView reloadData];
}

// 颜色改变
- (void)themeColorUpdate:(NSNotification *)notification
{
   
    self.tableView.backgroundColor = notification.userInfo[@"light"];
    

    [self.tableView reloadData];

}


#pragma mark --- ---------  上拉加载，下拉刷新  ----------------
- (void)UpLoadingAndDownRefresh
{
    
    // 下拉刷新
    __weak LiteraryTableViewController * weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if (weakSelf.modelArray.count == 0) {
            [weakSelf parseData];
        }
        // 刷新表格
        [weakSelf.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [weakSelf.tableView.header endRefreshing];
        
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    weakSelf.tableView.header.automaticallyChangeAlpha = YES;
    
    
//    // 上拉加载
//    weakSelf.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//    
//        // 结束刷新
//        [weakSelf.tableView.footer endRefreshing];
//        
//    }];
    
}


#pragma mark -- 解析数据
- (void)parseData{

    NSURL * url = [NSURL URLWithString:kLiteraryUrl];
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    __weak LiteraryTableViewController * weakSelf = self;
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * dataArray = dict[@"data"];
            
            weakSelf.modelArray = [NSMutableArray array];
            for (NSDictionary * dic in dataArray) {
                
                Literary * model = [Literary new];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [weakSelf.modelArray addObject:model];
                
            }
            
          
        }
        
        // 主线程刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 刷新数据
            [weakSelf.tableView reloadData];
        });
        
        
    }];
    
    // 开始执行
    [task resume];
    
  
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiteraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[LiteraryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
  
    
    Literary * model = _modelArray[indexPath.row];
    cell.model = model;
    
    
    if ([userDefaults boolForKey:@"isNightMode"]) {
        // 夜间模式
        cell.titleLabel.textColor = NightTextColor;
    }else {
    
        // 主题颜色或者白天模式
        cell.titleLabel.textColor = [UIColor blackColor];
    
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 140;
}

#pragma mark -- 点击cell跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    LiteraryNextTableViewController * nextTVC = [LiteraryNextTableViewController new];

    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:nextTVC];
  
   
    nextTVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    Literary * model = _modelArray[indexPath.row];
    
    nextTVC.imgUrl = model.cover_url;
    nextTVC.modelID = model.ID;
    nextTVC.titleName = model.name;
    

    [self presentViewController:NC animated:YES completion:nil];
}



#pragma mark -- 上滑时tabbar消失，下拉是tabbar出现

//实现观察者方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    CGPoint newContOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
    
    CGPoint oldContOffset= [change[NSKeyValueChangeOldKey] CGPointValue];
    
    CGFloat dy = newContOffset.y - oldContOffset.y;
    // 上滑手势
    if (dy > 0) {
        // tabbar 在屏幕内显示
        if (self.tabBarController.tabBar.frame.origin.y < ScreenHeight ) {
            
            self.tabBarController.tabBar.frame = CGRectMake(0, CGRectGetMinY(self.tabBarController.tabBar.frame)+dy, ScreenWidth, 49);
            
        }else{ // tabbar 不在屏幕中（将其放在屏幕的最下方）
            
            self.tabBarController.tabBar.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 49);
        }
        
        
        // 下拉手势
    }else if(dy <= 0){
        // 不在原有位置
        if (self.tabBarController.tabBar.frame.origin.y > ScreenHeight-49) {
            
            self.tabBarController.tabBar.frame = CGRectMake(0, CGRectGetMinY(self.tabBarController.tabBar.frame)+dy, ScreenWidth, 49);
            
        }else{
            // 在原有位置
            self.tabBarController.tabBar.frame = CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49);
            
        }
        
    }
    
    // 防止回弹时，tabbar消失
    if (oldContOffset.y < 200) {
        
        self.tabBarController.tabBar.frame = CGRectMake(0,ScreenHeight- 49, ScreenWidth, 49);
    }
    
    
}


- (void)dealloc
{
    // 移除观察者
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    
}



@end
