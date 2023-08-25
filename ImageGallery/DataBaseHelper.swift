//
//  DataBaseHelper.swift
//  ImageGallery
//
//  Created by iAsad on 25/08/2023.
//

import UIKit
import CoreData

class DataBaseHelper {
    
    static let shareInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    func saveImage(data: Data, imageName: String) {
//        let imageInstance = Image(context: context)
//        imageInstance.img = data
//        imageInstance.imageName = imageName // Set the imageName attribute
//
//        do {
//            try context.save()
//            print("Image is saved")
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    func saveImage(data: Data, imageID: UUID) {
        let imageInstance = Image(context: context)
        imageInstance.img = data
        imageInstance.imageID = imageID

        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImages() -> [(image: UIImage, imageID: UUID)] {
        var fetchedImages = [(image: UIImage, imageID: UUID)]()

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Image")

        do {
            if let fetchedObjects = try context.fetch(fetchRequest) as? [Image] {
                for imageObject in fetchedObjects {
                    if let imageData = imageObject.img,
                       let image = UIImage(data: imageData),
                       let imageID = imageObject.imageID {
                        fetchedImages.append((image, imageID))
                    }
                }
            }
        } catch {
            print("Error while fetching images: \(error.localizedDescription)")
        }

        return fetchedImages
    }
}

