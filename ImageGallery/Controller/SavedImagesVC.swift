//
//  SavedImagesVC.swift
//  ImageGallery
//
//  Created by iAsad on 25/08/2023.
//

import UIKit

class SavedImagesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arr = DataBaseHelper.shareInstance.fetchImages()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SavedImagesCell", for: indexPath) as! SavedImagesCell
      //  cell.savedImageView.image = arr[IndexPath]
        
    
            
            let imageData = arr[indexPath.item]
                cell.savedImageView.image =  imageData.image
            
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
//    func loadImages()
//    {
//
//                if(arr[0] != nil)
//                {
//                    fetchImageView.image = UIImage(data: arr[0].img!)
//
//                }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
