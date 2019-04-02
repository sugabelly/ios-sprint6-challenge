//
//  Slider.swift
//  Sprint 6 Challenge
//
//  Created by Lotanna Igwe-Odunze on 1/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class SpecialSlider: UIControl {
    
    //PROPERTIES
    static var unlocked: Bool = false
    
    var sliderBG: UIView! //Background part of the slider.
    var thumb: UIView! //Moving part of the slider.
    
    override var intrinsicContentSize: CGSize { return CGSize(width: 240.0, height: 240.0) }
    
    //INITIALISER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createSlider() //Call the function that creates the slider.
    }
    
    //Creates an instance of the slider with the following specifications
    private func createSlider() {
        // Set the background color and corner radius of control
        backgroundColor = Theme.plum
        layer.cornerRadius = 30
        
        // Set up the view for the slider bar
        sliderBG = UIView()
        sliderBG.frame = CGRect(x: 6, y: 0, width: 228, height: 50)
        sliderBG.backgroundColor = Theme.pompAndPowder
        sliderBG.layer.cornerRadius = sliderBG.bounds.height / 2 //Rounds corners
        sliderBG.isUserInteractionEnabled = false //Makes the background unclickable.
        self.addSubview(sliderBG)
        
        // Set up the view for the thumb
        thumb = UIView(frame: Calculations.thumbOffset(to: 6))
        sliderBG.addSubview(thumb) //Makes thumb show up on top of the slider BG.
        thumb.backgroundColor = Theme.mikadoYellow
        thumb.layer.cornerRadius = thumb.bounds.height/2
        thumb.layer.borderWidth = 2
        thumb.isUserInteractionEnabled = false
    }
    
  //  Functions from UIControl
    
    //Begin tracking touch drag on slider
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // Only begin tracking if the user touches down inside of the thumb
        let touchArea = touch.location(in: thumb) //Only track touch on the thumb.
        
        print(touchArea)
        
        if thumb.bounds.contains(touchArea) {
            sendActions(for: .touchDown)
            return true
        } else {
            return false
        }
    }
       
        //Continue tracking touch drag on slider
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        // Send the proper action if the user drags inside or outside of the slider bg
        let touchArea = touch.location(in: sliderBG)
        if sliderBG.bounds.contains(touchArea) {
            sendActions(for: .touchDragInside)
        } else  {
            sendActions(for: .touchDragOutside)
        }
        // But update the thumb's position no matter where they drag.
        let percentage = calculatePercentage(with: touchArea)
        let offset = (percentage * 178) + 6
        thumb.frame = Calculations.thumbOffset(to: offset)
    
        return true
    }
    
    //End tracking touch drag on slider
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event) } //Do this LAST
        
        // Make sure there is a touch and that the lock is not already unlocked
        guard let touch = touch, !SpecialSlider.unlocked else { return }
        
        // Calculate the percentage through the slider bar
        let touchArea = touch.location(in: sliderBG)
        
        print(touchArea)
        let percentage = calculatePercentage(with: touchArea)
        print(percentage)
        
        if percentage > 0.8 {
            // If it is more than 80 percent, unlock the control, update the image and send the action.
            SpecialSlider.unlocked = true
            sendActions(for: .valueChanged) //where does valuechanged go???
            if thumb.frame.origin.x != 184 { moveSlider(position: 184) }
        } else {
            // Otherwise, reset it.
            PadlockViewController().earlyReset()
        }
    }
    
    //Cancel tracking touch drag on slider
    override func cancelTracking(with event: UIEvent?) {
        // If tracking is cancelled, send that action and reset the control.
        sendActions(for: .touchCancel)
        PadlockViewController().earlyReset()
    }
    
    // Calculate the percentage moved by the thumb.
    func calculatePercentage(with point: CGPoint) -> CGFloat {
        var percentage = point.x / (sliderBG.bounds.width)
        if percentage > 1.0 { //Stops from dragging beyond the right limit.
            percentage = 1.0
        } else if percentage < 0.0 { //Stops from dragging beyond the left limit
            percentage = 0.0
        }
        return percentage
    }
    
    //Move the slider thumb via animation to a new position by offsetting it.
    func moveSlider(position: CGFloat) {
        
        UIView.animate(withDuration: 0.3) {
            self.thumb.frame = Calculations.thumbOffset(to: position)
        }
    }
}



