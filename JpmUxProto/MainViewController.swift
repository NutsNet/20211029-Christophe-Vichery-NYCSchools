//
//  MainViewController.swift.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/28/21.
//

import UIKit

class MainViewController: UIViewController, SchoolTableViewDelegate {
    let api = Api.share
    let tool = Tool.share
    let spin = SpinView.share
    
    let mainFx = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
    let mainTitleLb = UILabel()
    let mainLogoIv = UIImageView()
    let mainSchoolTv = SchoolTableView()
    
    var htMainFxCst: NSLayoutConstraint!
    
    var mainCurrentAlert: AlertView?
    
    private var mainQueue = DispatchQueue(label: "main.queue")
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.mainUpdateOrientation), name: NSNotification.Name(rawValue: "updateOrientation"), object: nil)
        
        // Self
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Logo
        mainLogoIv.image = UIImage(named: "logo")
        mainLogoIv.translatesAutoresizingMaskIntoConstraints = false
        mainLogoIv.layer.shadowOffset = CGSize.zero
        mainLogoIv.layer.shadowOpacity = 0.25
        mainLogoIv.layer.shadowRadius = 4
        view.addSubview(mainLogoIv)
        
        let wtMainLogoIvCst = NSLayoutConstraint(item: mainLogoIv, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400)
        let htMainLogoIvCst = NSLayoutConstraint(item: mainLogoIv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 400)
        let hcMainLogoIvCst = NSLayoutConstraint(item: mainLogoIv, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let vcMainLogoIvCst = NSLayoutConstraint(item: mainLogoIv, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([wtMainLogoIvCst, htMainLogoIvCst, hcMainLogoIvCst, vcMainLogoIvCst])
        
        // Table
        mainSchoolTv.alpha = 0
        mainSchoolTv.schoolTableViewDelegate = self
        view.addSubview(mainSchoolTv)
        
        let hlMainSchoolTvCst = NSLayoutConstraint(item: mainSchoolTv, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let hrMainSchoolTvCst = NSLayoutConstraint(item: mainSchoolTv, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let vtMainSchoolTvCst = NSLayoutConstraint(item: mainSchoolTv, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let vbMainSchoolTvCst = NSLayoutConstraint(item: mainSchoolTv, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([hlMainSchoolTvCst, hrMainSchoolTvCst, vtMainSchoolTvCst, vbMainSchoolTvCst])
        
        // Fx
        mainFx.alpha = 0
        mainFx.translatesAutoresizingMaskIntoConstraints = false
        mainFx.layer.shadowOffset = CGSize.zero
        mainFx.layer.shadowOpacity = 0.25
        mainFx.layer.shadowRadius = 4
        view.addSubview(mainFx)
        
        htMainFxCst = NSLayoutConstraint(item: mainFx, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        let hlMainFxCst = NSLayoutConstraint(item: mainFx, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let hrMainFxCst = NSLayoutConstraint(item: mainFx, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let vtMainFxCst = NSLayoutConstraint(item: mainFx, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([htMainFxCst, hlMainFxCst, hrMainFxCst, vtMainFxCst])
        
        // Title
        mainTitleLb.alpha = 0
        mainTitleLb.text = "N. Y. C.    S c h o o l s"
        mainTitleLb.textColor = .darkGray
        mainTitleLb.textAlignment = .center
        mainTitleLb.font =  UIFont(name: "Lato-Black", size: 24)
        mainTitleLb.translatesAutoresizingMaskIntoConstraints = false
        mainTitleLb.layer.shadowOffset = CGSize.zero
        mainTitleLb.layer.shadowOpacity = 0.25
        mainTitleLb.layer.shadowRadius = 4
        view.addSubview(mainTitleLb)
        
        let htMainTitleLbCst = NSLayoutConstraint(item: mainTitleLb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64)
        let hlMainTitleLbCst = NSLayoutConstraint(item: mainTitleLb, attribute: .left, relatedBy: .equal, toItem: mainFx, attribute: .left, multiplier: 1, constant: 0)
        let hrMainTitleLbCst = NSLayoutConstraint(item: mainTitleLb, attribute: .right, relatedBy: .equal, toItem: mainFx, attribute: .right, multiplier: 1, constant: 0)
        let vbMainTitleLbCst = NSLayoutConstraint(item: mainTitleLb, attribute: .bottom, relatedBy: .equal, toItem: mainFx, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([htMainTitleLbCst, hlMainTitleLbCst, hrMainTitleLbCst, vbMainTitleLbCst])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Spin
        view.addSubview(spin)
        
        let hlSpinViCst = NSLayoutConstraint(item: spin, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let hrSpinViCst = NSLayoutConstraint(item: spin, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let vtSpinViCst  = NSLayoutConstraint(item: spin, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let vbSpinViCst  = NSLayoutConstraint(item: spin, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([hlSpinViCst, hrSpinViCst, vtSpinViCst, vbSpinViCst])
        
        mainUpdateOrientation()
        mainStart()
    }
    
    // Manage portrait and landscape mode
    @objc private func mainUpdateOrientation() {
        var htMainFx: CGFloat = 96
        if tool.orientation == .landscape {
            htMainFx = 64
        } else {
            if tool.device == .xPhone { htMainFx = 96 } else { htMainFx = 64 }
        }
        
        NSLayoutConstraint.deactivate([htMainFxCst])
        htMainFxCst = NSLayoutConstraint(item: mainFx, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: htMainFx)
        NSLayoutConstraint.activate([htMainFxCst])
    }
    
    // Start the app
    private func mainStart() {
        mainUpdateOrientation()
        
        UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseIn, animations: { () -> Void in
            self.mainLogoIv.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
            self.mainLogoIv.transform = CGAffineTransform.init(scaleX: 0.0001, y: 0.0001)
        }) { (finished) -> Void in
            self.spin.spinStart()
            self.mainGetData()
        }
    }
    
    // Display alert
    private func mainDisplayAlert(nb: UInt, txt: String) {
        view.endEditing(true)
        
        let alertVi = AlertView()
        alertVi.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertVi)
        
        let hlAlertCst = NSLayoutConstraint(item: alertVi, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let hrAlertCst = NSLayoutConstraint(item: alertVi, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let vtAlertCst = NSLayoutConstraint(item: alertVi, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let vbAlertCst = NSLayoutConstraint(item: alertVi, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([hlAlertCst, hrAlertCst, vtAlertCst, vbAlertCst])
        
        if mainCurrentAlert == nil {
            mainCurrentAlert = AlertView()
            alertVi.alertDisplay(nb: nb, txt: txt)
            mainCurrentAlert = alertVi
        } else {
            mainCurrentAlert?.alertDismiss {
                alertVi.alertDisplay(nb: nb, txt: txt)
                self.mainCurrentAlert = alertVi
            }
        }
    }
    
    // SchoolTableViewDelegate
    
    // Get schools with pagination
    func mainGetData() {
        mainQueue.async {
            self.api.apiGetSchools() { error in
                DispatchQueue.main.async {
                    if error != "" {
                        self.mainDisplayAlert(nb: 1, txt: error)
                    } else {
                        self.mainSchoolTv.reloadData()
                        if self.spin.isSpining {
                            self.spin.spinStop() {
                                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { () -> Void in
                                    self.mainFx.alpha = 1
                                    self.mainTitleLb.alpha = 1
                                    self.mainSchoolTv.alpha = 1
                                }) { (finished) -> Void in }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Display more details and SATs about the school
    func mainOpenSchool(school: School, idx: Int) {
        let detailVc = DetailViewController(school: school, idx: idx)
        detailVc.modalPresentationStyle = .formSheet
        detailVc.modalTransitionStyle = .coverVertical
        self.present(detailVc, animated: true, completion: { detailVc.detailUpdateOrientation() })
    }
    
    // Refresh the school table view
    func mainSchoolTvRefresh() {
        api.apiPageOfSchool = 0
        api.apiArrSchools.removeAll()
        mainSchoolTv.reloadData()
        mainGetData()
    }
}
