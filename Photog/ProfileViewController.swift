//
//  ProfileViewController.swift
//  Photog
//
//  Created by Dhiraj Laddha on 24/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableview: UITableView?
    
    var user: PFUser?
    var items = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var nib = UINib(nibName: "postCell1" , bundle: nil)
        tableview?.registerNib(nib, forCellReuseIdentifier: "postCell1")
        
        self.edgesForExtendedLayout = UIRectEdge.None;
        self.extendedLayoutIncludesOpaqueBars = false;
        self.automaticallyAdjustsScrollViewInsets = false;


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        NetworkManager.sharedInstance.fetchPost(user, completionHandler: {
        (objects, error) ->() in
            if let constError = error
            {
                println("error in fetching Post")
            }
            else
            {
                self.items = objects!
                self.tableview?.reloadData()
            }
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell1") as postCell1
        
        
        var item = items[indexPath.row] as PFObject
        
        
        cell.post = item
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
