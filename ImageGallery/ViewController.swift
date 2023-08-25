//
//  ViewController.swift
//  ImageGallery
//
//  Created by iAsad on 24/08/2023.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  lblTotalAttachments.text = String(attachments.count)
        return attachments.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
             let item = attachments[indexPath.row]
             let label1 = cell.viewWithTag(1) as! UIImageView
             

             
             
             return cell
    }
    
    
    
    struct AAttachmentsModal : Codable {
        var type : String?
        var mediaString : String?
        var mediaPath : String?
        var mediaData : Data?
        var mediaURL : String?
    }
    
    
    let datePicker = UIDatePicker()
    var imagePicker:UIImagePickerController!
    var attachments = [AAttachmentsModal]()
    
    @IBOutlet weak var cView: UICollectionView!
    
    
    
    @IBAction func picBtn(_ sender: Any)
    
    {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            (action) in
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker,animated: true, completion: nil)
        }
        
        let albumAction = UIAlertAction(title: "Use Gallery", style: .default){
            (action) in
            
//            self.imagePicker.sourceType = .savedPhotosAlbum
//            //self.imagePicker.mediaTypes = [kUTTypeImage as String]
//            self.present(self.imagePicker, animated: true, completion: nil)
            
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(albumAction)
        alertController.addAction(cancelAction)
        UIImagePickerController.InfoKey.editedImage
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let choosanimage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        var attachment = AAttachmentsModal()
        attachment.type = String(1);
        attachment.mediaString = "Attachment_" + String(1)
        let compressImage = choosanimage.resizeWithWidth(width: 700)
        attachment.mediaData = compressImage!.jpegData(compressionQuality: 0.1)!
        attachments.append(attachment)

        cView.reloadData()
        
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cView.delegate = self
        cView.dataSource = self
        cView.backgroundColor = nil
    }


}


extension UIImage {
    func resizeWithPercent(percentage: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: size.width * percentage, height: size.height * percentage)))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
    func resizeWithWidth(width: CGFloat) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = .scaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return result
    }
}
