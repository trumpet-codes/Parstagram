//
//  CameraViewController.swift
//  Parstagram
//
//  Created by Jianling Su on 5/7/20.
//  Copyright © 2020 magicTech. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        //MARK: import Parse at the top of the class, and Parse will create a table on the fly
        
        let post = PFObject(className: "Posts")
        
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()
        
        //MARK:submitted the image save to pngData
        let imageData = ImageView.image!.pngData()
        //MARK: save the image to a seperate table >> Parse will handle it
        let file = PFFileObject(name: "image.png", data: imageData!)
        post["image"] = file
        
        post.saveInBackground{ (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved!")
            }else {
                print("error!")
            }
        }
    }
    
    @IBAction func onCarmeraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }else {
            picker.sourceType = .photoLibrary
        }
    //MARK: present the image when clicking on the camera
        present(picker, animated: true, completion: nil)
    }
    
    //MARK: choose an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        
        //MARK:resize the image
        let size = CGSize(width: 300, height: 300)
        let scaledImage =  image.af_imageScaled(to: size)
        
      //  let scaledImage = image.af.imageScaled(to: size)
        ImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
