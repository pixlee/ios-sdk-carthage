//
//  PXLAlbumFilterOptions.m
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 4/30/15.
//
//

#import "PXLAlbumFilterOptions.h"

@implementation PXLAlbumFilterOptions

- (NSString *)urlParamString {
    NSMutableDictionary *options = @{}.mutableCopy;
    if(self.minInstagramFollowers){
        options[@"min_instagram_followers"] = @(self.minInstagramFollowers);
    }
    if(self.minTwitterFollowers){
        options[@"min_twitter_followers"] = @(self.minTwitterFollowers);
    }
    if(self.deniedPhotos != nil){
        if([self.deniedPhotos isEqualToNumber:[NSNumber numberWithInt:1]]){
            options[@"denied_photos"] = @(YES);
        }
        else if ([self.deniedPhotos isEqualToNumber:[NSNumber numberWithInt:0]]){
            options[@"denied_photos"] = @(NO);
        }
    }
    if(self.starredPhotos != nil){
        if([self.starredPhotos isEqualToNumber:[NSNumber numberWithInt:1]]){
            options[@"starred_photos"] = @(YES);
        }
        else if ([self.starredPhotos isEqualToNumber:[NSNumber numberWithInt:0]]){
            options[@"starred_photos"] = @(NO);
        }
    }
    if(self.deletedPhotos != nil){
        if([self.deletedPhotos isEqualToNumber:[NSNumber numberWithInt:1]]){
            options[@"deleted_photos"] = @(YES);
        }
        else if ([self.deletedPhotos isEqualToNumber:[NSNumber numberWithInt:0]]){
            options[@"deleted_photos"] = @(NO);
        }
    }
    if(self.flaggedPhotos != nil){
        if([self.flaggedPhotos isEqualToNumber:[NSNumber numberWithInt:1]]){
            options[@"flagged_photos"] = @(YES);
        }
        else if ([self.flaggedPhotos isEqualToNumber:[NSNumber numberWithInt:0]]){
            options[@"flagged_photos"] = @(NO);
        }
    }
    if(self.hasPermission != nil){
        if([self.hasPermission isEqualToNumber:[NSNumber numberWithInt:1]]){
            options[@"has_permission"] = @(YES);
        }
        else if ([self.hasPermission isEqualToNumber:[NSNumber numberWithInt:0]]){
            options[@"has_permission"] = @(NO);
        }
    }
    if(self.hasProduct != nil){
        if([self.hasProduct isEqualToNumber:[NSNumber numberWithInt:1]]){
            options[@"has_product"] = @(YES);
        }
        else if ([self.hasProduct isEqualToNumber:[NSNumber numberWithInt:0]]){
            options[@"has_product"] = @(NO);
        }
    }
    if(self.inStockOnly != nil){
        if([self.inStockOnly isEqualToNumber:[NSNumber numberWithInt:1]]){
            options[@"in_stock_only"] = @(YES);
        }
        else if ([self.inStockOnly isEqualToNumber:[NSNumber numberWithInt:0]]){
            options[@"in_stock_only"] = @(NO);
        }
    }
    
    if (self.contentSource) {
        options[@"content_source"] = self.contentSource;
    }
    if (self.contentType) {
        options[@"content_type"] = self.contentType;
    }
    if (self.filterBySubcaption) {
        options[@"filter_by_subcaption"] = self.filterBySubcaption;
    }
    if(self.hasActionLink != nil){
        if([self.hasActionLink isEqualToNumber:[NSNumber numberWithInt:1]]){
            options[@"has_action_link"] = @(YES);
        }
        else if ([self.hasActionLink isEqualToNumber:[NSNumber numberWithInt:0]]){
            options[@"has_action_link"] = @(NO);
        }
    }
    
    if (self.submittedDateStart) {
        options[@"submitted_date_start"] = @([self.submittedDateStart timeIntervalSince1970] * 1000);
    }
    if (self.submittedDateEnd) {
        options[@"submitted_date_end"] = @([self.submittedDateEnd timeIntervalSince1970] * 1000);
    }
    if(self.inCategories){
        options[@"in_categories"] = self.inCategories;
    }
    if(self.computerVision){
        NSError * err;
        NSData * jsonDataComputerVision = [NSJSONSerialization dataWithJSONObject:self.computerVision options:0 error:&err];
        options[@"computer_vision"] = [[NSString alloc] initWithData:jsonDataComputerVision encoding:NSUTF8StringEncoding];
    }
    if(self.filterByLocation){
        NSError * err;
        NSData * jsonDataFilterLocation = [NSJSONSerialization dataWithJSONObject:self.filterByLocation options:0 error:&err];
        options[@"filter_by_location"] = [[NSString alloc] initWithData:jsonDataFilterLocation encoding:NSUTF8StringEncoding];
    }
    if(self.filterByUserhandle){
        NSError * err;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self.filterByUserhandle options:0 error:&err];
        options[@"filter_by_location"] = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    if(self.filterByRadius){
        options[@"filter_by_radius"] = self.filterByRadius;
    }
    
    
    NSData *optionsData = [NSJSONSerialization dataWithJSONObject:options options:0 error:nil];
    NSString *optionsString = [[NSString alloc] initWithData:optionsData encoding:NSUTF8StringEncoding];
    return optionsString;
}

@end
