//
//  ViewController.swift
//  DynamicGravity
//
//  Created by Wojciech Ogrodowczyk on 15/04/15.
//  Copyright (c) 2015 Wojciech Ogrodowczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var dynamicAnimator = UIDynamicAnimator()

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        dynamicAnimator =
            UIDynamicAnimator(referenceView: self.view)
        // creating and adding a gravity behavior
        let gravityBehavior = UIGravityBehavior(items: [self.imageView])
        dynamicAnimator.addBehavior(gravityBehavior)
        
        
        // creating and adding a collision behavior
        let collisionBehavior =
            UICollisionBehavior(items: [self.imageView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
    }

}

