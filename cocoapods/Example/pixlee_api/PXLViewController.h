//
//  PXLViewController.h
//  pixlee_api
//
//  Created by pixlee-accounts on 10/14/2019.
//  Copyright (c) 2019 pixlee-accounts. All rights reserved.
//

@import UIKit;



#import "views/PXLAlbumViewController.h"
#import <pixlee_api/PXLProduct.h>


@interface PXLViewController : PXLAlbumViewController
@property (nonatomic, strong) PXLPhoto *photo;



@end
