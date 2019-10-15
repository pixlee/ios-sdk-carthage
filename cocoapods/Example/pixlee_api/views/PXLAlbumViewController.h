//
//  PXLAlbumViewController.h
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 4/30/15.
//
//

#import <UIKit/UIKit.h>

#import <pixlee_api/PXLAlbum.h>

@interface PXLAlbumViewController : UIViewController
@property (nonatomic, strong) PXLAlbum *album;

@property (nonatomic, strong) UICollectionView *albumCollectionView;

+ (instancetype)albumViewControllerWithAlbumId:(NSString *)albumId;
- (void)loadNextPageOfPhotos;
- (void)loadNextPageOfPhotosFromSku;

@end
