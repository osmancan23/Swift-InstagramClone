//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Osmancan Akagündüz on 11.04.2023.
//

import UIKit
import FirebaseFirestore
class FeedCell: UITableViewCell {

    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var documentIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func like(_ sender: Any) {
        let firestore = Firestore.firestore()
        
        if let likeCount = Int(self.likeCountLabel.text!) {
            let data = ["likes" : likeCount+1 ] as Dictionary<String,Int>
            
            firestore.collection("posts").document(documentIdLabel.text!).setData(data, merge: true)
        }
            
            
        
        
    }
}
