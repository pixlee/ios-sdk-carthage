//
//  PXLAlbum.h
//  Pods
//
//  Created by Mohamed Rachidi on 10/14/19.
//

#ifndef PXLAlbum_h
#define PXLAlbum_h


#endif /* PXLAlbum_h */
#import <Foundation/Foundation.h>

#import "PXLAlbumSortOptions.h"
#import "PXLAlbumFilterOptions.h"

/**
 `PXLAlbum` represents an album on the Pixlee platform.
 It handles the loading of data from the Pixlee server for you (as long as your `PXLClient` has been initialized).
 The `PXLAlbum` supports infinite scroll UI by calling `loadNextPageOfPhotos:`.
 */

@interface PXLAlbum : NSObject

/**
 The unique identifier for this album. Must be set using the convenience initializer `albumWithIdentifier:`
 */
@property (nonatomic, copy, readonly) NSString *identifier;

/**
 The unique identifier for this album sku.
 */
@property (nonatomic, copy, readonly) NSString *sku;

/**
 The number of photos to load per page. Changing this will clear all existing photos and require a reload of the album.
 */
@property (nonatomic) NSInteger perPage;

/**
 The `PXLPhoto` objects that have been loaded for this album.
 */
@property (nonatomic, readonly) NSArray *photos;

/**
 The last page successfully fetched from the server. Returns `NSNotFound` if no pages have been loaded.
 */
@property (nonatomic, readonly) NSInteger lastPageFetched;

/**
 Returns whether or not there are more photos to load (based on the response of the last call to the server).
 */
@property (nonatomic, readonly) BOOL hasNextPage;

/**
 Create and set a `PXLAlbumSortOptions` object to specify how the photos should be sorted.
 Changing this will clear all existing photos and require a reload of the album.
 */
@property (nonatomic, strong) PXLAlbumSortOptions *sortOptions;

/**
 Create and set a `PXLAlbumFilterOptions` object to specify how the photos should be filtered when making a server request.
 Changing this will clear all existing photos and require a reload of the album.
 */
@property (nonatomic, strong) PXLAlbumFilterOptions *filterOptions;

///---------------------
/// @name Initialization
///---------------------

/**
 Creates and returns an album with the specified identifier.
 
 @param identifier The Pixlee album identifier.
 
 @return A new `PXLAlbum` object.
 */
+ (instancetype)albumWithIdentifier:(NSString *)identifier;


///---------------------
/// @name Initialization
///---------------------

/**
 Creates and returns an album with the specified sku identifier.
 
 @param sku The Pixlee Sku identifier.
 
 @return A new `PXLAlbum` object.
 */
+ (instancetype)albumWithSkuIdentifier:(NSString *)sku;


///---------------------
/// @name Initialization
///---------------------

/**
 Creates and returns an album with the specified sku identifier.
 
 @param photo_uri image url.albumId is the Pixlee id to upload the image. email the user email. Username of the user uploading the email. approved photo state. connected_user_id optional. callback function.
 
 @return A callback function
 */
+ (NSURLSessionDataTask *)uploadImage:(NSNumber *)albumId :(NSString *)title :(NSString *)email :(NSString *)username  :(NSString *)photo_uri :(BOOL *)approved :(NSString *)connected_user_id callback:(void (^)(NSError *))completionBlock;

///---------------------
/// @name Photo Loading
///---------------------

/**
 Loads the next page of photos from the server. Each page will only be loaded once.
 
 @param completionBlock A block called after the photos have been loaded or an error has occurred.
 `photos` will contain the photos loaded in this network call.
 
 @return The `NSURLSessionDataTask` used to load the data from the server. With two parameters NSarray<PXLPhoto>  and NSerror, if using swift cast it to the correct type Check Readme.
 */
- (NSURLSessionDataTask *)loadNextPageOfPhotos:(void (^)(NSArray *photos, NSError *error))completionBlock;

///---------------------
/// @name Photo Loading
///---------------------

/**
 Loads the next page of photos from the server. Each page will only be loaded once.
 
 @param completionBlock A block called after the photos have been loaded or an error has occurred.
 `photos` will contain the photos loaded in this network call.
 
 @return The `NSURLSessionDataTask` used to load the data from the server. With two parameters NSarray<PXLPhoto>  and NSerror, if using swift cast it to the correct type Check Readme.
 */
- (NSURLSessionDataTask *)loadNextPageOfPhotosFromSku:(void (^)(NSArray *photos, NSError *error))completionBlock;


///---------------------
/// Analytics Events
///---------------------

// Please refer to the Pixlee https://developers.pixlee.com/docs/analytics-events-tracking-pixel-guide for more information

///---------------------
/// @name Analytics Event
///---------------------

/**
 Trigger opened widget to the Pixlee backend.
 
 @param widget type 'photowall','horizontal'....
callback A block called after the photos have been loaded or an error has occurred.
 
 @return The `NSURLSessionDataTask` the server will retun 'OK' if accepted.
 */
- (NSURLSessionDataTask *)triggerEventOpenedWidget:(NSString *)widget callback:(void (^)(NSError *error))completionBlock;



///---------------------
/// @name Analytics Event
///---------------------

/**
Call this whenever a user clicks 'Load More' button on the widget
 
 
 @return The `NSURLSessionDataTask` the server will retun 'OK' if accepted.
 */
- (NSURLSessionDataTask *)triggerEventLoadMoreClicked:(void (^)(NSError *error))completionBlock;





@end
