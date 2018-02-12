//
//  Common
//  DornaTest
//
// Created by Javier Garcia Castro on 12/2/18. 
// Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class JGCLoadingView: UIView {

   var working: Bool = false
    
    let loadingViewMainColor = UIColor.init(hex: kRedColor, alpha: 1.0)
    let loadingViewBackgroundColor = UIColor.init(hex: 0xD5D5D5, alpha: 1.0)
    
    let defaultLineWidth: CGFloat = 10.0
    let defaultSize: CGFloat = 90.0
    let defaultSpeed: CGFloat = 3.0
    
    var mainColor: UIColor?
    var secondaryColor: UIColor?
    var aSize: CGFloat?
    var lineWidth: CGFloat?
    var speed: CGFloat?
    
    // MARK: - Init
    
    convenience init() {
        self.init(frame: .zero)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initialize()
    }
    
    deinit {
        self.layer.removeAllAnimations()
    }

    
    // MARK: - Private Methods
    
    func initialize() {
        initializeWithMainColor(mainColor: loadingViewMainColor!, secondaryColor: loadingViewBackgroundColor!, secondaryColorSize: defaultSize, lineWidth: defaultLineWidth, speed: defaultSpeed)
    }
    
    func initializeWithMainColor(mainColor: UIColor, secondaryColor: UIColor, secondaryColorSize: CGFloat, lineWidth: CGFloat, speed: CGFloat) {
        
        self.mainColor = mainColor
        self.secondaryColor = secondaryColor
        self.aSize = secondaryColorSize
        self.lineWidth = lineWidth
        self.speed = CGFloat(speed)
        
        self.working = true

        addCircle()
    }
    
    func addCircle() {
        
        // Set up the shape of the circle
        let radius = self.aSize
    
        let circle: CAShapeLayer = CAShapeLayer.init()
        
        // Make a circular shape
        circle.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: radius!*1.0, height: radius!*1.0), cornerRadius: radius!).cgPath
        
        circle.lineCap = "round"
    
        // Configure the apperence of the circle
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = self.mainColor?.cgColor
        circle.lineWidth = self.lineWidth!
        
        let backCircle: CAShapeLayer = CAShapeLayer.init()
    
        // Make a circular shape
        backCircle.path = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: radius!*1.0, height: radius!*1.0), cornerRadius: radius!).cgPath
    
        // Center the shape in self.view
    
        backCircle.lineCap = "round"
    
        // Configure the apperence of the circle
        
        backCircle.fillColor = UIColor.clear.cgColor
        backCircle.strokeColor = self.secondaryColor?.cgColor
        backCircle.lineWidth = self.lineWidth! - 0.3
        
        
        // Add to parent layer
        self.layer.addSublayer(backCircle)
        self.layer.addSublayer(circle)
        
        self.startAnimation(number: 1, circle: circle, backgroundCircle: backCircle)
    }
    
    func startAnimation(number: NSInteger, circle: CAShapeLayer, backgroundCircle: CAShapeLayer) {

        //to calm warning
        let _ = CATransaction.init()
        
        circle.lineWidth = self.lineWidth!
        backgroundCircle.lineWidth = self.lineWidth! - 0.3
    
        // Configure animation
        let drawAnimation: CABasicAnimation = CABasicAnimation.init(keyPath: "strokeEnd")
        drawAnimation.duration = CFTimeInterval(self.speed!)
        
        circle.strokeColor = (number % 2 == 0) ? self.mainColor?.cgColor : self.secondaryColor?.cgColor
    
        drawAnimation.fromValue = NSNumber.init(value: 0.0)
        drawAnimation.toValue = NSNumber.init(value: 1.0)
        
        
        // Experiment with timing to get the appearence to look the way you want
        drawAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        
        CATransaction.setCompletionBlock{ () -> Void in
        
            self.bringSublayerToFront(layer: backgroundCircle)
            
            if self.working && number < 70 {
                self.startAnimation(number: number+1, circle: backgroundCircle, backgroundCircle: circle)
            }
        }
        
        circle.removeAllAnimations()
        
        // Add the animation to the circle
        circle.add(drawAnimation, forKey: "drawCircleAnimation")
        
        CATransaction.commit()
    }
    
    func bringSublayerToFront(layer: CALayer) {
        let superLayer: CALayer = layer.superlayer!
        layer.removeFromSuperlayer()
        superLayer.addSublayer(layer)
    }
    
    func sendSublayerToBack(layer: CALayer) {
        let superLayer: CALayer = layer.superlayer!
        layer.removeFromSuperlayer()
        superLayer.addSublayer(layer)
    }
}
