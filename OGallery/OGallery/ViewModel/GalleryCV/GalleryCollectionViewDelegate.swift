//
//  GalleryCollectionViewDelegate.swift
//  OGallery
//
//  Created by Shruti on 14/11/22.
//


import Foundation
import UIKit

class GalleryCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var selectedSetting: ((Int) -> ())? = .none
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSetting?(indexPath.row)
    }
}
