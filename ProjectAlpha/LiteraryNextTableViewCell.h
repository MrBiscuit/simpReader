//
//  LiteraryNextTableViewCell.h
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiteraryNextModel.h"
@interface LiteraryNextTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView * imgview;

@property (nonatomic,strong) UILabel * titleLabel; // 标题

@property (nonatomic,strong) UILabel * introLabel; // 简介

@property (nonatomic,strong) UILabel * dataLabel;

@property (nonatomic,strong) LiteraryNextModel * model;

@end
