//
//  Info.h
//  textKit
//
//  Created by lawyee on 16/8/5.
//  Copyright © 2016年 163. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<NSString *> *descArray;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
