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
/**
 `PXLAnalytics` is a utility class that allow to trigger the following pixlee events add:cart and converted:photo`.
 */

@interface PXLAnalytics : NSObject


///---------------------
/// @name Analytics Event
///---------------------

/**
 Trigger lightbox opened widget to the Pixlee backend.
 
 @param product_sku string. quantity number. price string. currency string. 
 callback A block called after the photos have been loaded or an error has occurred.
 refer to https://developers.pixlee.com/docs/analytics-events-tracking-pixel-guide for details.
 
 @return The `NSURLSessionDataTask` the server will retun 'OK' if accepted.
 */
+ (NSURLSessionDataTask *)triggerEventAddCart:(NSString *)product_sku :(NSNumber *)quantity :(NSString *)price  :(NSString *)currency callback:(void (^)(NSError *error))completionBlock;


///---------------------
/// @name Analytics Event
///---------------------

/**
 Trigger lightbox opened widget to the Pixlee backend.
 
 @param cart_contents array. cart_total number. cart_total_quantity number. order_id number. currency string.
 callback A block called after the photos have been loaded or an error has occurred. 
 refer to https://developers.pixlee.com/docs/analytics-events-tracking-pixel-guide for details.
 
 @return The `NSURLSessionDataTask` the server will retun 'OK' if accepted.
 */

+ (NSURLSessionDataTask *)triggerEventConvertedPhoto:(NSMutableArray *)cart_contents :(NSNumber *)cart_total :(NSNumber *)cart_total_quantity :(NSString *)order_id :(NSString *)currency callback:(void (^)(NSError *error))completionBlock;


@end
