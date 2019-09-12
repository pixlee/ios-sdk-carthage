//
//  FirstViewController.swift
//  pixlee_example
//
//  Created by Mohamed Rachidi on 9/9/19.
//  Copyright © 2019 Pixlee. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let PXLAlbumIdentifier = "4515393"

        let PXLSkuAlbumIdentifier = "300152"

        
        let album: PXLAlbum = PXLAlbum(skuIdentifier: PXLSkuAlbumIdentifier)
        let filterOptions:PXLAlbumFilterOptions = PXLAlbumFilterOptions()

        album.filterOptions = filterOptions
        
        // Create and set sort options on the album.
        let sortOptions = PXLAlbumSortOptions()
        sortOptions.sortType = PXLAlbumSortType.random
        sortOptions.ascending = true
        album.sortOptions = sortOptions
        album.perPage = 1
        
        album.loadNextPageOfPhotos(fromSku:  { photos, error in
            if let error = error {
                print("\(error)")
            }
            print(type(of: photos))
            if photos?.count != nil {

                if let arr = photos as? Array<PXLPhoto> {
                    for p in arr{
                        print(p.cdnLargeUrl)
                        
                    }
                    print(arr)
                }

            }
            
        })
    }


}

