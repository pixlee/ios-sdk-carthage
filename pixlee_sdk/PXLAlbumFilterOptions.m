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
    if(self.deniedPhotos){
        options[@"denied_photos"] = @(self.deniedPhotos);
    }
    if(self.starredPhotos){
        options[@"starred_photos"] = @(self.starredPhotos);
    }
    if(self.deletedPhotos){
        options[@"deleted_photos"] = @(self.deletedPhotos);
    }
    if(self.flaggedPhotos){
        options[@"flagged_photos"] = @(self.flaggedPhotos);
    }
    if(self.hasPermission){
         options[@"has_permission"] = @(self.hasPermission);
    }
    if(self.hasProduct){
        options[@"has_product"] = @(self.hasProduct);
    }
    
    if(self.inStockOnly){
        options[@"in_stock_only"] = @(self.inStockOnly);
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
    if(self.hasActionLink){
        options[@"has_action_link"] = @(self.hasActionLink);
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
