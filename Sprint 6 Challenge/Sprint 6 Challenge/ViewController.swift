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
    @IBOutlet weak var slider: SpecialSlider!
    
 //
    func specificAppearance() {
        
        //View Appearance
        bgView.layer.cornerRadius = 20
        bgView.clipsToBounds = true
        bgView.backgroundColor = UIColor(red: 249/255, green: 188/255, blue: 19/255, alpha: 1.0) // Mikado Yellow #F9BC13
        
        //Slider Appearance
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.minimumTrackTintColor = UIColor.gray
        slider.maximumTrackTintColor = UIColor.gray
        slider.thumbTintColor = UIColor.black
        slider.isContinuous = true //Value changes instantly as thumb is moved
    }
    
    
    
    //slider.addTarget(self, action: #selector(sliderMoved(sender:)), for: UIControlEvents.valueChanged) //Makes slider target function below.
    
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
    
    @IBAction func slideToUnlock(_ sender: SpecialSlider) {
        
        if slider.value > 80.0 {
           animateUnlock(imageView: padlockView, images: animationArray)
        }
    }
    
    
    
    
}

