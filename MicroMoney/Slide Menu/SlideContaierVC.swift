//
//  SlideContaierVC.swift
//  MingalarCinema
//
//  Created by Ye Myat Min on 12/1/17.
//  Copyright © 2017 nexlabs. All rights reserved.
//

import UIKit
import Localize_Swift

protocol SlideMenuDelegate: class {
    func toggleSlideMenu()
}

class SlideContaierVC: UIViewController {
    
    enum SlideOutState {
        case open
        case collapse
    }
    
    let overlayTag = 99
    
    var slideNavigationController: UINavigationController!
    
//    var centerViewController: UIViewController!
    var centerViewController: HomeViewController!

    var menuViewController: SlideMenuVC?
    
    let centerPanelExpandedOffset: CGFloat = 60
    
    let overlayView = UIView()
    
    var isUserSelectMenu = false
    
    var currentState: SlideOutState = .collapse {
        
        didSet {
            let shouldShowShadow = ( currentState != .collapse )
            showShadowForCenterViewControler(shouldShowShadow)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        slideNavigationController.isNavigationBarHidden = true

    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        centerViewController = Storyboards.MovieList.instantiateViewController(withIdentifier: "MCMovieListViewController") as! UIViewController
        
        centerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        centerViewController.slideMenuDelegate = self
        
        slideNavigationController = UINavigationController(rootViewController: centerViewController)
        
        slideNavigationController.isNavigationBarHidden = true
        
        self.view.addSubview(slideNavigationController.view)
        self.addChildViewController(slideNavigationController)
        
        addOverLayView()
        addMenuViewController()
        
        slideNavigationController.didMove(toParentViewController: self)
        
        
        overlayView.frame = self.view.frame
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        overlayView.isUserInteractionEnabled = true
        
        overlayView.tag = overlayTag

        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleSlideMenu))
        overlayView.addGestureRecognizer(gesture)
        
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//        
//        let screenEdgeGestre = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
//        slideNavigationController.view.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    func addOverLayView() {
        
        let overlayView = UIView()
        
        overlayView.frame = self.view.frame
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        overlayView.isUserInteractionEnabled = true
        
        overlayView.tag = overlayTag
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleSlideMenu))
//        overlayView.addGestureRecognizer(gesture)
    }
    
    //  MARK: Show Shadow While .open
    
    func showShadowForCenterViewControler(_ shouldShowShadow: Bool) {
        
        if shouldShowShadow {
            
            slideNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            
            slideNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func addMenuViewController() {
        
//        guard menuViewController == nil else {
//            return
//        }
        
//        menuViewController = Storyboards.MovieList.instantiateViewController(withIdentifier: "SlideMenuVC") as? SlideMenuVC
        
        menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SlideMenuVC") as! SlideMenuVC

        if let menuVC = menuViewController {
            
            view.insertSubview(menuVC.view, at: 0)
            addChildViewController(menuVC)
            menuVC.didMove(toParentViewController: self)
            
            menuViewController?.delegate = self

        }
        
    }
    
    func showSlideMenu(_ targetPosition : CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            
            self.slideNavigationController.view.frame.origin.x = targetPosition

        }, completion: completion)
    }
    
    func showOverlay() {
        
        self.centerViewController.view.addSubview(overlayView)

        return
        
//        let overlayView = UIView()
        
//        overlayView.frame = self.view.frame
//        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//
//        overlayView.isUserInteractionEnabled = true
//
//        overlayView.tag = overlayTag
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(toggleSlideMenu))
//        overlayView.addGestureRecognizer(gesture)
        
        self.centerViewController.view.addSubview(overlayView)
        
    }
    
    func hideOverlay() {
        
//        overlayView.removeFromSuperview()
//
//        return
        
        if let overlay = self.centerViewController.view.viewWithTag(overlayTag) {
            
            overlay.removeFromSuperview()
        }
    }
    
    
}

