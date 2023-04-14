//
//  FeedVc.swift
//  InstagramClone
//
//  Created by Osmancan Akagündüz on 10.04.2023.
//

import UIKit
import Firebase
import SDWebImage
class FeedVc: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
        var userEmailArray = [String]()
       var userCommentArray = [String]()
       var likeArray = [Int]()
       var userImageArray = [String]()
       var documentIdArray = [String]()

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell",for: indexPath) as! FeedCell
        
        cell.contentLabel.text = self.userCommentArray[indexPath.row]
        cell.likeCountLabel.text = String(self.likeArray[indexPath.row])
        cell.usernameLabel.text = self.userEmailArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text = self.documentIdArray[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource=self
        
        fetchPosts()
    }
    
    
    
    func fetchPosts()   {
        let fireStore = Firestore.firestore()
        fireStore.collection("posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print("error")
            }else {
                self.userEmailArray.removeAll(keepingCapacity: false)
                self.userImageArray.removeAll(keepingCapacity: false)
                self.userCommentArray.removeAll(keepingCapacity: false)
                self.documentIdArray.removeAll(keepingCapacity: false)
                self.likeArray.removeAll(keepingCapacity: false)

                
                for document in snapshot!.documents {
                    
                    self.documentIdArray.append(document.documentID)
                    
                    if let postedBy = document.get("postedBy") as? String {
                                               self.userEmailArray.append(postedBy)
                                           }
                                           
                                           if let postComment = document.get("postComment") as? String {
                                               self.userCommentArray.append(postComment)
                                           }
                                           
                                           if let likes = document.get("likes") as? Int {
                                               self.likeArray.append(likes)
                                           }
                                           
                                           if let imageUrl = document.get("imageUrl") as? String {
                                               self.userImageArray.append(imageUrl)
                                           }
                }
                
                self.tableView.reloadData()
            }
        }
    }
}
