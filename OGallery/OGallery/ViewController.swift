
//  ViewController.swift
//  OGallery
//
//  Created by Shruti on 14/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!
 
    var collDelegate = GalleryCollectionViewDelegate()
    
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (SCREEN_WIDTH-30)/3, height: (SCREEN_WIDTH-30)/3)
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    
    private var dataSource : GalleryCollectionViewCellDataSource<GalleryCollectionViewCell,GalleryModel>!
    
    private var galleryViewModel : GalleryViewModel!
    var arrResults: [GalleryModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "NASA Gallery"
        setUpCollectionView()
        callToViewModelForUIUpdate()
    }
    
    func setUpCollectionView() {
        self.galleryCollectionView.collectionViewLayout = flowLayout
        self.galleryCollectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCollectionViewCell")
    }
    
    
    func callToViewModelForUIUpdate(){
        
        self.galleryViewModel =  GalleryViewModel()
        self.galleryViewModel.bindGalleryViewModelToController = {
            self.arrResults = self.galleryViewModel.galleryData
            self.updateDataSource()
            self.delegateCall()
        }
    }
    
    func updateDataSource(){
        
        
        self.dataSource = GalleryCollectionViewCellDataSource(items: arrResults, isGrid: true, configureCell: { (cell, model, index) in
            
            var posterUrl = URL(string: "")
            let posterString = "\(model.url)"
            if let strUrl = "\(posterString)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                  let imgUrl = URL(string: strUrl) {
                posterUrl = imgUrl
            }
            
            switch cell {
            case let cell as GalleryCollectionViewCell:
                cell.imgPoster.loadImageWithUrl(posterUrl!)
           default:
                fatalError("Unkown cell type")
            }
               
            
        })
        
        DispatchQueue.main.async {
            self.galleryCollectionView.dataSource = self.dataSource
            self.galleryCollectionView.delegate = self.collDelegate
            self.galleryCollectionView.reloadData()
        }
    }
    
    func delegateCall() {
        collDelegate.selectedSetting = { [unowned self] selection in
            let data = self.galleryViewModel.galleryData
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
            vc.data = data
            vc.selectedIndex = selection
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
   
   
}
