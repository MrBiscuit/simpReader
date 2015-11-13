//
//  EncouragementNextTableViewController.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "EncouragementNextTableViewController.h"
#import "LiteraryNextModel.h"
#import "LiteraryNextTableViewCell.h"
#import "EncouragementDetailViewController.h"

#define kEncouragementNextUrl(ID) [NSString stringWithFormat:@"http://apiv3.pento.cn/api/v2/stream/board/%ld/pin.json?count=21&token=Kx2S9nE0iHgbbSbeDdh2",ID]
#import "LiteraryDetailViewController.h"
@interface EncouragementNextTableViewController ()
@property (nonatomic,strong) NSMutableArray * modelArray;

@property (nonatomic,strong)  UIImageView * headerImageView;
@end

@implementation EncouragementNextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    
    [self parseData];
    
}

- (void)addSubviews
{
    
    self.navigationItem.title = self.titleName;
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 180)];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl] placeholderImage:[UIImage imageNamed:@"43.jpg"]];
    self.tableView.tableHeaderView = _headerImageView;
    
    UIBarButtonItem * backBI = [[UIBarButtonItem alloc] initWithImage:[AlphaIcons imageOfBackArrowWithFrame:CGRectMake(0, 0, 25, 25)] style:UIBarButtonItemStylePlain target:self action:@selector(didBackBI)];
    backBI.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backBI;
    
    
}

// 返回按钮
- (void)didBackBI
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -- 解析数据
- (void)parseData
{
    
    NSURL * url = [NSURL URLWithString:kEncouragementNextUrl(self.modelID)];
    
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    __weak EncouragementNextTableViewController * weakSelf = self;
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (data != nil) {
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray * dataArray = dict[@"data"];
            
            self.modelArray = [NSMutableArray array];
            
            for (int i = 0; i < dataArray.count; i++) {
                
                NSDictionary * dataDict = dataArray[i][@"data"];
                
                for (NSString * key in dataDict) {
                    if ([key isEqualToString:@"pin"]) {
                        // 如果pin 中的value值 是字典形式 ，则通过kvc将pin中的值赋给model对象，反之，直接将data中的值赋给model对象
                        if ([dataDict[@"pin"] isKindOfClass:[dataDict class]]) {
                            
                            LiteraryNextModel * model = [LiteraryNextModel new];
                            
                            [model setValuesForKeysWithDictionary:dataDict[@"pin"]];
                            
                            [weakSelf.modelArray addObject:model];
                            
                        }else{
                            LiteraryNextModel * model = [LiteraryNextModel new];
                            
                            [model setValuesForKeysWithDictionary:dataDict];
                            
                            [weakSelf.modelArray addObject:model];

                        }
                        
                    }
                        
                   
                }
                
                
            }
            
        }
        
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

    return 10;//_modelArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiteraryNextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if (cell == nil) {
        
        cell = [[LiteraryNextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    
    LiteraryNextModel * model = _modelArray[indexPath.row];
    cell.titleLabel.text = model.text;
    [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:_headerImageView.image];
    cell.introLabel.text = model.short_content;
    cell.dataLabel.text = [model.created_at substringToIndex:10];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 150;

}


#pragma mark -- 进入详情页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    EncouragementDetailViewController * detailVC = [[EncouragementDetailViewController alloc] init];
   // LiteraryDetailViewController * detailVC = [[LiteraryDetailViewController alloc] init];
    
    LiteraryNextModel * model = _modelArray[indexPath.row];
    detailVC.ID = model.ID;
    detailVC.title = model.text;
    detailVC.titleStr = model.text;
    detailVC.imgUrl = model.image_url;
    [self showViewController:detailVC sender:nil];
}






@end
