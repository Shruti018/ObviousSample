//
//  DetailVC.swift
//  OGallery
//
//  Created by Shruti on 15/11/22.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var detailsCollectionView: UICollectionView!
 
    var collDelegate = GalleryCollectionViewDelegate()
    
    
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: (SCREEN_HEIGHT-150))
        layout.minimumLineSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    
    private var dataSource : GalleryCollectionViewCellDataSource<DetailCollectionViewCell,GalleryModel>!
    
    var data: [GalleryModel]!
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        self.detailsCollectionView.collectionViewLayout = flowLayout
        self.detailsCollectionView.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailCollectionViewCell")
        self.updateDataSource()
        self.delegateCall()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
            {
                self.detailsCollectionView.scrollToItem(at: NSIndexPath(item: self.selectedIndex, section: 0) as IndexPath, at: [], animated: false)

            }
    }
    
    
    
    
    func updateDataSource(){
        
        
        self.dataSource = GalleryCollectionViewCellDataSource(items: data, isGrid: false, configureCell: { (cell, model, index) in
            
            var posterUrl = URL(string: "")
            let posterString = "\(model.hdurl)"
            if let strUrl = "\(posterString)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                  let imgUrl = URL(string: strUrl) {
                posterUrl = imgUrl
            }
            
            switch cell {
            case let cell as DetailCollectionViewCell:
                cell.imgPoster.loadImageWithUrl(posterUrl!)
                cell.lblTitle.text = model.title
                cell.lblDesc.text = model.explanation
                cell.lblDate.text = model.date
                
           default:
                fatalError("Unkown cell type")
            }
               
            
        })
        
        DispatchQueue.main.async {
            self.detailsCollectionView.dataSource = self.dataSource
            self.detailsCollectionView.delegate = self.collDelegate
            self.detailsCollectionView.reloadData()
        }
    }
    
    func delegateCall() {
        collDelegate.selectedSetting = { [unowned self] selection in
            
        }
    }
   
   
}
