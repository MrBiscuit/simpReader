//
//  LiteraryDetailViewController.h
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiteraryDetailViewController : UIViewController

@property (nonatomic,assign) NSInteger  ID;  // 接收上个页面的id值

@property (nonatomic,strong) NSString * titleStr; // 接收标题

@property (nonatomic,strong) NSString * imgUrl; // 接收图片网址

@end
