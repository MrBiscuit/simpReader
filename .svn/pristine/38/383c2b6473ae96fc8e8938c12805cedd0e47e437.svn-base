//
//  LiteraryNextTableViewCell.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "LiteraryNextTableViewCell.h"

@implementation LiteraryNextTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    if (self) {
        
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_titleLabel];
         [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            

             make.top.equalTo(self.mas_top).offset(10);
             make.left.equalTo(self.mas_left).offset(10);
             make.right.equalTo(self.mas_right).offset(-10);
             make.height.mas_equalTo(30);
             
         }];
        
       
        
        _imgview = [UIImageView new];
        [self addSubview:_imgview];
        [_imgview mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(_titleLabel.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.width.mas_equalTo(100);
        }];
        
        
        _introLabel = [UILabel new];
        _introLabel.font = [UIFont systemFontOfSize:14];
        _introLabel.textColor = [UIColor darkGrayColor];
        _introLabel.numberOfLines = 0;
        [self addSubview:_introLabel];
        [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_titleLabel.mas_bottom).offset(15);
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_imgview.mas_left).offset(-15);
            make.height.mas_equalTo(50);
        }];
        
        
        _dataLabel = [UILabel new];
        _dataLabel.font = [UIFont systemFontOfSize:13];
        _dataLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_dataLabel];
        [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.equalTo(_titleLabel);
            make.height.equalTo(_titleLabel);
            make.right.equalTo(_introLabel);
            
        }];
        
    }

    return  self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
