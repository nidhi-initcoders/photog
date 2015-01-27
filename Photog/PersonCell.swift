//
//  PersonCell.swift
//  Photog
//
//  Created by Dhiraj Laddha on 22/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    var isFollowing: Bool?
    var user: PFUser?
    {
        didSet
        {
            self.configure()
            
        }

        
    }
    @IBOutlet var usernamelbl: UILabel?
    @IBOutlet var followButton: UIButton?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.followButton?.hidden = true
        self.textLabel?.hidden = true
        self.user = nil
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.followButton?.hidden = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure()
    {
        if let constUser = self.user
        {
            
            // Set the username label
            self.usernamelbl?.text = constUser.username
            
            NetworkManager.sharedInstance.isFollowing(constUser, completionHandler: {(isFollowing, error) ->() in
            
            if let constError = error
            {
                
            }
            
            else
            {
                self.followButton?.hidden = false
                self.isFollowing = isFollowing
                if isFollowing == true
                {
                  
                 
                    var image = UIImage(named: "UnFollowButton")
                    self.followButton?.setImage(image, forState: .Normal)
                    
                }
                else
                {
                    
                    var image = UIImage(named: "FollowButton")
                    self.followButton?.setImage(image, forState: .Normal)
                }
            }
                
                
            })
            
        }
        else
        {
        
        }
            
           
    }
   
    @IBAction func didTapFollow(sender : UIButton)
    {
        
        self.followButton?.enabled = false
        
        var newValue = !(self.isFollowing == true)
     
        NetworkManager.sharedInstance.UpdateFollowValue(newValue, user: self.user, completionHandler:{
            (error) -> () in
            println("error")
            
            self.followButton?.enabled = true
            var image = (newValue == true) ? UIImage(named: "UnFollowButton") : UIImage(named: "FollowButton")
            self.followButton?.setImage(image, forState: .Normal)
     

            self.isFollowing = newValue
            
            })
        
        
       
        
        
    }
    
    
    
}
