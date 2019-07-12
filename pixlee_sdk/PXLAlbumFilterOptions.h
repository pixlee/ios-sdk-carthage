//
//  PXLAlbumFilterOptions.h
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 4/30/15.
//
//

#import <Foundation/Foundation.h>

/**
 `PXLAlbumFilterOptions` is used to control how an album filters the photos it loads. Create an instance of this class and set it to an album to control the options available as properties of this class.
 */

@interface PXLAlbumFilterOptions : NSObject

@property (nonatomic) NSUInteger minInstagramFollowers;
@property (nonatomic) NSUInteger minTwitterFollowers;
@property (nonatomic) NSNumber *deniedPhotos;
@property (nonatomic) NSNumber *starredPhotos;
@property (nonatomic) NSNumber *deletedPhotos;
@property (nonatomic) NSNumber *flaggedPhotos;
@property (nonatomic) NSNumber *hasPermission;
@property (nonatomic) NSNumber *hasProduct;
@property (nonatomic) NSNumber *inStockOnly;
@property (nonatomic, strong) NSMutableArray *contentSource;
@property (nonatomic, strong) NSMutableArray *contentType;
@property (nonatomic, strong) NSMutableArray *inCategories;
@property (nonatomic, copy) NSString *filterBySubcaption;
@property (nonatomic, copy) NSDictionary *filterByUserhandle;
@property (nonatomic) NSNumber *hasActionLink;
@property (nonatomic, strong) NSDate *submittedDateStart;
@property (nonatomic, strong) NSDate *submittedDateEnd;
@property (nonatomic, copy) NSDictionary *computerVision;
@property (nonatomic, copy) NSDictionary *filterByLocation;
@property (nonatomic, copy) NSString *filterByRadius;
- (NSString *)urlParamString;


@end
