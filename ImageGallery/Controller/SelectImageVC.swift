//
//  SelectImageVC.swift
//  ImageGallery
//
//  Created by iAsad on 25/08/2023.
//

import UIKit

class SelectImageVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {

    @IBOutlet weak var saveImageView: UIImageView!


    
    let datePicker = UIDatePicker()
    var imagePicker:UIImagePickerController!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveImageView.layer.cornerRadius = 12
    }


    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        picker.dismiss(animated: true, completion: nil)
        guard let userPickedImage = info[.editedImage] as? UIImage else { return }
        saveImageView.image = userPickedImage

        picker.dismiss(animated: true)
    }
    
     func galleryButtonPressed() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        
    }
    
     func cameraButtonPressed() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .camera
        present(picker, animated: true)
        

    }



    @IBAction func saveImageButtonPressed(_ sender: UIButton) {
        let imageID = generateUniqueImageID()
        if let imageData = saveImageView.image?.pngData() {
            DataBaseHelper.shareInstance.saveImage(data: imageData, imageID: imageID)
        }
        navigationController?.popViewController(animated: true)
    }

    
    // Generate a unique image name using timestamp and random identifier
    func generateUniqueImageID() -> UUID {
        return UUID() // Generate a new UUID
    }

    
    
    @IBAction func cameraAction(_ sender: Any)
    {
        cameraButtonPressed()
    }
    
    
    @IBAction func imageAction(_ sender: Any)
    {
        galleryButtonPressed()
    }
    
    
}
