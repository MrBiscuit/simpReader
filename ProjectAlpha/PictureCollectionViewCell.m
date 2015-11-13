//
//  PictureCollectionViewCell.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/25.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "PictureCollectionViewCell.h"

@implementation PictureCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    if (self) {
        
        self.imgView = [UIImageView new];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(5, 0, 0, 0));
        
        }];
        
    
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor colorWithRed:0.041 green:0.021 blue:0.058 alpha:0.295];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.bottom.and.left.and.right.equalTo(_imgView);
            make.height.mas_equalTo(30);
            
        }];
        
    }

    return self;
}

- (void)setModel:(PictureModel *)model{
    if (_model != model) {
        
        _model = model;
        
        _titleLabel.text = _model.title;
        
        // 图片
        NSString * str = [NSString stringWithFormat:@"http://img1.cutt.com/img/%@/",_model.imageId];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"43.jpg"]];
        
    }
}


@end
