//
//  WaterFlowLayout.h
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/25.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;

// 制订协议
@protocol WaterFlowLayoutDelegate <NSObject>

- (CGFloat)waterFlow:(WaterFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@end



@interface WaterFlowLayout : UICollectionViewLayout

@property(nonatomic,assign)UIEdgeInsets sectionInset;
@property(nonatomic,assign)CGFloat rowMagrin;
@property(nonatomic,assign)CGFloat colMagrin;
@property(nonatomic,assign)CGFloat colCount;

// 声明代理属性
@property (nonatomic,weak)id<WaterFlowLayoutDelegate>delegate;

@end
