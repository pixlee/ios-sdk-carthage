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
#import "PXLClient.h"

@implementation PXLAnalytics



+ (NSURLSessionDataTask *)triggerEventAddCart:(NSString *)product_sku :(NSNumber *)quantity :(NSString *)price :(NSString *)currency callback:(void (^)(NSError *))completionBlock{
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:product_sku forKey:@"product_sku"];
    [params setObject:quantity  forKey:@"quantity"];
    [params setObject:price forKey:@"price"];
    [params setObject:@"ios" forKey:@"platform"];
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [params setObject:udid forKey:@"uid"];
    [params setObject:udid forKey:@"distinct_user_hash"];
    [params setObject:udid forKey:@"fingerprint"];
    
    if(currency){
        [params setObject:currency forKey:@"currency"];
    }
    
    static NSString * const PXLAnalyticsPOSTRequestString = @"https://inbound-analytics.pixlee.com/events/addToCart";
    NSURLSessionDataTask *dataTask = [[PXLClient sharedClient] POST:PXLAnalyticsPOSTRequestString parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject) {
        if (completionBlock) {
            completionBlock(nil);
        }
    } failure:^(NSURLSessionDataTask * __unused task, NSError *error) {
        if (completionBlock) {
            completionBlock(error);
        }
    }];
    return dataTask;
}
+ (NSURLSessionDataTask *)triggerEventConvertedPhoto:(NSMutableArray *)cart_contents :(NSNumber *)cart_total :(NSNumber *)cart_total_quantity :(NSNumber *)order_id :(NSString *)currency callback:(void (^)(NSError *))completionBlock{
    NSMutableDictionary *params = @{}.mutableCopy;
    [params setObject:cart_contents forKey:@"cart_contents"];
    [params setObject:cart_total_quantity forKey:@"cart_total_quantity"];
    [params setObject:cart_total forKey:@"cart_total"];
    [params setObject:@"ios" forKey:@"platform"];

    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [params setObject:udid forKey:@"uid"];
    if(order_id){
        [params setObject:order_id forKey:@"order_id"];
    }
    if(currency){
        [params setObject:currency forKey:@"currency"];
    }
    
    static NSString * const PXLAnalyticsPOSTRequestString = @"https://inbound-analytics.pixlee.com/events/conversion";
    
    
    NSURLSessionDataTask *dataTask = [[PXLClient sharedClient] POST:PXLAnalyticsPOSTRequestString parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject) {
        if (completionBlock) {
            completionBlock(nil);
        }
    } failure:^(NSURLSessionDataTask * __unused task, NSError *error) {
        if (completionBlock) {
            completionBlock(error);
        }
    }];
    return dataTask;
}
@end
