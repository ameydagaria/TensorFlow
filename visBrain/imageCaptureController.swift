//
//  imageCaptureController.swift
//  visBrain
//
//  Created by Apple on 29/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class imageCaptureController: UIViewController {
    let imagepicker = UIImagePickerController()
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var liveVisionBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
       @IBOutlet weak var galleryBtn: UIButton!
    @IBAction func liveVisionAction(_ sender: Any) {
    
    }
    @IBAction func cameraAction(_ sender: Any) {
    }
    @IBAction func galleryAction(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("No Photo Gallery Available")
            return
        }
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        
        present(imagepicker, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
}
extension imageCaptureController :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        defer {
            picker.dismiss(animated: true) {
                print("Image selected")
            }
        }
        
        print(info)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Cant Find Image")
            return
        }
        imgView.image = image
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        defer {
            picker.dismiss(animated: true)
        }
        print("Did cancel")
    }
}
