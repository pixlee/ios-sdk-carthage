//
//  PXLAlbum.m
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 4/30/15.
//
//

#import "PXLAlbum.h"

#import "PXLClient.h"
#import "PXLPhoto.h"

@interface PXLAlbum ()

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic) NSInteger lastPageFetched;
@property (nonatomic) BOOL hasNextPage;
@property (nonatomic, strong) NSMutableDictionary *loadingOperations;

@end

@implementation PXLAlbum

const NSInteger PXLAlbumDefaultPerPage = 20;

+ (instancetype)albumWithIdentifier:(NSString *)identifier {
    PXLAlbum *album = [self new];
    album.identifier = identifier;
    return album;
}

+ (instancetype)albumWithSkuIdentifier:(NSString *)sku {
    PXLAlbum *album = [self new];
    album.sku = sku;
    return album;
}

- (instancetype)init {
    self = [super init];
    self.perPage = PXLAlbumDefaultPerPage;
    self.lastPageFetched = NSNotFound;
    self.hasNextPage = YES;
    self.photos = @[];
    self.loadingOperations = @{}.mutableCopy;
    return self;
}

- (void)setPerPage:(NSInteger)perPage {
    _perPage = perPage;
    [self clearPhotosAndPages];
}

- (void)setSortOptions:(PXLAlbumSortOptions *)sortOptions {
    _sortOptions = sortOptions;
    [self clearPhotosAndPages];
}

- (void)setFilterOptions:(PXLAlbumFilterOptions *)filterOptions {
    _filterOptions = filterOptions;
    [self clearPhotosAndPages];
}

- (void)clearPhotosAndPages {
    self.photos = @[];
    self.lastPageFetched = NSNotFound;
    self.hasNextPage = YES;
    [self.loadingOperations removeAllObjects];
}

- (NSURLSessionDataTask *)loadNextPageOfPhotos:(void (^)(NSArray *photos, NSError *error))completionBlock {
    static NSString * const PXLAlbumGETRequestString = @"albums/%@/photos";
    // make sure there's more content to load
    if (self.hasNextPage) {
        NSInteger nextPage = self.lastPageFetched == NSNotFound ? 1 : self.lastPageFetched + 1;
        // make sure we aren't already loading that page
        if (!self.loadingOperations[@(nextPage)]) {
            NSString *requestString = [NSString stringWithFormat:PXLAlbumGETRequestString, self.identifier];
            NSMutableDictionary *params = @{}.mutableCopy;
            if (self.sortOptions) {
                params[@"sort"] = [self.sortOptions urlParamString];
            }
            if (self.filterOptions) {
                params[@"filters"] = [self.filterOptions urlParamString];
            }
            if (self.perPage) {
                params[@"per_page"] = [NSString stringWithFormat:@"%li", self.perPage];
            }
            if (self.lastPageFetched != NSNotFound) {
                params[@"page"] = @(self.lastPageFetched + 1);
            }
            NSURLSessionDataTask *dataTask = [[PXLClient sharedClient] GET:requestString parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject) {
                NSArray *responsePhotos = responseObject[@"data"];
                NSArray *photos = [PXLPhoto photosFromArray:responsePhotos inAlbum:self];
                if (self.lastPageFetched == NSNotFound) {
                    self.lastPageFetched = [responseObject[@"page"] integerValue];
                } else {
                    self.lastPageFetched = MAX(self.lastPageFetched, [responseObject[@"page"] integerValue]);
                }
                self.hasNextPage = [responseObject[@"next"] boolValue];
                if (photos) {
                    NSMutableArray *mutablePhotos = self.photos.mutableCopy;
                    // add filler photos if necessary (in the case that page 2 loads before page 1)
                    if (mutablePhotos.count != self.perPage * (nextPage - 1)) {
                        NSInteger numPhotosToAdd = (self.perPage * (nextPage - 1)) - mutablePhotos.count;
                        for (int i = 0; i < numPhotosToAdd; i++) {
                            [mutablePhotos addObject:[PXLPhoto new]];
                        }
                    }
                    [mutablePhotos addObjectsFromArray:photos];
                    self.photos = mutablePhotos;
                }
                // release the data task by replacing it with a BOOL
                self.loadingOperations[@(nextPage)] = @YES;
                completionBlock(photos, nil);
            } failure:^(NSURLSessionDataTask * __unused task, NSError *error) {
                if (completionBlock) {
                    completionBlock(nil, error);
                }
            }];
            self.loadingOperations[@(nextPage)] = dataTask;
            return dataTask;
        } else {
            completionBlock(nil, nil);
            return nil;
        }
    } else {
        completionBlock(nil, nil);
        return nil;
    }
}

