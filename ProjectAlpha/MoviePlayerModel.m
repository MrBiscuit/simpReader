//
//  MoviePlayerModel.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/27.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "MoviePlayerModel.h"

@implementation MoviePlayerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        
        _desc = value;
    }
}

@end
