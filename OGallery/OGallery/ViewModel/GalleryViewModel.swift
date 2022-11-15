//
//  GalleryViewModel.swift
//  OGallery
//
//  Created by Shruti on 14/11/22.
//

import Foundation

class GalleryViewModel : NSObject {
    
    private var apiService : APIParse!
    private(set) var galleryData : [GalleryModel]! {
        didSet {
            self.bindGalleryViewModelToController()
        }
    }
    
    var bindGalleryViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIParse()
        callFuncToGetGallerygData()
    }
    
    func callFuncToGetGallerygData() {
        self.apiService.apiGallery { (data) in
            self.galleryData = data
        }
    }
}
