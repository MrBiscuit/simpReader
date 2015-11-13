//
//  LiteraryTableViewCell.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "LiteraryTableViewCell.h"

@implementation LiteraryTableViewCell

- (void)awakeFromNib {
    // Initialization code
   
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    if (self) {
        // 添加控件
        // 图片
        self.imgView = [UIImageView new];
        _imgView.layer.masksToBounds = YES;
        _imgView.layer.cornerRadius = 8;
        _imgView.layer.borderColor = [[UIColor grayColor] CGColor];
        _imgView.layer.borderWidth = 2;
        _imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(100);
            make.top.equalTo(self.mas_top).offset(10);
            make.left.equalTo(self.mas_left).offset(20);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
        
        // 标题
        _titleLabel = [UILabel new];
       
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgView);
            make.left.equalTo(_imgView.mas_right).offset(20);
            make.right.equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(30);
        }];
        
        
        // 简介
        _introLabel = [UILabel new];
        _introLabel.font = [UIFont systemFontOfSize:14];
        _introLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_introLabel];
        [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(_titleLabel.mas_bottom).offset(15);
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_titleLabel);
            make.height.equalTo(_titleLabel);
        }];
        
        // 小图标
        UIImageView * littleIcon = [UIImageView new];
        littleIcon.image = [AlphaIcons imageOfBookWithFrame:CGRectMake(0, 0, 30, 30)];
        littleIcon.tintColor = [UIColor darkGrayColor];
        [self addSubview:littleIcon];
        [littleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.equalTo(_imgView);
            make.left.equalTo(_titleLabel).offset(15);
            make.size.mas_equalTo(30);
            
        }];
        
        // 阅读
        _readCountLabel = [UILabel new];
        _readCountLabel.textColor = [UIColor darkGrayColor];
        _readCountLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_readCountLabel];
       
        [_readCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(littleIcon);
            make.left.equalTo(littleIcon.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 25));
            
            
        }];
        
    }

    return self;
}


- (void)setModel:(Literary *)model
{
    if (_model != model) {
        
        _model = model;
        
        [_imgView sd_setImageWithURL:[NSURL URLWithString:_model.cover_url] placeholderImage:[UIImage imageNamed:@"43.jpg"]];
        
         _titleLabel.text = _model.name;
        
         _introLabel.text = _model.intro;
    
        _readCountLabel.text = [NSString stringWithFormat:@"%ld人阅读",(long)_model.subscribe_count];
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
