//
//  MoodLogTableViewCell.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "MoodLogTableViewCell.h"

@implementation MoodLogTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    if (self) {
        
        // 图片
        _imgView = [UIImageView new];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.edges.mas_equalTo(UIEdgeInsetsZero);
            
        }];
        
        // 标题
        _titleLabel = [UILabel new];
        [self.imgView addSubview:_titleLabel];
        _titleLabel.backgroundColor = [UIColor colorWithRed:0.329 green:0.765 blue:0.945 alpha:0.928];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30);
            make.bottom.and.left.right.mas_equalTo(_imgView);
        }];
       
        
    }
    
    return self;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
