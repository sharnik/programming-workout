//
//  ViewController.swift
//  OperationQueues
//
//  Created by Wojciech Ogrodowczyk on 19/04/15.
//  Copyright (c) 2015 Wojciech Ogrodowczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let hosts = ["google.com", "apple.com", "secretlab.com.au", "oreilly.com", "yahoo.com", "twitter.com"]
    let queue = NSOperationQueue()
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hosts.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("FaviconCell") as! FaviconTableViewCell
        var host = hosts[indexPath.row]
        var url = NSURL(string: "http://\(host)/favicon.ico")
        
        cell.operationQueue = queue
        cell.url = url
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

