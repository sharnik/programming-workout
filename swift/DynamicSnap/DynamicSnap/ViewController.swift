//
//  ViewController.swift
//  DynamicSnap
//
//  Created by Wojciech Ogrodowczyk on 18/04/15.
//  Copyright (c) 2015 Wojciech Ogrodowczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var imageView2: UIImageView!
    var dynamicAnimator:UIDynamicAnimator?
    var snap:UISnapBehavior?
    
    @IBAction func tapped(sender: AnyObject) {
        // getting the tap location
        let tap = sender as! UITapGestureRecognizer
        let point = tap.locationInView(self.view)
        
        // removing the previous snapping and adding the new one
        self.dynamicAnimator?.removeBehavior(self.snap)
        self.snap = UISnapBehavior(item: self.imageView2, snapToPoint: point)
        self.dynamicAnimator?.addBehavior(self.snap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

