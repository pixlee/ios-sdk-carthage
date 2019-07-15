//
//  PXLAnalytics.m
//  pixlee_sdk
//
//  Created by Mohamed Rachidi on 7/15/19.
//  Copyright © 2019 Pixlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXLAnalytics.h"

@implementation PXLAnalytics

- (instancetype)init {
    self = [super init];
    return self;
}


- (NSString *)urlParamString {
    NSMutableDictionary *options = @{}.mutableCopy;

    NSData *optionsData = [NSJSONSerialization dataWithJSONObject:options options:0 error:nil];
    NSString *optionsString = [[NSString alloc] initWithData:optionsData encoding:NSUTF8StringEncoding];
    return optionsString;
}

@end
