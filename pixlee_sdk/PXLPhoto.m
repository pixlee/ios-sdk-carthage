//
//  PXLPhoto.m
//  pixlee-ios-sdk
//
//  Created by Tim Shi on 4/30/15.
//
//

#import "PXLPhoto.h"
#import "PXLClient.h"
#import "PXLProduct.h"

@implementation PXLPhoto

+ (NSArray *)photosFromArray:(NSArray *)array inAlbum:(PXLAlbum *)album {
    NSMutableArray *photos = @[].mutableCopy;
    for (NSDictionary *dict in array) {
        PXLPhoto *photo = [self photoFromDict:dict inAlbum:album];
        [photos addObject:photo];
    }
    return photos;
}

+ (instancetype)photoFromDict:(NSDictionary *)dict inAlbum:(PXLAlbum *)album {
    PXLPhoto *photo = [PXLPhoto singlePhotoFromDict:dict];
    photo.album = album;
    return photo;
}


+ (instancetype)singlePhotoFromDict:(NSDictionary *)dict  {
    NSMutableDictionary *filteredDict = dict.mutableCopy;
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSNull class]]) {
            [filteredDict removeObjectForKey:key];
        }
    }];
    dict = filteredDict;
    PXLPhoto *photo = [self new];
    photo.identifier = dict[@"id"];
    photo.photoTitle = dict[@"photo_title"];
    if ([dict[@"latitude"] isKindOfClass:[NSNumber class]] && [dict[@"longitude"] isKindOfClass:[NSNumber class]]) {
        CLLocationDegrees latitude = [dict[@"latitude"] doubleValue];
        CLLocationDegrees longitude = [dict[@"longitude"] doubleValue];
        photo.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    }
    photo.taggedAt = [NSDate dateWithTimeIntervalSince1970:([dict[@"tagged_at"] doubleValue] / 1000)];
    photo.emailAddress = dict[@"email_address"];
    photo.instagramFollowers = [dict[@"instagram_followers"] integerValue];
    photo.twitterFollowers = [dict[@"twitter_followers"] integerValue];
    photo.avatarUrl = [self nilSafeUrlFromDict:dict forKey:@"avatar_url"];
    photo.username = dict[@"user_name"];
    photo.connectedUserId = [dict[@"connected_user_id"] integerValue];
    photo.source = dict[@"source"];
    photo.contentType = dict[@"content_type"];
    photo.dataFileName = dict[@"data_file_name"];
    photo.mediumUrl = [self nilSafeUrlFromDict:dict forKey:@"medium_url"];
    photo.bigUrl = [self nilSafeUrlFromDict:dict forKey:@"big_url"];
    photo.thumbnailUrl = [self nilSafeUrlFromDict:dict forKey:@"thumbnail_url"];
    photo.sourceUrl = [self nilSafeUrlFromDict:dict forKey:@"source_url"];
    photo.mediaId = dict[@"media_id"];
    photo.existIn = [dict[@"exist_in"] integerValue];
    photo.collectTerm = dict[@"collect_term"];
    photo.albumPhotoId = dict[@"album_photo_id"];
    photo.likeCount = [dict[@"like_count"] integerValue];
    photo.shareCount = [dict[@"share_count"] integerValue];
    photo.actionLink = [self nilSafeUrlFromDict:dict forKey:@"action_link"];
    photo.actionLinkText = dict[@"action_link_text"];
    photo.actionLinkTitle = dict[@"action_link_title"];
    photo.actionLinkPhoto = dict[@"action_link_photo"];
    photo.updatedAt = [NSDate dateWithTimeIntervalSince1970:([dict[@"updated_at"] doubleValue] / 1000)];
    photo.isStarred = [dict[@"is_starred"] boolValue];
    photo.approved = [dict[@"approved"] boolValue];
    photo.archived = [dict[@"archived"] boolValue];
    photo.isFlagged = [dict[@"is_flagged"] boolValue];
    photo.unreadCount = [dict[@"unread_count"] integerValue];
    photo.albumActionLink = [self nilSafeUrlFromDict:dict forKey:@"album_action_link"];
    photo.title = dict[@"title"];
    photo.messaged = [dict[@"messaged"] boolValue];
    photo.hasPermission = [dict[@"has_permission"] boolValue];
    photo.awaitingPermission = [dict[@"awaiting_permission"] boolValue];
    photo.instUserHasLiked = [dict[@"inst_user_has_liked"] boolValue];
    photo.platformLink = [self nilSafeUrlFromDict:dict forKey:@"platform_link"];
    photo.products = [PXLProduct productsFromArray:dict[@"products"] withPhoto:photo];
    photo.cdnSmallUrl =  [self nilSafeUrlFromDict:dict[@"pixlee_cdn_photos"] forKey:@"small_url"];
    photo.cdnMediumUrl = [self nilSafeUrlFromDict:dict[@"pixlee_cdn_photos"] forKey:@"medium_url"];
    photo.cdnLargeUrl = [self nilSafeUrlFromDict:dict[@"pixlee_cdn_photos"] forKey:@"large_url"];
    photo.cdnOriginalUrl = [self nilSafeUrlFromDict:dict[@"pixlee_cdn_photos"] forKey:@"original_url"];
    return photo;
}

