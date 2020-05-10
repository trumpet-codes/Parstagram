//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Jianling Su on 5/6/20.
//  Copyright © 2020 magicTech. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage


class FeedViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    //MARK: posts array
    var posts = [PFObject]()
 
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: POST the table you just created and refresh it
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "Posts")
        
        //MARK:fetch the author data from Parse server
        query.includeKey("author")
        query.limit = 20
        
        //MARK: store the data and reload data
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        
        let user = post["author"] as! PFUser
        cell.usernameLabel.text = user.username
        cell.captionLabel.text = post["caption"] as! String
        
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        
        cell.photoView.af_setImage(withURL: url)
        return cell
        
        
    }
      
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }
    
*/
}
