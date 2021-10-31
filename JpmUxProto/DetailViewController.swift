//
//  DetailViewController.swift
//  JpmUxProto
//
//  Created by Christophe Vichery on 10/30/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    let api = Api.share
    
    let detailFx = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
    
    let detailTitleLb = UILabel()
    let detailExitBt = UIButton()
    
    let detailSv = UIScrollView()
        
    let detailLogoIv = UIImageView()
    let detailNeighborhoodLb = UILabel()
    let detailLocationLb = UILabel()
    
    let detailWebsiteLb = UITextView()
    let detailEmailLb = UITextView()
    let detailPhoneLb = UITextView()
    
    let detailOverviewLb = UILabel()
    
    let detailTakersLb = UILabel()
    let detailReadingLb = UILabel()
    let detailWritingLb = UILabel()
    let detailMathLb = UILabel()
    
    var detailSchool = School()
    
    private var detailQueue = DispatchQueue(label: "detail.queue")
    
    convenience init(school: School) {
        self.init()
        
        self.detailSchool = school
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.detailUpdateOrientation), name: NSNotification.Name(rawValue: "updateOrientation"), object: nil)
        
        // Fx
        detailFx.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailFx)
        
        let hlDetailFxCst = NSLayoutConstraint(item: detailFx, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let hrDetailFxCst = NSLayoutConstraint(item: detailFx, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let vtDetailFxCst = NSLayoutConstraint(item: detailFx, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let vbDetailFxCst = NSLayoutConstraint(item: detailFx, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([hlDetailFxCst, hrDetailFxCst, vtDetailFxCst, vbDetailFxCst])
        
        // Exit
        detailExitBt.setTitle("\u{02297}",for: .normal)
        detailExitBt.titleLabel?.font = UIFont(name: "Lato-Bold", size: 48)
        detailExitBt.addTarget(self, action: #selector(detailExitBtAction), for: .touchUpInside)
        detailExitBt.translatesAutoresizingMaskIntoConstraints = false
        detailExitBt.layer.shadowOffset = CGSize.zero
        detailExitBt.layer.shadowOpacity = 0.5
        detailExitBt.layer.shadowRadius = 4
        view.addSubview(detailExitBt)
        
        let wtDetailExitBtCst = NSLayoutConstraint(item: detailExitBt, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64)
        let htDetailExitBtCst = NSLayoutConstraint(item: detailExitBt, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 64)
        let hlDetailExitBtCst = NSLayoutConstraint(item: detailExitBt, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let vtDetailExitBtCst = NSLayoutConstraint(item: detailExitBt, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([wtDetailExitBtCst, htDetailExitBtCst, hlDetailExitBtCst, vtDetailExitBtCst])
        
        // Title
        detailTitleLb.numberOfLines = 0
        detailTitleLb.textAlignment = .center
        detailTitleLb.text = detailSchool.school_name
        detailTitleLb.font =  UIFont(name: "Lato-Bold", size: 16)
        detailTitleLb.translatesAutoresizingMaskIntoConstraints = false
        detailTitleLb.layer.shadowOffset = CGSize.zero
        detailTitleLb.layer.shadowOpacity = 0.5
        detailTitleLb.layer.shadowRadius = 4
        view.addSubview(detailTitleLb)
        
        let hlDetailTitleLbCst = NSLayoutConstraint(item: detailTitleLb, attribute: .left, relatedBy: .equal, toItem: detailExitBt, attribute: .right, multiplier: 1, constant: 0)
        let hrDetailTitleLbCst = NSLayoutConstraint(item: detailTitleLb, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -64)
        let vtDetailTitleLbCst = NSLayoutConstraint(item: detailTitleLb, attribute: .top, relatedBy: .equal, toItem: detailExitBt, attribute: .top, multiplier: 1, constant: 0)
        let vbDetailTitleLbCst = NSLayoutConstraint(item: detailTitleLb, attribute: .bottom, relatedBy: .equal, toItem: detailExitBt, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([hlDetailTitleLbCst, hrDetailTitleLbCst, vtDetailTitleLbCst, vbDetailTitleLbCst])
        
        // Scroll view
        detailSv.showsVerticalScrollIndicator = false
        detailSv.contentInsetAdjustmentBehavior = .never
        detailSv.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailSv)
        
        let hlDetailSvCst = NSLayoutConstraint(item: detailSv, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0)
        let hrDetailSvCst = NSLayoutConstraint(item: detailSv, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0)
        let vtDetailSvCst = NSLayoutConstraint(item: detailSv, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 64)
        let vbDetailSvCst = NSLayoutConstraint(item: detailSv, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([hlDetailSvCst, hrDetailSvCst, vtDetailSvCst, vbDetailSvCst])
        
        // Logo
        detailLogoIv.alpha = 1
        detailLogoIv.backgroundColor = .white
        detailLogoIv.image = UIImage(named: "school")
        detailLogoIv.translatesAutoresizingMaskIntoConstraints = false
        detailLogoIv.layer.cornerRadius = 64
        detailLogoIv.layer.shadowOffset = CGSize.zero
        detailLogoIv.layer.shadowOpacity = 1
        detailLogoIv.layer.shadowRadius = 4
        detailSv.addSubview(detailLogoIv)
        
        let wtDetailLogoIvCst = NSLayoutConstraint(item: detailLogoIv, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 128)
        let htDetailLogoIvCst = NSLayoutConstraint(item: detailLogoIv, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 128)
        let hcDetailLogoIvCst = NSLayoutConstraint(item: detailLogoIv, attribute: .centerX, relatedBy: .equal, toItem: detailSv, attribute: .centerX, multiplier: 1, constant: 0)
        let vtDetailLogoIvCst = NSLayoutConstraint(item: detailLogoIv, attribute: .top, relatedBy: .equal, toItem: detailSv, attribute: .top, multiplier: 1, constant: 32)
        NSLayoutConstraint.activate([wtDetailLogoIvCst, htDetailLogoIvCst, hcDetailLogoIvCst, vtDetailLogoIvCst])
        
        // Neighborhood
        detailNeighborhoodLb.numberOfLines = 0
        detailNeighborhoodLb.textAlignment = .center
        detailNeighborhoodLb.text = detailSchool.neighborhood
        detailNeighborhoodLb.font =  UIFont(name: "Lato-Regular", size: 16)
        detailNeighborhoodLb.sizeToFit()
        detailNeighborhoodLb.translatesAutoresizingMaskIntoConstraints = false
        detailNeighborhoodLb.layer.shadowOffset = CGSize.zero
        detailNeighborhoodLb.layer.shadowOpacity = 0.5
        detailNeighborhoodLb.layer.shadowRadius = 4
        detailSv.addSubview(detailNeighborhoodLb)
        
        let hlDetailNeighborhoodLbCst = NSLayoutConstraint(item: detailNeighborhoodLb, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 48)
        let hrDetailNeighborhoodLbCst = NSLayoutConstraint(item: detailNeighborhoodLb, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -48)
        let vtDetailNeighborhoodLbCst = NSLayoutConstraint(item: detailNeighborhoodLb, attribute: .top, relatedBy: .equal, toItem: detailLogoIv, attribute: .bottom, multiplier: 1, constant: 32)
        NSLayoutConstraint.activate([hlDetailNeighborhoodLbCst, hrDetailNeighborhoodLbCst, vtDetailNeighborhoodLbCst])
        
        // Location
        detailLocationLb.numberOfLines = 0
        detailLocationLb.textAlignment = .center
        detailLocationLb.text = detailSchool.location
        detailLocationLb.font =  UIFont(name: "Lato-Regular", size: 16)
        detailLocationLb.sizeToFit()
        detailLocationLb.translatesAutoresizingMaskIntoConstraints = false
        detailLocationLb.layer.shadowOffset = CGSize.zero
        detailLocationLb.layer.shadowOpacity = 0.5
        detailLocationLb.layer.shadowRadius = 4
        detailSv.addSubview(detailLocationLb)
        
        let hlDetailLocationLbCst = NSLayoutConstraint(item: detailLocationLb, attribute: .left, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .left, multiplier: 1, constant: 0)
        let hrDetailLocationLbCst = NSLayoutConstraint(item: detailLocationLb, attribute: .right, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .right, multiplier: 1, constant: 0)
        let vtDetailLocationLbCst = NSLayoutConstraint(item: detailLocationLb, attribute: .top, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .bottom, multiplier: 1, constant: 8)
        NSLayoutConstraint.activate([hlDetailLocationLbCst, hrDetailLocationLbCst, vtDetailLocationLbCst])
        
        // Website
        detailWebsiteLb.isEditable = false
        detailWebsiteLb.isSelectable = true
        detailWebsiteLb.isUserInteractionEnabled = true
        detailWebsiteLb.textAlignment = .center
        detailWebsiteLb.backgroundColor = .clear
        detailWebsiteLb.dataDetectorTypes = .link
        detailWebsiteLb.text = detailSchool.website
        detailWebsiteLb.font =  UIFont(name: "Lato-Italic", size: 16)
        detailWebsiteLb.translatesAutoresizingMaskIntoConstraints = false
        detailWebsiteLb.layer.shadowOffset = CGSize.zero
        detailWebsiteLb.layer.shadowOpacity = 0.5
        detailWebsiteLb.layer.shadowRadius = 4
        detailSv.addSubview(detailWebsiteLb)
        
        let htDetailWebsiteLbCst = NSLayoutConstraint(item: detailWebsiteLb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 38)
        let hlDetailWebsiteLbCst = NSLayoutConstraint(item: detailWebsiteLb, attribute: .left, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .left, multiplier: 1, constant: 0)
        let hrDetailWebsiteLbCst = NSLayoutConstraint(item: detailWebsiteLb, attribute: .right, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .right, multiplier: 1, constant: 0)
        let vtDetailWebsiteLbCst = NSLayoutConstraint(item: detailWebsiteLb, attribute: .top, relatedBy: .equal, toItem: detailLocationLb, attribute: .bottom, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([htDetailWebsiteLbCst, hlDetailWebsiteLbCst, hrDetailWebsiteLbCst, vtDetailWebsiteLbCst])
        
        // School email
        detailEmailLb.isEditable = false
        detailEmailLb.isSelectable = true
        detailEmailLb.isUserInteractionEnabled = true
        detailEmailLb.textAlignment = .center
        detailEmailLb.backgroundColor = .clear
        detailEmailLb.dataDetectorTypes = .link
        detailEmailLb.text = detailSchool.school_email
        detailEmailLb.font =  UIFont(name: "Lato-Italic", size: 16)
        detailEmailLb.translatesAutoresizingMaskIntoConstraints = false
        detailEmailLb.layer.shadowOffset = CGSize.zero
        detailEmailLb.layer.shadowOpacity = 0.5
        detailEmailLb.layer.shadowRadius = 4
        detailSv.addSubview(detailEmailLb)
        
        let htDetailEmailLbCst = NSLayoutConstraint(item: detailEmailLb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 38)
        let hlDetailEmailLbCst = NSLayoutConstraint(item: detailEmailLb, attribute: .left, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .left, multiplier: 1, constant: 0)
        let hrDetailEmailLbCst = NSLayoutConstraint(item: detailEmailLb, attribute: .right, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .right, multiplier: 1, constant: 0)
        let vtDetailEmailLbCst = NSLayoutConstraint(item: detailEmailLb, attribute: .top, relatedBy: .equal, toItem: detailWebsiteLb, attribute: .bottom, multiplier: 1, constant: -8)
        NSLayoutConstraint.activate([htDetailEmailLbCst, hlDetailEmailLbCst, hrDetailEmailLbCst, vtDetailEmailLbCst])
        
        // Phone number
        detailPhoneLb.isEditable = false
        detailPhoneLb.isSelectable = true
        detailPhoneLb.isUserInteractionEnabled = true
        detailPhoneLb.textAlignment = .center
        detailPhoneLb.backgroundColor = .clear
        detailPhoneLb.dataDetectorTypes = .phoneNumber
        detailPhoneLb.text = detailSchool.phone_number
        detailPhoneLb.font =  UIFont(name: "Lato-Italic", size: 16)
        detailPhoneLb.translatesAutoresizingMaskIntoConstraints = false
        detailPhoneLb.layer.shadowOffset = CGSize.zero
        detailPhoneLb.layer.shadowOpacity = 0.5
        detailPhoneLb.layer.shadowRadius = 4
        detailSv.addSubview(detailPhoneLb)
        
        let htDetailPhoneLbCst = NSLayoutConstraint(item: detailPhoneLb, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 38)
        let hlDetailPhoneLbCst = NSLayoutConstraint(item: detailPhoneLb, attribute: .left, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .left, multiplier: 1, constant: 0)
        let hrDetailPhoneLbCst = NSLayoutConstraint(item: detailPhoneLb, attribute: .right, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .right, multiplier: 1, constant: 0)
        let vtDetailPhoneLbCst = NSLayoutConstraint(item: detailPhoneLb, attribute: .top, relatedBy: .equal, toItem: detailEmailLb, attribute: .bottom, multiplier: 1, constant: -8)
        NSLayoutConstraint.activate([htDetailPhoneLbCst, hlDetailPhoneLbCst, hrDetailPhoneLbCst, vtDetailPhoneLbCst])
        
        // Overview
        detailOverviewLb.numberOfLines = 0
        detailOverviewLb.textAlignment = .left
        detailOverviewLb.text = detailSchool.overview_paragraph
        detailOverviewLb.font =  UIFont(name: "Lato-Regular", size: 14)
        detailOverviewLb.sizeToFit()
        detailOverviewLb.translatesAutoresizingMaskIntoConstraints = false
        detailOverviewLb.layer.shadowOffset = CGSize.zero
        detailOverviewLb.layer.shadowOpacity = 0.5
        detailOverviewLb.layer.shadowRadius = 4
        detailSv.addSubview(detailOverviewLb)
        
        let hlDetailOverviewLbCst = NSLayoutConstraint(item: detailOverviewLb, attribute: .left, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .left, multiplier: 1, constant: 0)
        let hrDetailOverviewLbCst = NSLayoutConstraint(item: detailOverviewLb, attribute: .right, relatedBy: .equal, toItem: detailNeighborhoodLb, attribute: .right, multiplier: 1, constant: 0)
        let vtDetailOverviewLbCst = NSLayoutConstraint(item: detailOverviewLb, attribute: .top, relatedBy: .equal, toItem: detailPhoneLb, attribute: .bottom, multiplier: 1, constant: 16)
        NSLayoutConstraint.activate([hlDetailOverviewLbCst, hrDetailOverviewLbCst, vtDetailOverviewLbCst])
        
        // SAT Takers
        detailTakersLb.text = "Num of SAT Test Takers : "
        detailTakersLb.font =  UIFont(name: "Lato-Regular", size: 16)
        detailTakersLb.sizeToFit()
        detailTakersLb.translatesAutoresizingMaskIntoConstraints = false
        detailTakersLb.layer.shadowOffset = CGSize.zero
        detailTakersLb.layer.shadowOpacity = 0.5
        detailTakersLb.layer.shadowRadius = 4
        detailSv.addSubview(detailTakersLb)
        
        let hcDetailTakersLbCst = NSLayoutConstraint(item: detailTakersLb, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let vtDetailTakersLbCst = NSLayoutConstraint(item: detailTakersLb, attribute: .top, relatedBy: .equal, toItem: detailOverviewLb, attribute: .bottom, multiplier: 1, constant: 32)
        NSLayoutConstraint.activate([hcDetailTakersLbCst, vtDetailTakersLbCst])
        
        // SAT Reading
        detailReadingLb.text = "SAT Reading Avg. Score : "
        detailReadingLb.font =  UIFont(name: "Lato-Regular", size: 16)
        detailReadingLb.sizeToFit()
        detailReadingLb.translatesAutoresizingMaskIntoConstraints = false
        detailReadingLb.layer.shadowOffset = CGSize.zero
        detailReadingLb.layer.shadowOpacity = 0.5
        detailReadingLb.layer.shadowRadius = 4
        detailSv.addSubview(detailReadingLb)
        
        let hlDetailReadingLbCst = NSLayoutConstraint(item: detailReadingLb, attribute: .left, relatedBy: .equal, toItem: detailTakersLb, attribute: .left, multiplier: 1, constant: 0)
        let vtDetailReadingLbCst = NSLayoutConstraint(item: detailReadingLb, attribute: .top, relatedBy: .equal, toItem: detailTakersLb, attribute: .bottom, multiplier: 1, constant: 8)
        NSLayoutConstraint.activate([hlDetailReadingLbCst, vtDetailReadingLbCst])
        
        // SAT Writing
        detailWritingLb.text = "SAT Writing  Avg. Score : "
        detailWritingLb.font =  UIFont(name: "Lato-Regular", size: 16)
        detailWritingLb.sizeToFit()
        detailWritingLb.translatesAutoresizingMaskIntoConstraints = false
        detailWritingLb.layer.shadowOffset = CGSize.zero
        detailWritingLb.layer.shadowOpacity = 0.5
        detailWritingLb.layer.shadowRadius = 4
        detailSv.addSubview(detailWritingLb)
        
        let hlDetailWritingLbCst = NSLayoutConstraint(item: detailWritingLb, attribute: .left, relatedBy: .equal, toItem: detailTakersLb, attribute: .left, multiplier: 1, constant: 0)
        let vtDetailWritingLbCst = NSLayoutConstraint(item: detailWritingLb, attribute: .top, relatedBy: .equal, toItem: detailReadingLb, attribute: .bottom, multiplier: 1, constant: 8)
        NSLayoutConstraint.activate([hlDetailWritingLbCst, vtDetailWritingLbCst])
        
        // SAT Math
        detailMathLb.text = "SAT Math       Avg. Score : "
        detailMathLb.font =  UIFont(name: "Lato-Regular", size: 16)
        detailMathLb.sizeToFit()
        detailMathLb.translatesAutoresizingMaskIntoConstraints = false
        detailMathLb.layer.shadowOffset = CGSize.zero
        detailMathLb.layer.shadowOpacity = 0.5
        detailMathLb.layer.shadowRadius = 4
        detailSv.addSubview(detailMathLb)
        
        let hlDetailMathLbCst = NSLayoutConstraint(item: detailMathLb, attribute: .left, relatedBy: .equal, toItem: detailTakersLb, attribute: .left, multiplier: 1, constant: 0)
        let vtDetailMathLbCst = NSLayoutConstraint(item: detailMathLb, attribute: .top, relatedBy: .equal, toItem: detailWritingLb, attribute: .bottom, multiplier: 1, constant: 8)
        NSLayoutConstraint.activate([hlDetailMathLbCst, vtDetailMathLbCst])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        detailQueue.async {
            DispatchQueue.main.async {
                self.api.apiGetSats(dbn: self.detailSchool.dbn) { school in
                    if school.dbn == "" {
                        self.detailTakersLb.text! += "no data"
                        self.detailReadingLb.text! += "no data"
                        self.detailWritingLb.text! += "no data"
                        self.detailMathLb.text! += "no data"
                    } else {
                        self.detailTakersLb.text! += school.num_of_sat_test_takers
                        self.detailReadingLb.text! += school.sat_critical_reading_avg_score
                        self.detailWritingLb.text! += school.sat_writing_avg_score
                        self.detailMathLb.text! += school.sat_math_avg_score
                    }
                }
            }
        }
    }
    
    @objc func detailUpdateOrientation() {
        DispatchQueue.main.async {
            self.detailSv.contentSize.height = self.detailMathLb.frame.origin.y + self.detailMathLb.frame.height + 48
        }
    }
    
    @objc private func detailExitBtAction(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
}