+ (NSURLSessionDataTask *)getPhotoWithId:(NSString *)identifier callback:(void (^)(PXLPhoto *photo, NSError *error))completionBlock {
    static NSString * const PXLAlbumGETRequestString = @"media/%@";
    NSString *requestString = [NSString stringWithFormat:PXLAlbumGETRequestString, identifier];
    NSMutableDictionary *params = @{}.mutableCopy;
    NSURLSessionDataTask *dataTask = [[PXLClient sharedClient] GET:requestString parameters:params success:^(NSURLSessionDataTask * __unused task, id responseObject) {
        NSDictionary *responsePhoto = responseObject[@"data"];
        if (completionBlock) {
            completionBlock([PXLPhoto singlePhotoFromDict:responsePhoto], nil);
        }
    } failure:^(NSURLSessionDataTask * __unused task, NSError *error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
    return dataTask;
}

+ (NSURL *)nilSafeUrlFromDict:(NSDictionary *)dict forKey:(NSString *)key {
    NSString *urlString = dict[key];
    if (urlString) {
        return [NSURL URLWithString:urlString];
    }
    return nil;
}



- (NSString *)description {
    return [NSString stringWithFormat:@"<PXLPhoto:%@ %@>", self.identifier, self.title];
}

- (NSURL *)photoUrlForSize:(PXLPhotoSize)photoSize {
    switch (photoSize) {
        case PXLPhotoSizeThumbnail:
            return self.thumbnailUrl;
            break;
        case PXLPhotoSizeMedium:
            return self.mediumUrl;
            break;
        case PXLPhotoSizeBig:
            return self.bigUrl;
            break;
        default:
            return nil;
            break;
    }
}

- (UIImage *)sourceIconImage {
    if ([self.source isEqualToString:@"instagram"]) {
        return [UIImage imageNamed:@"instagram" inBundle:[NSBundle bundleWithIdentifier:@"Pixlee.pixlee-sdk"] compatibleWithTraitCollection:nil];
    } else if ([self.source isEqualToString:@"facebook"]) {
        return [UIImage imageNamed:@"facebook" inBundle:[NSBundle bundleWithIdentifier:@"Pixlee.pixlee-sdk"] compatibleWithTraitCollection:nil];
    } else if ([self.source isEqualToString:@"pinterest"]) {
        return [UIImage imageNamed:@"pinterest" inBundle:[NSBundle bundleWithIdentifier:@"Pixlee.pixlee-sdk"] compatibleWithTraitCollection:nil];
    } else if ([self.source isEqualToString:@"tumblr"]) {
        return [UIImage imageNamed:@"tumblr" inBundle:[NSBundle bundleWithIdentifier:@"Pixlee.pixlee-sdk"] compatibleWithTraitCollection:nil];
    } else if ([self.source isEqualToString:@"twitter"]) {
        return [UIImage imageNamed:@"twitter" inBundle:[NSBundle bundleWithIdentifier:@"Pixlee.pixlee-sdk"] compatibleWithTraitCollection:nil];
    } else if ([self.source isEqualToString:@"vine"]) {
        return [UIImage imageNamed:@"vine" inBundle:[NSBundle bundleWithIdentifier:@"Pixlee.pixlee-sdk"] compatibleWithTraitCollection:nil];
    }
    return nil;
}

@end
