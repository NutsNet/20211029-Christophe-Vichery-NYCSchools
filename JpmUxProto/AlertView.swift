//
//  AlertView.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/31/21.
//

import UIKit

class AlertView: UIView {
    let alertBackVi = UIView()
    let alertTitleLb = UILabel()
    let alertTxtLb = UILabel()
    let alertBarVi = UIView()
    let alertStBt = UIButton()
    let alertNdBt = UIButton()
    
    var hrAlertStBtCst: NSLayoutConstraint!
    
    var alertNb: UInt = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Title
        alertTitleLb.text = "Oops!"
        alertTitleLb.textColor = .black
        alertTitleLb.font = UIFont(name: "Lato-Bold", size: 24)
        alertTitleLb.sizeToFit()
        alertTitleLb.translatesAutoresizingMaskIntoConstraints = false
        alertBackVi.addSubview(alertTitleLb)
        
        let hcAlertTitleCst = NSLayoutConstraint(item: alertTitleLb, attribute: .centerX, relatedBy: .equal, toItem: alertBackVi, attribute: .centerX, multiplier: 1, constant: 0)
        let vtAlertTitleCst = NSLayoutConstraint(item: alertTitleLb, attribute: .top, relatedBy: .equal, toItem: alertBackVi, attribute: .top, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([hcAlertTitleCst, vtAlertTitleCst])
        
        // Text
        alertTxtLb.numberOfLines = 0
        alertTxtLb.textColor = .black
        alertTxtLb.textAlignment = .center
        alertTxtLb.font = UIFont(name: "Lato-Regular", size: 16)
        alertTxtLb.sizeToFit()
        alertTxtLb.translatesAutoresizingMaskIntoConstraints = false
        alertBackVi.addSubview(alertTxtLb)
        
        let hlAlertCommentCst = NSLayoutConstraint(item: alertTxtLb, attribute: .left, relatedBy: .equal, toItem: alertBackVi, attribute: .left, multiplier: 1, constant: 16)
        let hrAlertCommentCst = NSLayoutConstraint(item: alertTxtLb, attribute: .right, relatedBy: .equal, toItem: alertBackVi, attribute: .right, multiplier: 1, constant: -16)
        let vtAlertCommentCst = NSLayoutConstraint(item: alertTxtLb, attribute: .top, relatedBy: .equal, toItem: alertTitleLb, attribute: .bottom, multiplier: 1, constant: 8)
        NSLayoutConstraint.activate([hlAlertCommentCst, hrAlertCommentCst, vtAlertCommentCst])
        
        // Separation
        alertBarVi.backgroundColor = .black
        alertBarVi.translatesAutoresizingMaskIntoConstraints = false
        alertBackVi.addSubview(alertBarVi)
        
        let htAlertBarViCst = NSLayoutConstraint(item: alertBarVi, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2)
        let hlAlertBarViCst = NSLayoutConstraint(item: alertBarVi, attribute: .left, relatedBy: .equal, toItem: alertBackVi, attribute: .left, multiplier: 1, constant: 64)
        let hrAlertBarViCst = NSLayoutConstraint(item: alertBarVi, attribute: .right, relatedBy: .equal, toItem: alertBackVi, attribute: .right, multiplier: 1, constant: -64)
        let vtAlertBarViCst = NSLayoutConstraint(item: alertBarVi, attribute: .top, relatedBy: .equal, toItem: alertTxtLb, attribute: .bottom, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([htAlertBarViCst, hlAlertBarViCst, hrAlertBarViCst, vtAlertBarViCst])
        
        // First button
        alertStBt.setTitle("No", for: .normal)
        alertStBt.setTitleColor(.black, for: .normal)
        alertStBt.titleLabel?.font = UIFont(name: "Lato-Regular", size: 24)
        alertStBt.addTarget(self, action: #selector(alertStBtTouch), for: .touchUpInside)
        alertStBt.translatesAutoresizingMaskIntoConstraints = false
        alertBackVi.addSubview(alertStBt)
        
        let htAlertStBtCst = NSLayoutConstraint(item: alertStBt, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 48)
        let hlAlertStBtCst = NSLayoutConstraint(item: alertStBt, attribute: .left, relatedBy: .equal, toItem: alertBackVi, attribute: .left, multiplier: 1, constant: 0)
        hrAlertStBtCst = NSLayoutConstraint(item: alertStBt, attribute: .right, relatedBy: .equal, toItem: alertBackVi, attribute: .centerX, multiplier: 1, constant: 0)
        let vtAlertStBtCst = NSLayoutConstraint(item: alertStBt, attribute: .top, relatedBy: .equal, toItem: alertBarVi, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([htAlertStBtCst, hlAlertStBtCst, hrAlertStBtCst, vtAlertStBtCst])
        
        // Second button
        alertNdBt.setTitle("Ok", for: .normal)
        alertNdBt.setTitleColor(.black, for: .normal)
        alertNdBt.titleLabel?.font = UIFont(name: "Lato-Bold", size: 24)
        alertNdBt.addTarget(self, action: #selector(alertNdBtTouch), for: .touchUpInside)
        alertNdBt.translatesAutoresizingMaskIntoConstraints = false
        alertBackVi.addSubview(alertNdBt)
        
        let htAlertNdBtCst = NSLayoutConstraint(item: alertNdBt, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 48)
        let hlAlertNdBtCst = NSLayoutConstraint(item: alertNdBt, attribute: .left, relatedBy: .equal, toItem: alertStBt, attribute: .right, multiplier: 1, constant: 0)
        let hrAlertNdBtCst = NSLayoutConstraint(item: alertNdBt, attribute: .right, relatedBy: .equal, toItem: alertBackVi, attribute: .right, multiplier: 1, constant: 0)
        let vtAlertNdBtCst = NSLayoutConstraint(item: alertNdBt, attribute: .top, relatedBy: .equal, toItem: alertBarVi, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([htAlertNdBtCst, hlAlertNdBtCst, hrAlertNdBtCst, vtAlertNdBtCst])
        
        // Back
        alertBackVi.clipsToBounds = true
        alertBackVi.backgroundColor = .lightGray
        alertBackVi.translatesAutoresizingMaskIntoConstraints = false
        alertBackVi.layer.cornerRadius = 8
        alertBackVi.layer.borderColor = UIColor.black.cgColor
        alertBackVi.layer.borderWidth = 2
        addSubview(alertBackVi)
        
        let wtAlertBackViCst = NSLayoutConstraint(item: alertBackVi, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 256)
        let hcAlertBackViCst = NSLayoutConstraint(item: alertBackVi, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let vcAlertBackViCst = NSLayoutConstraint(item: alertBackVi, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let vtAlertBackViCst = NSLayoutConstraint(item: alertBackVi, attribute: .bottom, relatedBy: .equal, toItem: alertNdBt, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([wtAlertBackViCst, hcAlertBackViCst, vcAlertBackViCst, vtAlertBackViCst])
        
        alertBackVi.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    func alertDisplay(nb: UInt, txt: String) {
        alertNb = nb
        
        switch nb {
        case 1:
            alertTxtLb.text = txt
            break
        default:
            break
        }
        
        NSLayoutConstraint.deactivate([hrAlertStBtCst])
        if [1].contains(nb) {
            hrAlertStBtCst = NSLayoutConstraint(item: alertStBt, attribute: .right, relatedBy: .equal, toItem: alertStBt, attribute: .left, multiplier: 1, constant: 0)
        } else {
            hrAlertStBtCst = NSLayoutConstraint(item: alertStBt, attribute: .right, relatedBy: .equal, toItem: alertBackVi, attribute: .centerX, multiplier: 1, constant: 0)
        }
        NSLayoutConstraint.activate([hrAlertStBtCst])
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
            self.backgroundColor = UIColor(rgb: 0x000000, a: 0.5)
        }) { (finished) -> Void in }
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.alertBackVi.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (finished) -> Void in
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: { () -> Void in
                self.alertBackVi.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { (finished) -> Void in
                UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: { () -> Void in
                    self.alertBackVi.transform = CGAffineTransform(scaleX: 1, y: 1)
                }) { (finished) -> Void in }
            }
        }
    }
    
    func alertDismiss(escap: @escaping () -> Void) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.backgroundColor = UIColor(rgb: 0x000000, a: 0)
        }) { (finished) -> Void in }
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: { () -> Void in
            self.alertBackVi.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (finished) -> Void in
            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveLinear, animations: { () -> Void in
                self.alertBackVi.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
            }) { (finished) -> Void in
                self.removeFromSuperview()
                escap()
            }
        }
    }
    
    @objc func alertStBtTouch(sender: UIButton!) {
        alertDismiss {
            switch self.alertNb {
            default:
                break
            }
        }
    }
    
    @objc func alertNdBtTouch(sender: UIButton!) {
        alertDismiss {
            switch self.alertNb {
            case 2:
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                break
            default:
                break
            }
        }
    }
}
