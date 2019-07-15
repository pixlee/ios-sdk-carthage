//
//  PXLAnalytics.m
//  pixlee_sdk
//
//  Created by Mohamed Rachidi on 7/15/19.
//  Copyright © 2019 Pixlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXLAnalytics.h"
#import <UIKit/UIKit.h>


@implementation PXLAnalytics


- (instancetype)init {
    self = [super init];
    self.identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    self.platform = @"ios";
    return self;
}

- (NSArray *)eventTypeKeys {
    static NSArray *eventTypeKeys = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        eventTypeKeys = @[
                         @"opened:widget",
                         @"opened:lightbox",
                         @"action:clicked",
                         @"load:more",
                         @"nav:right",
                         @"add:to:cart"
                         ];
    });
    return eventTypeKeys;
}

- (NSString *)urlParamString {
    NSMutableDictionary *options = @{}.mutableCopy;

    NSData *optionsData = [NSJSONSerialization dataWithJSONObject:options options:0 error:nil];
    NSString *optionsString = [[NSString alloc] initWithData:optionsData encoding:NSUTF8StringEncoding];
    return optionsString;
}

@end
