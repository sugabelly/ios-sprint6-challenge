//
//  ViewController.swift
//  Sprint 6 Challenge
//
//  Created by Spencer Curtis on 8/29/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        specificAppearance()
    }

//Outlets
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var padlockView: UIImageView!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    
 //
    func specificAppearance() {
        
        bgView.layer.cornerRadius = 20
        bgView.clipsToBounds = true
        bgView.backgroundColor = UIColor(red: 249/255, green: 188/255, blue: 19/255, alpha: 1.0) // Mikado Yellow #F9BC13
    }
    
//
    
    let lockedImage = UIImage(named: "Locked")!
    let unlockedImage = UIImage(named: "Unlocked")!
    var animationArray: [UIImage] = []

    
    func createArray() {
        animationArray.append(lockedImage)
        animationArray.append(unlockedImage)
    }
    
    func animateUnlock(imageView: UIImageView, images: [UIImage]) {
        createArray()
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        //imageView.animationRepeatCount = 1
        imageView.startAnimating()
    }
    
    
    
    
    
}

