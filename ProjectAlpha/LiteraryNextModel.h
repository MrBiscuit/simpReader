//
//  LiteraryNextModel.h
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiteraryNextModel : NSObject

@property (nonatomic,strong) NSString * image_url;

@property (nonatomic,assign) NSInteger ID;

@property (nonatomic,strong) NSString * short_content; //简介

@property (nonatomic,strong) NSString * text; //标题

@property (nonatomic,strong) NSString * created_at; // 时间

@property (nonatomic,assign) NSInteger image_width; // 图片宽

@property (nonatomic,assign) NSInteger image_height; // 图片高

@end
