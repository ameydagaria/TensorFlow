//
//  imageCaptureController.swift
//  visBrain
//
//  Created by Apple on 29/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import CoreML
import Vision

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
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.data?.imageData = imageData
        vc.data?.screentype = screenType.Detail
        vc.data?.msg = "Success"
      navigationController?.pushViewController(vc, animated: true)
        
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
        setNavigation(title: "VizBrain", viewControlla: self)
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
        guard let ciimage = CIImage(image: image) else {
            print("Image not found")
            return
        }
        detectScene(image: ciimage)
        imageData = info
        imgView.image = image
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        defer {
            picker.dismiss(animated: true)
        }
        print("Did cancel")
    }
    func detectScene (image: CIImage) {
        liveLbl.numberOfLines = 4
        liveLbl.text = "Brain Is Working Wait for Output"
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for:Inceptionv3().model) else {
            fatalError("Can't load Inception ML model")
        }
        // Create a Vision request with completion handler
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("Unexpected result type from VNCoreMLRequest")
            }
            
            // Update UI on main queue
            DispatchQueue.main.async { [weak self] in
                self?.liveLbl.text = "\(Int(topResult.confidence * 100))% it's \(topResult.identifier)"
            }
        }
        
        // Run the Core ML model classifier on global dispatch queue
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}
