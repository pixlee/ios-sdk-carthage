//
//  PXLViewController.m
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 04/30/2015.
//

#import "PXLExampleAlbumViewController.h"\

#import <pixlee_sdk/PXLAlbum.h>
#import <pixlee_sdk/PXLPhoto.h>
#import <pixlee_sdk/PXLAlbumFilterOptions.h>
#import <pixlee_sdk/PXLAlbumSortOptions.h>
#import <pixlee_sdk/PXLClient.h>

@interface PXLExampleAlbumViewController ()

@end

@implementation PXLExampleAlbumViewController

#warning Replace with your Pixlee album identifier.

static NSString * const PXLAlbumIdentifier = @"1726727";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a new album instance.
    PXLAlbum *album = [PXLAlbum albumWithIdentifier:PXLAlbumIdentifier];
    
    // Create and set filter options on the album.
    PXLAlbumFilterOptions *filterOptions = [PXLAlbumFilterOptions new];
    filterOptions.submittedDateStart = [[NSDate date] dateByAddingTimeInterval:-60 * 60 * 24 * 20]; // submitted within the last 20 days
    album.filterOptions = filterOptions;
    
    // Create and set sort options on the album.
    PXLAlbumSortOptions *sortOptions = [PXLAlbumSortOptions new];
    sortOptions.sortType = PXLAlbumSortTypePhotoRank;
    album.sortOptions = sortOptions;
    
    // Set the album to load.
    self.album = album;
    self.photo.identifier = @"187542438";
    [self.photo loadPhotoWithId:^(PXLPhoto *photo, NSError *error) {
        NSLog(@"%@", photo.cdnOriginalUrl);
        NSLog(@"%@", photo.cdnLargeUrl);
        NSLog(@"%@", photo.cdnMediumUrl);
        NSLog(@"%@", photo.cdnSmallUrl);
        NSLog(@"%@",error);
    }];
    NSLog(@"%@", album.photos);
    NSLog(@"logging");
    // Example of loading a photo with an identifier
//    [PXLPhoto getPhotoWithId:@"187542438" callback:^(PXLPhoto *photo, NSError *error) {
//        NSLog(@"%@", photo.cdnOriginalUrl);
//        NSLog(@"%@", photo.cdnLargeUrl);
//        NSLog(@"%@", photo.cdnMediumUrl);
//        NSLog(@"%@", photo.cdnSmallUrl);
//        NSLog(@"%@",error);
//    }];
    
    PXLPhoto.getPhotoWithId("187542438") { (photo, error) in
        print("cdnUrl: \(photo?.cdnOriginalUrl)")
    }

    
    [self loadNextPageOfPhotos];
}

@end
