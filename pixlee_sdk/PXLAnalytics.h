//
//  PXLAnalytics.h
//  pixlee_sdk
//
//  Created by Mohamed Rachidi on 7/15/19.
//  Copyright © 2019 Pixlee. All rights reserved.
//

#ifndef PXLAnalytics_h
#define PXLAnalytics_h


#endif /* PXLAnalytics_h */

typedef NS_ENUM(NSInteger, PXLAnalyticsType) {
    PXLEvent,
};

@interface PXLAnalytics : NSObject

@property (nonatomic) NSUInteger minInstagramFollowers;
@property (nonatomic) PXLAnalyticsType eventType;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *platform;
- (NSString *)urlParamString;


@end
