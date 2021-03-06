//
//  PXLAlbumFilterOptions.m
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 4/30/15.
//
//

#import "PXLAlbumFilterOptions.h"

@implementation PXLAlbumFilterOptions

@synthesize deniedPhotos = _deniedPhotos;
@synthesize starredPhotos = _starredPhotos;
@synthesize deletedPhotos = _deletedPhotos;
@synthesize flaggedPhotos = _flaggedPhotos;
@synthesize hasPermission = _hasPermission;
@synthesize hasProduct = _hasProduct;
@synthesize inStockOnly = _inStockOnly;
@synthesize hasActionLink = _hasActionLink;



- (void)setDeniedPhotos:(BOOL)deniedPhotos{
    _deniedPhotos = deniedPhotos;
    self.flagDeniedPhotos = true;
}



- (void)setStarredPhotos:(BOOL)starredPhotos{
    _starredPhotos = starredPhotos;
    self.flagStarredPhotos = true;
}

- (void)setDeletedPhotos:(BOOL)deletedPhotos{
    _deletedPhotos = deletedPhotos;
    self.flagDeletedPhotos = true;
}

- (void)setFlaggedPhotos:(BOOL)flaggedPhotos{

    _flaggedPhotos = flaggedPhotos;
    self.flagFlaggedPhotos = true;
}


- (void)setHasPermission:(BOOL)hasPermission{
    _hasPermission = hasPermission;
    self.flagHasPermission = true;
}


- (void)setHasProduct:(BOOL)hasProduct{
    _hasProduct = hasProduct;
    self.flagHasProduct = true;
}

- (void)setInStockOnly:(BOOL)inStockOnly{
    _inStockOnly = inStockOnly;
    self.flagInStockOnly = true;
}

- (void)setHasActionLink:(BOOL)hasActionLink{
    _hasActionLink = hasActionLink;
    self.flagHasActionLink = true;
}

- (NSString *)urlParamString {
    NSMutableDictionary *options = @{}.mutableCopy;
    if(self.minInstagramFollowers){
        options[@"min_instagram_followers"] = [NSString stringWithFormat:@"%li",  self.minInstagramFollowers];
    }
    if(self.minTwitterFollowers){
        options[@"min_twitter_followers"] = [NSString stringWithFormat:@"%li",  self.minTwitterFollowers];
    }
    if(self.flagDeniedPhotos ){
        if(self.deniedPhotos){
            options[@"denied_photos"] = @(YES);
        }
        else {
            options[@"denied_photos"] = @(NO);
        }
    }
    if(self.flagStarredPhotos){
        if(self.starredPhotos){
            options[@"starred_photos"] = @(YES);
        }
        else {
            options[@"starred_photos"] = @(NO);
        }
    }
    if(self.flagDeletedPhotos){
        if(self.deletedPhotos){
            options[@"deleted_photos"] = @(YES);
        }
           else {
            options[@"deleted_photos"] = @(NO);
        }
    }
    if(self.flagFlaggedPhotos){
        if(self.flaggedPhotos){
            options[@"flagged_photos"] = @(YES);
        }
           else{
            options[@"flagged_photos"] = @(NO);
        }
    }
    if(self.flagHasPermission){
        if(self.hasPermission){
            options[@"has_permission"] = @(YES);
        }
        else{
            options[@"has_permission"] = @(NO);
        }
    }
    if(self.flagHasProduct){
        if(self.hasProduct){
            options[@"has_product"] = @(YES);
        }
        else{
            options[@"has_product"] = @(NO);
        }
    }
    if(self.flagInStockOnly){
        if(self.inStockOnly){
            options[@"in_stock_only"] = @(YES);
        }
        else {
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
    if(self.flagHasActionLink){
        if(self.hasActionLink){
            options[@"has_action_link"] = @(YES);
        }
        else {
            options[@"has_action_link"] = @(NO);
        }
    }
    
    if (self.submittedDateStart) {
        options[@"submitted_date_start"] = @([self.submittedDateStart timeIntervalSince1970] );
    }
    if (self.submittedDateEnd) {
        options[@"submitted_date_end"] = @([self.submittedDateEnd timeIntervalSince1970] );
    }
    if(self.inCategories){
        options[@"in_categories"] = self.inCategories;
    }
    if(self.computerVision){
        [options setObject:self.computerVision forKey:@"computer_vision"];
    }
    if(self.filterByLocation){
        [options setObject:self.filterByLocation forKey:@"filter_by_location"];
    }
    if(self.filterByUserhandle){
        [options setObject:self.filterByUserhandle forKey:@"filter_by_userhandle"];
    }
    if(self.filterByRadius){
        options[@"filter_by_radius"] = self.filterByRadius;
    }
    
    
    NSData *optionsData = [NSJSONSerialization dataWithJSONObject:options options:0 error:nil];
    NSString *optionsString = [[NSString alloc] initWithData:optionsData encoding:NSUTF8StringEncoding];
    return optionsString;
}

@end