extension SlideContaierVC: MenuDelegate {
    func didSelectMenu(at indexPath: Int, and isLanguageChange: Bool, with language: LocalizeLanguage) {
        
//        if isUserSelectMenu {
//
//            return
//        }
        
        if slideNavigationController.viewControllers.count != 1 {
            
            return
        }

        
        isUserSelectMenu = true
        
        toggleSlideMenu()
        
        var page = ""
        
        let infoVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "AboutMicroMoney") as! AboutMicroMoney
        
        switch indexPath {
        case 0:
            
            
            return
            
        case 1:
            
            if language == .Myanmar {
                
                page = "about_mm"
            } else {
                
                page = "about"
            }
            
            break

        case 2:
            
            if language == .Myanmar {
                
                page = "financialliteracy"
            } else {
                
                page = "financialliteracy"
            }
            
            break

        case 3:
            
            if language == .Myanmar {
                
                page = "apply-for-loan_mm"
            } else {
                
                page = "apply-for-loan"
            }
            
            break

        case 4:
            
            if language == .Myanmar {
                
                page = "prolongation_mm"
            } else {
                
                page = "prolongation"
            }
            
            break
            
        case 5:
            
            if language == .Myanmar {
                
                page = "loan-repayment_mm"
            } else {
                
                page = "loan-repayment"
            }
            
            break
            
        case 6:
            
            if language == .Myanmar {
                
                page = "faq_mm"
            } else {
                
                page = "faq"
            }
            
            break
            
        case 7:
            
            if language == .Myanmar {
                
                page = "contact-us_mm"
            } else {
                
                page = "contact-us"
            }
            
            break

        case 8:
            
            if language == .Myanmar {
                
                page = "career_mm"
            } else {
                
                page = "career"
            }
            
            break

        case 9:
            
            if language == .Myanmar {
                
                page = "investors"
            } else {
                
                page = "investors"
            }
            
            break


        default:
            break
        }
        
        infoVC.page = page
        
        let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
    
        isUserSelectMenu = false
        
        if slideNavigationController.viewControllers.count == 1 {
            
            slideNavigationController.pushViewController(infoVC, animated: true)
        }
        
//        slideNavigationController.pushViewController(infoVC, animated: true)
        
    }
}

extension SlideContaierVC: UIGestureRecognizerDelegate{
    
    func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        
//        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        
        switch recognizer.state {
        case .began:
            addMenuViewController()
            showShadowForCenterViewControler(true)
            
        case .changed:
            if let recognizerView = recognizer.view {
                
                recognizerView.center.x = recognizerView.center.x + recognizer.translation(in: view).x
                recognizer.setTranslation(CGPoint.zero, in: view)
            }
            
        case .ended:
            
            if let recognizerView = recognizer.view {
                
                let hasMovedGreaterThanHalfway = recognizerView.center.x > view.bounds.size.width
                
                if hasMovedGreaterThanHalfway {
                    
                    showSlideMenu(slideNavigationController.view.frame.width - centerPanelExpandedOffset) {
                        _ in
                        
//                        self.showOverlay()
                    }

                } else {
                    
//                    hideOverlay()
                    showSlideMenu(0, completion: {
                        _ in
                        
                        self.menuViewController?.view.removeFromSuperview()
                        self.menuViewController = nil
                    })
                }
                
            }
        default:
            break
        }
    }
}

extension SlideContaierVC: SlideMenuDelegate {
    
    @objc func toggleSlideMenu() {
        
        if currentState == .collapse {
            
//            addOverLay()
            currentState = .open
            addMenuViewController()
            showSlideMenu(slideNavigationController.view.frame.width - centerPanelExpandedOffset) {
                _ in
                
                self.showOverlay()
            }
            
        } else {
            
//            removeOverlay()
            self.hideOverlay()
            
            currentState = .collapse
            showSlideMenu(0, completion: {
                _ in
                
                self.menuViewController?.view.removeFromSuperview()
                self.menuViewController = nil
//                self.hideOverlay()
            })
            
        }
    }
}
