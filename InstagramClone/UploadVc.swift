//
//  UploadVc.swift
//  InstagramClone
//
//  Created by Osmancan Akagündüz on 10.04.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase

class UploadVc: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var descriptionField: UITextField!
    
   
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func selectImage() {
        let imagePicker =   UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func makeAlert(title: String? , description:String?)  {
        let alert = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }

    @IBAction func sharePost(_ sender: Any) {
        let uuid = UUID().uuidString
        let storageRef =    Storage.storage().reference().child("images")
        let imageRef = storageRef.child("\(uuid).jpg")
        if let image = imageView.image?.jpegData(compressionQuality: 0.5) {
            imageRef.putData(image) { result, error in
                if error != nil {
                    self.makeAlert(title: "Failed", description: error?.localizedDescription)
                }else{
                    imageRef.downloadURL { url, error in
                        if error != nil {
                            self.makeAlert(title: "Failed", description: error?.localizedDescription)
                        }else {
                            let imageUrl = url?.absoluteString

                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.descriptionField.text!,"date" : FieldValue.serverTimestamp(), "likes" : 0 ] as [String : Any]
                            let db = Firestore.firestore()
                            db.collection("posts").addDocument(data: firestorePost) { error in
                                if error != nil {
                                    self.makeAlert(title: "Failed", description: error?.localizedDescription)
                                }else{
                                    self.imageView.image = UIImage(named: "select.png")
                                    self.descriptionField.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            }
                        }
                    }
                }
            }

        }
    }
}
