//
//  Tool.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/28/21.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int, a: CGFloat = 1) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, a: a)
    }
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: a)
    }
}

enum Orientation { case none, portrait, landscape }
enum Device { case iPhone, xPhone, iPad, xPad, iMac, iSim }

class Tool: NSObject {
    var device = Device.xPhone
    var orientation = Orientation.none
    
    var currentDeviceWt: CGFloat = 0
    var currentDeviceHt: CGFloat = 0
    
    static let share = Tool()
    
    override init() {
        super.init()
        
        // Notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.checkDeviceOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        // Get device type
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let deviceType = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            switch deviceType {
            case "iPad1,1", "iPad1,2", "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4", "iPad2,5", "iPad2,6", "iPad2,7", "iPad3,1", "iPad3,2", "iPad3,3", "iPad3,4", "iPad3,5", "iPad3,6", "iPad4,1", "iPad4,2", "iPad4,3", "iPad4,4", "iPad4,5", "iPad4,6", "iPad4,7", "iPad4,8", "iPad4,9", "iPad5,1", "iPad5,2", "iPad5,3", "iPad5,4", "iPad6,1", "iPad6,2", "iPad6,3", "iPad6,4", "iPad6,5", "iPad6,6", "iPad6,7", "iPad6,8", "iPad6,9", "iPad6,10", "iPad6,11", "iPad6,12", "iPad7,1", "iPad7,2", "iPad7,3", "iPad7,4", "iPad7,5", "iPad7,6", "iPad7,7", "iPad7,8", "iPad7,9", "iPad7,10", "iPad7,11", "iPad7,12":
                device = .iPad
            default:
                device = .xPad
                break
            }
        } else {
            switch deviceType {
            case "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2", "iPhone7,1", "iPhone7,2", "iPhone8,1", "iPhone8,2", "iPhone8,3", "iPhone8,4", "iPhone9,1", "iPhone9,2", "iPhone9,3", "iPhone9,4", "iPhone10,1", "iPhone10,2", "iPhone10,3", "iPhone10,4", "iPhone10,5":
                device = .iPhone
            default:
                device = .xPhone
                break
            }
        }
        
        // Set the device type when using simulateur
        // iPad  : old iPad   with bottom home button
        // iPhone: old iPhone with bottom home button
        // xPad  : new iPad   with bottom home bar
        // xPhone: new iPhone with bottom home bar and top notch
        
        // device = .xPhone
        
        // Get device size
        if UIScreen.main.bounds.width < UIScreen.main.bounds.height {
            currentDeviceWt = UIScreen.main.bounds.width
            currentDeviceHt = UIScreen.main.bounds.height
        } else {
            currentDeviceWt = UIScreen.main.bounds.height
            currentDeviceHt = UIScreen.main.bounds.width
        }
    }
    
    @objc private func checkDeviceOrientation() {
        if (UIDevice.current.orientation == .portrait || UIDevice.current.orientation == .portraitUpsideDown) && orientation != .portrait {
            orientation = .portrait
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateOrientation"), object: nil)
        } else if (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight) && orientation != .landscape {
            orientation = .landscape
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateOrientation"), object: nil)
        }
    }
}
