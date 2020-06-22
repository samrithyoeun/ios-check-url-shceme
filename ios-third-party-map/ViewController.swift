//
//  ViewController.swift
//  ios-third-party-map
//
//  Created by Samrith Yoeun on 6/20/20.
//  Copyright © 2020 Sammi Yoeun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let lat = 11.556374
    let long = 104.928207
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func checkAvailableMapApplications() -> [String: URL] {
        var mapUrl = [String: URL]()
        
        if (UIApplication.shared.canOpenURL(URL(string: "maps://")!)) {
            mapUrl["Map"] = generateAppleMapDirectionUrl(lat: lat, long: long)
        }
        
        
        if UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!) {
            mapUrl["Google Maps"] = generateGoogleMapDirectionUrl(lat: lat, long: long)
        }
        
        return mapUrl
    }
    
    func generateGoogleMapDirectionUrl(lat: Double, long:  Double) -> URL {
        let lat = lat
        let long = long
        let string = "https://www.google.com/maps/dir/?api=1&destination=\(lat),\(long)"
        let encoded = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: encoded)!
    }
    
    func generateAppleMapDirectionUrl(lat: Double, long: Double) -> URL {
        return URL(string: "http://maps.apple.com/?daddr=\(lat),\(long)")!
    }
    
    

    @IBAction func buttonDidTapped(_ sender: UIButton) {
                UIAlertController.showDirectionOptions(options: checkAvailableMapApplications(), in: self)
    }
}


extension UIAlertController {
    
    static func alert(_ message: String, title: String = "", in viewController: UIViewController) {
        let controller = UIAlertController()
        controller.title = title
        controller.message = message
        
        let okayAction = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        controller.addAction(okayAction)
        viewController.present(controller, animated: true, completion: nil)
    }
    
    static func showDirectionOptions(options: [String: URL], in viewController: UIViewController) {
        let controller = UIAlertController()
        
        for (key, value) in options {
            let action = UIAlertAction(title: "Open in \(key)", style: .default) { _ in
                UIApplication.shared.open(value, options: [:], completionHandler: nil)
            }
            controller.addAction(action)
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        cancelAction.setValue(UIColor.black, forKey: "titleTextColor")
        
        controller.addAction(cancelAction)
        viewController.present(controller, animated: true, completion: nil)
    }
}
