//
//  FavoriteTableViewCell.h
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/30.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteModel.h"
@interface FavoriteTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel * titleLabel; // 标题

@property (nonatomic,strong) UIImageView * imgView; // 图片

@property (nonatomic,strong) FavoriteModel * favoriteModel;

@end
