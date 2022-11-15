
//  ViewController.swift
//  OGallery
//
//  Created by Shruti on 14/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var galleryViewModel : GalleryViewModel!

    var arrResults: [GalleryModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.galleryViewModel =  GalleryViewModel()
        self.galleryViewModel.bindGalleryViewModelToController = {
            self.arrResults = self.galleryViewModel.galleryData
            print(self.arrResults)
        }
    }


}

