//
//  FeedViewController.swift
//  Photog
//
//  Created by Dhiraj Laddha on 20/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController //, UITableViewDataSource
{
    
    var items = []
    
    @IBOutlet var tableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()

        var nib = UINib(nibName: "postCell1" , bundle: nil)
        tableView?.registerNib(nib, forCellReuseIdentifier: "postCell1")
        
        
        self.edgesForExtendedLayout = UIRectEdge.None;
        self.extendedLayoutIncludesOpaqueBars = false;
        self.automaticallyAdjustsScrollViewInsets = false;

    
           
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        NetworkManager.sharedInstance.fetchFeed{
        (objects, error) -> () in
            
            if let constObjects = objects
            {
     //           println("objects===\(objects)!")
                self.items = constObjects
                self.tableView?.reloadData()
                
            }
            else if let constError = error
            {
                //Alert the user
            }
            
 //           println(objects)
 //           println(error)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
  //      var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("pCell") as pCell
        
   //     cell.textLabel?.text = items[indexPath.row]
        
  
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell1") as postCell1
        
 //        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("postCell1") as postCell1
       
        var item = items[indexPath.row] as PFObject
       
        
        cell.post = item
        
        return cell
    }

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
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
