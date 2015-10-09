//
//  SmileView.swift
//  TopProto
//
//  Created by Don Wilson on 7/23/15.
//  Copyright (c) 2015 Don Wilson. All rights reserved.
//

import UIKit

class SmileView: UIView {

    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    override func awakeFromNib() {
        
    }
    
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let shapeLayer = self.layer as? CAShapeLayer //else { return }
        
        let path: UIBezierPath = UIBezierPath.init()
        path.moveToPoint(CGPointMake(8, 12))
        path.addCurveToPoint(CGPointMake(42, 12), controlPoint1: CGPointMake(8, 12), controlPoint2: CGPointMake(25, 17))
            
        shapeLayer?.fillColor = nil
        shapeLayer?.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer?.lineWidth = 4
        shapeLayer?.lineCap = kCALineCapRound
        
        shapeLayer!.path = path.CGPath
    }

    func updateSmile (serviceQuality: Int) {
        
        let shapeLayer = self.layer as? CAShapeLayer //else { return }
        //UIView.animateWithDuration(2.2, animations: {shapeLayer!.lineWidth = 5}, completion: nil)
        //UIView.animateWithDuration(2.2, animations: {self.drawSmile(serviceQuality)}, completion: nil)
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = 0.7
        
        // Your new shape here
        animation.toValue = self.smile(serviceQuality).CGPath
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        // The next two line preserves the final shape of animation,
        // if you remove it the shape will return to the original shape after the animation finished
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        
        shapeLayer!.addAnimation(animation, forKey: nil)
        
    }
    
    func smile (serviceQuality: Int) -> UIBezierPath {
        
        let path: UIBezierPath = UIBezierPath.init()
        switch serviceQuality {
        case 0:
            path.moveToPoint(CGPointMake(8, 14))
            path.addCurveToPoint(CGPointMake(42, 14), controlPoint1: CGPointMake(10, 14), controlPoint2: CGPointMake(25, 0))
            
            
        case 1:
            path.moveToPoint(CGPointMake(8, 12))
            path.addCurveToPoint(CGPointMake(42, 12), controlPoint1: CGPointMake(8, 12), controlPoint2: CGPointMake(25, 17))
            
        case 2:
            path.moveToPoint(CGPointMake(8, 4))
            path.addCurveToPoint(CGPointMake(42, 4), controlPoint1: CGPointMake(8, 4), controlPoint2: CGPointMake(25, 30))
            
        default:
            break
        }
        return path
    }

}
