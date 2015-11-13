//
//  HistoryTableViewCell.h
//  ProjectAlpha
//
//  Created by lanou3g on 11/2/15.
//  Copyright © 2015 com.sunshuaiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteModel.h"
@interface HistoryTableViewCell : UITableViewCell

@property(nonatomic, strong) UILabel *dateLabel; // 时间标签

@property (nonatomic,strong) UILabel * titleLabel; // 标题

@property (nonatomic,strong) UIImageView * imgView; // 图片

@property (nonatomic,strong) FavoriteModel * model; // 

@end
