//
//  PictureModel.h
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/25.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject

@property (nonatomic,strong) NSString * title; // 标题

@property (nonatomic,strong) NSString * imageId; // 图片id

@property (nonatomic,assign) NSInteger next;

@property (nonatomic,strong) NSString * imgDim; // 宽*高

@property (nonatomic,strong) NSArray * imageIds; // 图片id数组
@end
