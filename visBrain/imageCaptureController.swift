//
//  imageCaptureController.swift
//  visBrain
//
//  Created by Apple on 29/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class imageCaptureController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var liveLbl: UILabel!
    @IBOutlet weak var liveVisionBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var detailViewPushBtn: UIButton!
    @IBOutlet weak var galleryBtn: UIButton!
    //Global Variable Declaration
    let imagepicker = UIImagePickerController()
    var imageData : Any?
    @IBAction func liveVisionAction(_ sender: Any) {
    
    }
    @IBAction func cameraAction(_ sender: Any) {
      openAndSetCamera()
    }
    @IBAction func galleryAction(_ sender: Any) {
     openGallery()
    }
    @IBAction func DetailViewPushBtnAction(_ sender: Any) {
        
        
    }
    private func openGallery() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("No Photo Gallery Available")
            return
        }
        imagepicker.sourceType = .photoLibrary
        imagepicker.delegate = self
        present(imagepicker, animated: true)
    }
   private func openAndSetCamera () {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
        return
    }
    imagepicker.sourceType = .camera
    imagepicker.cameraDevice = .rear
    imagepicker.cameraCaptureMode = .photo
    imagepicker.cameraFlashMode = .auto
    imagepicker.delegate = self
    imagepicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
    present(imagepicker,animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  
}
//Image Picker From Photo Library Delegates
extension imageCaptureController :UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        defer {
            picker.dismiss(animated: true) {
                print("Image selected")
            }
        }
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("Cant Find Image")
            return
        }
        imageData = info
        imgView.image = image
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        defer {
            picker.dismiss(animated: true)
        }
        print("Did cancel")
    }
}
