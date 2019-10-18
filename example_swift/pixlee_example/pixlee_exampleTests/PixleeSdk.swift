//
//  PixleeTests.swift
//  pixlee_example
//
//  Created by Mohamed Rachidi on 10/1/19.
//  Copyright © 2019 Pixlee. All rights reserved.
//

import XCTest

class PixleeSdk: XCTestCase {

    private var album: PXLAlbum!
    
    override func setUp() {
        
        
        #warning("Replace with your Secret Key if you are making POST requests.")
        let api_key = "Hz7VLPHt7ow-oY992rJi"
        let secret_key = "secret"

        PXLClient.shared().setApiKey(api_key)
        PXLClient.shared().setSecretKey(secret_key)

        
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndpointAlbums() {
        let expectation = self.expectation(description: "Album query")
        let PXLSkuAlbumIdentifier = "300152"
        let filterOptions:PXLAlbumFilterOptions = PXLAlbumFilterOptions()
        let album: PXLAlbum = PXLAlbum(skuIdentifier: PXLSkuAlbumIdentifier)
        
        
        album.filterOptions = filterOptions
        
        
        let sortOptions = PXLAlbumSortOptions()
        sortOptions.sortType = PXLAlbumSortType.random
        sortOptions.ascending = true
        album.sortOptions = sortOptions
        album.perPage = 1

        album.loadNextPageOfPhotos(fromSku:  { photos, error in

            if(error == nil){
            expectation.fulfill()
            }
            
            
        })
        
        wait(for:[expectation],timeout:20)
    }


    
    func testAnalyticsAddCart() {
        let expectation = self.expectation(description: "Analytics Event add to cart")
        let currency = "USD"
        let product_sku = "SL-BENJ"
        let price = "13.00"
        let quantity = NSNumber(value: 2)

        PXLAnalytics.triggerEventAddCart(product_sku, quantity, price, currency, callback: { error in
            if(error == nil){
            expectation.fulfill()
            }
        })
        wait(for:[expectation],timeout:20)
        
    }

    func testAnalyticsConvertedPhoto() {
        let expectation = self.expectation(description: "Analytics Event Converted photo")

         let currency = "USD"

         let product_sku = "SL-BENJ"
         let price = "13.00"
        let quantity = NSNumber(value: 2)

         let product_sku2 = "AD-1324S"
         let price2 = "53.07"
        let quantity2 = NSNumber(value: 5)

        var cart1 = [AnyHashable : Any](minimumCapacity: 10)
        cart1["price"] = price
        cart1["product_sku"] = product_sku
        cart1["quantity"] = quantity
        var cart2 = [AnyHashable : Any](minimumCapacity: 10)
        cart2["price"] = price2
        cart2["product_sku"] = product_sku2
        cart2["quantity"] = quantity2

        let quantity_total = NSNumber(value: 7)
        let order_id = NSNumber(value: 234232)
        let cart_total = NSNumber(value: 18.00)

        let cart_contents:NSMutableArray = [cart1, cart2]

        



        PXLAnalytics.triggerEventConvertedPhoto(cart_contents, cart_total, quantity_total, order_id, currency, callback: { error in
            if(error == nil){
            expectation.fulfill()
            }
        })
              
        wait(for:[expectation],timeout:5)
    }
    func testAnalyticsOpenedWidget() {
        let expectation = self.expectation(description: "Analytics Event Opened Widgets")

        let PXLSkuAlbumIdentifier = "300152"


        let filterOptions:PXLAlbumFilterOptions = PXLAlbumFilterOptions()
        let album: PXLAlbum = PXLAlbum(skuIdentifier: PXLSkuAlbumIdentifier)
        album.triggerEventOpenedWidget("horizontal", callback: { error in
            if(error == nil){
               expectation.fulfill()
            }
            })
        wait(for:[expectation],timeout:5)
    }
    
    func testAnalyticsOpenedLightbox() {
        let expectation = self.expectation(description: "Analytics Event Opened Lightbox")


           PXLPhoto.getWithId("299469263", callback: { photo, error in
        photo?.triggerEventOpenedLightbox({ error in
            if(error == nil){
            expectation.fulfill()
            }
        })
            
   })
        wait(for:[expectation],timeout:5)
    }
    func testAnalyticsActionClicked() {
        let expectation = self.expectation(description: "Analytics Event Action Clicked")
        PXLPhoto.getWithId("299469263", callback: { photo, error in
            let p = photo?.products[0] as? PXLProduct
            let url = p?.link.absoluteString.removingPercentEncoding
            print("\(url ?? "")")

            photo?.triggerEventActionClicked(url, callback: { error in
                if(error == nil){
                    expectation.fulfill()
                }
            })

        })
        
        wait(for:[expectation],timeout:5)

    }
    func testAnalyticsLoadMoreClicked() {
        let expectation = self.expectation(description: "Analytics Load More Clicked")
        let PXLSkuAlbumIdentifier = "300152"
        
        let album: PXLAlbum = PXLAlbum(skuIdentifier: PXLSkuAlbumIdentifier)
        
        album.triggerEventLoadMoreClicked({ error in
            if error == nil {
                expectation.fulfill()
            }
        })

        wait(for:[expectation],timeout:5)
    }
    func testUploadImage() {
        let expectation = self.expectation(description: "Upload Image to Album")
        var albumId = "4515393"
        let f = NumberFormatter()
        f.numberStyle = .decimal
        let albumId_nb = f.number(from: albumId)

        var passThrough: ObjCBool = true
        PXLAlbum.uploadImage(albumId_nb, "tes", "test@email", "test", "https://cdn.pixabay.com/photo/2016/09/01/10/23/image-1635747_1280.jpg", &passThrough, "", callback: { error in
            expectation.fulfill()
        })
        
        wait(for:[expectation],timeout:5)

    }
}