- (NSURLSessionDataTask *)loadNextPageOfPhotosFromSku:(void (^)(NSArray *photos, NSError *error))completionBlock {
//    static NSString * const PXLAlbumGETRequestString = @"albums/from_sku";
    // make sure there's more content to load
    if (self.hasNextPage) {
        NSInteger nextPage = self.lastPageFetched == NSNotFound ? 1 : self.lastPageFetched + 1;
        // make sure we aren't already loading that page
        if (!self.loadingOperations[@(nextPage)]) {
            NSString *requestString = @"albums/from_sku";
            NSMutableDictionary *params = @{}.mutableCopy;
            if(self.sku){
                params[@"sku"] = self.sku;
            }
            if (self.sortOptions) {
                params[@"sort"] = [self.sortOptions urlParamString];
            }
            if (self.filterOptions) {
                params[@"filters"] = [self.filterOptions urlParamString];
            }
            if (self.perPage) {
                params[@"per_page"] = [NSString stringWithFormat:@"%li", self.perPage];
            }
            if (self.lastPageFetched != NSNotFound) {
                params[@"page"] = @(self.lastPageFetched + 1);
            }
            NSURLSessionDataTask *dataTask = [[PXLClient sharedClient] GET:requestString parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject) {
                self.identifier = responseObject[@"album_id"];
                NSArray *responsePhotos = responseObject[@"data"];
                NSArray *photos = [PXLPhoto photosFromArray:responsePhotos inAlbum:self];
                if (self.lastPageFetched == NSNotFound) {
                    self.lastPageFetched = [responseObject[@"page"] integerValue];
                } else {
                    self.lastPageFetched = MAX(self.lastPageFetched, [responseObject[@"page"] integerValue]);
                }
                self.hasNextPage = [responseObject[@"next"] boolValue];
                if (photos) {
                    NSMutableArray *mutablePhotos = self.photos.mutableCopy;
                    // add filler photos if necessary (in the case that page 2 loads before page 1)
                    if (mutablePhotos.count != self.perPage * (nextPage - 1)) {
                        NSInteger numPhotosToAdd = (self.perPage * (nextPage - 1)) - mutablePhotos.count;
                        for (int i = 0; i < numPhotosToAdd; i++) {
                            [mutablePhotos addObject:[PXLPhoto new]];
                        }
                    }
                    [mutablePhotos addObjectsFromArray:photos];
                    self.photos = mutablePhotos;
                }
                // release the data task by replacing it with a BOOL
                self.loadingOperations[@(nextPage)] = @YES;
                completionBlock(photos, nil);
            } failure:^(NSURLSessionDataTask * __unused task, NSError *error) {
                if (completionBlock) {
                    completionBlock(nil, error);
                }
            }];
            self.loadingOperations[@(nextPage)] = dataTask;
            return dataTask;
        } else {
            completionBlock(nil, nil);
            return nil;
        }
    } else {
        completionBlock(nil, nil);
        return nil;
    }
}



- (NSURLSessionDataTask *)triggerEventOpenedWidget:(NSString *)widget  callback:(void (^)(NSError *))completionBlock{
    static NSString * const PXLAnalyticsPOSTRequestString = @"https://inbound-analytics.pixlee.com/events/openedWidget";
    NSMutableDictionary *params = @{}.mutableCopy;
    if(self.sku){
        [params setObject:self.sku forKey:@"album_id"];
    }else{
        [params setObject:self.identifier forKey:@"album_id"];
    }
    [params setObject:widget forKey:@"widget"];
    [params setObject:@"ios" forKey:@"platform"];
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [params setObject:udid forKey:@"uid"];
    
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

-(NSURLSessionDataTask *)triggerEventOpenedLightbox:(NSString *)album_photo_id callback:(void (^)(NSError *))completionBlock{
    static NSString * const PXLAnalyticsPOSTRequestString = @"https://inbound-analytics.pixlee.com/events/openedLightbox";
    NSMutableDictionary *params = @{}.mutableCopy;
    if(self.sku){
        [params setObject:self.sku forKey:@"album_id"];
    }else{
        [params setObject:self.identifier forKey:@"album_id"];
    }
    [params setObject:album_photo_id forKey:@"album_photo_id"];
    [params setObject:@"ios" forKey:@"platform"];
    NSString *udid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    [params setObject:udid forKey:@"uid"];
    
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
