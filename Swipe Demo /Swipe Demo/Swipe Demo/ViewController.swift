//
//  ViewController.swift
//  Swipe Demo
//
//  Created by Nick Natali on 1/5/17.
//  Copyright © 2017 Make It Appen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let label = UILabel(frame: CGRect(x: self.view.bounds.width / 2 - 100, y: self.view.bounds.height / 2 - 50, width: 200, height: 100))
        
         label.text = "Drag me!"
        
        label.textAlignment = NSTextAlignment.center
        
        view.addSubview(label)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged(gestureRecognizer: )))
        
        label.isUserInteractionEnabled = true
        
        label.addGestureRecognizer(gesture)
        
    }
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: view)
        
        let label = gestureRecognizer.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        //The labels coordinates minus the center of the screen
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        
        //Rotation Angle is measured in Radians
        var rotation = CGAffineTransform(rotationAngle: xFromCenter / 200)
        
        //Further from the center, the smaller we want the scale to be
        var scale = min(abs(100 / xFromCenter), 1)
        
        var stretchAndRotation = rotation.scaledBy(x: scale, y: scale)
        
        label.transform = stretchAndRotation
        
        //Check new coordinates of the label, when the drag is finished
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            
            //100 Pixels from the left of the screen
            if label.center.x < 100 {
                
                print("Not chosen")
                
                //On the right of the screen
            } else if label.center.x > self.view.bounds.width - 100{
                
                print("Chosen")
                
            }
            //Give label its original state 
            rotation = CGAffineTransform(rotationAngle: 0)
            
            stretchAndRotation = rotation.scaledBy(x: 1, y: 1)
            
            label.transform = stretchAndRotation
            
            //Move Label back to starting point
            label.center = CGPoint(x: self.view.bounds.width, y: self.view.bounds.height)
            
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

