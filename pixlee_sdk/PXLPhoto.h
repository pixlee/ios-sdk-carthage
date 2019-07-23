//
//  PXLPhoto.h
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 4/30/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "PXLAlbum.h"

typedef NS_ENUM(NSInteger, PXLPhotoSize) {
    PXLPhotoSizeThumbnail,
    PXLPhotoSizeMedium,
    PXLPhotoSizeBig
};


/**
 `PXLPhoto` represents a photo object in the Pixlee API. `PXLPhoto` objects are created by their parent `PXLAlbum` when loaded from the server.
 */

@interface PXLPhoto : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *photoTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSDate *taggedAt;
@property (nonatomic, copy) NSString *emailAddress;
@property (nonatomic) NSInteger instagramFollowers;
@property (nonatomic) NSInteger twitterFollowers;
@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, copy) NSString *username;
@property (nonatomic) NSInteger connectedUserId;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSString *dataFileName;
@property (nonatomic, strong) NSURL *mediumUrl;
@property (nonatomic, strong) NSURL *bigUrl;
@property (nonatomic, strong) NSURL *thumbnailUrl;
@property (nonatomic, strong) NSURL *sourceUrl;
@property (nonatomic, copy) NSString *mediaId;
@property (nonatomic) NSInteger existIn;
@property (nonatomic, copy) NSString *collectTerm;
@property (nonatomic, copy) NSString *albumPhotoId;
@property (nonatomic) NSInteger likeCount;
@property (nonatomic) NSInteger shareCount;
@property (nonatomic, strong) NSURL *actionLink;
@property (nonatomic, copy) NSString *actionLinkText;
@property (nonatomic, copy) NSString *actionLinkTitle;
@property (nonatomic, copy) NSString *actionLinkPhoto;
@property (nonatomic, strong) NSDate *updatedAt;
@property (nonatomic) BOOL isStarred;
@property (nonatomic) BOOL approved;
@property (nonatomic) BOOL archived;
@property (nonatomic) BOOL isFlagged;
@property (nonatomic, strong) PXLAlbum *album;
@property (nonatomic) NSInteger unreadCount;
@property (nonatomic, strong) NSURL *albumActionLink;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) BOOL messaged;
@property (nonatomic) BOOL hasPermission;
@property (nonatomic) BOOL awaitingPermission;
@property (nonatomic) BOOL instUserHasLiked;
@property (nonatomic, strong) NSURL *platformLink;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSURL *cdnSmallUrl;
@property (nonatomic, strong) NSURL *cdnMediumUrl;
@property (nonatomic, strong) NSURL *cdnLargeUrl;
@property (nonatomic, strong) NSURL *cdnOriginalUrl;


/**
 This function creates and returns an array of `PXLPhoto` objects when passed in an array that comes from the Pixlee API.
 
 @param array The array object loaded from the Pixlee API.
 @param album The parent album for the photos.
 
 @return An array containing `PXLPhoto` objects.
 */
+ (NSArray *)photosFromArray:(NSArray *)array inAlbum:(PXLAlbum *)album;

+ (instancetype)photoFromDict:(NSDictionary *)dict inAlbum:(PXLAlbum *)album;
+ (instancetype)singlePhotoFromDict:(NSDictionary *)dict;

+ (NSURLSessionDataTask *)getPhotoWithId:(NSString *)identifier callback:(void (^)(PXLPhoto *photo, NSError *error))completionBlock;

- (NSURL *)photoUrlForSize:(PXLPhotoSize)photoSize;

- (UIImage *)sourceIconImage;

///---------------------
/// @name Analytics Event
///---------------------

/**
 User takes an Action after Clicking on an Item.
 
 @param action_link from PXLPhoto class. callback A block called after the photos have been loaded or an error has occurred.
 
 @return The `NSURLSessionDataTask` the server will retun 'OK' if accepted.
 */
- (NSURLSessionDataTask *)triggerEventActionClicked:(NSString *)action_link callback:(void (^)(NSError *error))completionBlock;

@end
