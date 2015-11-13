//
//  Literary.m
//  ProjectAlpha
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 com.sunshuaiqi. All rights reserved.
//

#import "Literary.h"

@implementation Literary

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"id"]) {
        
        self.ID = [value integerValue];
    }

}


@end
