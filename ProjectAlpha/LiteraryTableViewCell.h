//
//  LiteraryTableViewCell.h
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Literary.h"
@interface LiteraryTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * imgView ; // 图片

@property (nonatomic,strong) UILabel * titleLabel; // 标题

@property (nonatomic,strong) UILabel * introLabel; // 介绍

@property (nonatomic,strong) UILabel * readCountLabel; // 阅读量

@property (nonatomic,strong) Literary * model; 

@end
