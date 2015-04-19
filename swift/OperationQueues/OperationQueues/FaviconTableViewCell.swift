//
//  FaviconTableViewCell.swift
//  OperationQueues
//
//  Created by Wojciech Ogrodowczyk on 19/04/15.
//  Copyright (c) 2015 Wojciech Ogrodowczyk. All rights reserved.
//

import UIKit

class FaviconTableViewCell: UITableViewCell {

    var operationQueue : NSOperationQueue?
    var url : NSURL? {
        didSet {
            var request = NSURLRequest(URL: self.url!)
            self.textLabel!.text = self.url?.host
            
            NSURLConnection.sendAsynchronousRequest(request, queue: self.operationQueue!, completionHandler: {
                (response: NSURLResponse!, data: NSData!, error: NSError!) in
                var image = UIImage(data: data)
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.imageView?.image = image;
                    self.setNeedsLayout();
                }
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
