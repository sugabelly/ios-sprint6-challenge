//
//  ViewController.swift
//  Sprint 6 Challenge
//
//  Created by Spencer Curtis on 8/29/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PadlockViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SpecialSlider.unlocked == true { animateUnlock(imageView: padlockView, images: animationArray) }
        } //End of View Did Load

    
    //Outlets
    // The only way I could figure out to animate the bar button item was to create a custom view for it. So that's what I did.
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var padlockView: UIImageView!
    @IBOutlet weak var resetButton: UIBarButtonItem!
    
    @IBOutlet weak var ssView: SpecialSlider!
    
    //
    func specificAppearance() {
        
        //Invisible Reset Button
        resetButton.tintColor = Theme.pompAndPowder
        resetButton.tintColor?.withAlphaComponent(0.0)
        //resetButton.isEnabled = false
        
        //View Appearance
        bgView.layer.cornerRadius = 20
        bgView.clipsToBounds = true
        bgView.backgroundColor = Theme.mikadoYellow
        self.view.backgroundColor = Theme.pompAndPowder
    }
    
    //
    
    let unlockedImage = UIImage(named: "Unlocked")!
    var animationArray: [UIImage] = []
    
    
    func createArray() {
        animationArray.append(unlockedImage)
    }
    
    func animateUnlock(imageView: UIImageView, images: [UIImage]) {
        createArray()
        imageView.animationImages = images
        imageView.animationDuration = 1.0
        imageView.startAnimating()
    }
    

    
    //Reset from Abandoning Touch below 80
     func earlyReset() {
        ssView.moveSlider(position: 6)
        SpecialSlider.unlocked = false
        resetButton.isEnabled = false
        resetButton.tintColor = Theme.mikadoYellow //Disappear

    }
    
    @IBAction func pressToReset(_ sender: UIBarButtonItem) {
        ssView.moveSlider(position: 6)
        ssView.thumb.isUserInteractionEnabled = true
        padlockView.stopAnimating()
        resetButton.isEnabled = false
        resetButton.tintColor = Theme.pompAndPowder
        resetButton.tintColor?.withAlphaComponent(0.0)
    }
    
    
    
}

