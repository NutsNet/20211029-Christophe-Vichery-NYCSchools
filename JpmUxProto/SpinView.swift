//
//  SpinView.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/28/21.
//

import UIKit

class SpinView: UIView {
    
    let tool = Tool.share
    
    let spinFx = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    let spinIv = UIImageView()
    
    var isSpining = false
    
    static let share = SpinView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Self
        translatesAutoresizingMaskIntoConstraints = false
        
        // Fx
        spinFx.alpha = 0
        spinFx.translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinFx)
        
        let hlSpinFxCst = NSLayoutConstraint(item: spinFx, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)
        let hrSpinFxCst = NSLayoutConstraint(item: spinFx, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)
        let vtSpinFxCst = NSLayoutConstraint(item: spinFx, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let vbSpinFxCst = NSLayoutConstraint(item: spinFx, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([hlSpinFxCst, hrSpinFxCst, vtSpinFxCst, vbSpinFxCst])
        
        // Picture
        spinIv.alpha = 0
        spinIv.image = UIImage(named: "spin")
        spinIv.translatesAutoresizingMaskIntoConstraints = false
        spinIv.layer.shadowOffset = CGSize.zero
        spinIv.layer.shadowOpacity = 0.25
        spinIv.layer.shadowRadius = 4
        addSubview(spinIv)
        
        let wtSpinIvCst = NSLayoutConstraint(item: spinIv, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let htSpinIvCst = NSLayoutConstraint(item: spinIv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let hcSpinIvCst = NSLayoutConstraint(item: spinIv, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let vcSpinIvCst = NSLayoutConstraint(item: spinIv, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([wtSpinIvCst, htSpinIvCst, hcSpinIvCst, vcSpinIvCst])
        
        spinStop() { }
    }
    
    // Stop spinning
    func spinStop(escap:@escaping () -> Void) {
        isSpining = false
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: { () -> Void in
            self.spinFx.alpha = 0
            self.spinIv.alpha = 0
            self.spinIv.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi)
            self.spinIv.transform = CGAffineTransform.init(scaleX: 0.0001, y: 0.0001)
        }) { (finished) -> Void in
            self.isHidden = true
            escap()
        }
    }
    
    // Start spinning
    func spinStart() {
        isHidden = false
        isSpining = true
        spinLoop()
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: { () -> Void in
            self.spinFx.alpha = 1
        }) { (finished) -> Void in }
    }
    
    // This will loop until we stop spinning
    func spinLoop() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: { () -> Void in
            self.spinIv.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
            self.spinIv.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            self.spinIv.alpha = 0.5
            
        }) { (finished) -> Void in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut, animations: { () -> Void in
                self.spinIv.transform = CGAffineTransform.init(rotationAngle: -CGFloat.pi)
                self.spinIv.transform = CGAffineTransform.init(scaleX: 0.25, y: 0.25)
                self.spinIv.alpha = 0.25
                
            }) { (finished) -> Void in
                if self.isSpining { self.spinLoop() }
            }
        }
    }
}
