//
//  LiteraryNextTableViewController.h
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiteraryNextTableViewController : UITableViewController

@property (nonatomic,strong) NSString * imgUrl; // 接收上个界面传过来的图片网址

@property (nonatomic,assign) NSInteger modelID; // 接收传过来的id值

@property (nonatomic,strong) NSString * titleName; // 接收标题



@end
