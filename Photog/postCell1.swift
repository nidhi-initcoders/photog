//
//  postCell1.swift
//  Photog
//
//  Created by Dhiraj Laddha on 21/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import UIKit

class postCell1: UITableViewCell {

      
    @IBOutlet var postImageView: UIImageView?
    @IBOutlet var usernameLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    
    
    var post: PFObject?
    {
        didSet
        {
            self.configure()
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.usernameLabel?.text = nil
        
        self.dateLabel?.text = nil
        // Initialization code
    }

    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.postImageView?.image = UIImage(named: "PostPlaceholderImage")
        
        self.usernameLabel?.text = nil
        
        self.dateLabel?.text = nil
        
        self.post = nil
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure()
    {
        
        self.postImageView?.clipsToBounds = true
        if let constPost = self.post
        {
            
            // Set the username label
            
            var user = constPost["User"] as PFUser
            user.fetchIfNeededInBackgroundWithBlock({
                (object, error) -> Void in
                
                if let constObject = object
                {
                    self.usernameLabel?.text = user.username
                }
                else if let constError = error
                {
                    //Alert the user.
                }
            })
            
             // Set the date label
            
            var date = constPost.createdAt
            self.dateLabel?.text = date.fuzzyTime()  
      //      println(date)
            
             // Download the image and display it
            
            
            NetworkManager.sharedInstance.fetchImage(constPost, completionHandler: {
            (image, error) -> () in
                
            if image != nil
            {
                self.postImageView!.image = image
            }
            else
            {
                    // Alert the user?
            }
         
            })
         
        }
    
    }
    
    
    
}
