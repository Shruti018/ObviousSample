//
//  GalleryCollectionViewCellDataSource.swift
//  OGallery
//
//  Created by Shruti on 14/11/22.
//

import Foundation
import UIKit

class GalleryCollectionViewCellDataSource<CELL : UICollectionViewCell,T> : NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
//    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (UICollectionViewCell, T, Int) -> () = {_,_,_ in }
    var isGrid = true
    
    init(items : [T], isGrid: Bool, configureCell : @escaping (UICollectionViewCell, T, Int) -> ()) {
        self.items =  items
        self.configureCell = configureCell
        self.isGrid = isGrid
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = self.items[indexPath.row]
        if isGrid {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
           
            self.configureCell(cell, item, indexPath.row)
           return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
             
              self.configureCell(cell, item, indexPath.row)
             return cell
        }
    }
    
    
    func deleteRowUpdate(index: Int) {
        
        items.remove(at: index)
    }
    
}
