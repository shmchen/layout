//
//  Info.m
//  textKit
//
//  Created by lawyee on 16/8/5.
//  Copyright © 2016年 163. All rights reserved.
//

#import "Info.h"

@implementation Info

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
