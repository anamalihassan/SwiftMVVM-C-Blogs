//
//  AppViewController.swift
//  Blogs
//
//  Created by Ali Hassan on 10/05/2021.
//

import UIKit

class AppViewController: UIViewController {
    
    // MARK: - Progress Loader
    
    func activityIndicatorStart() {
        DispatchQueue.main.async {
            LoadingSpinner.spin()
        }
    }
    
    func activityIndicatorStop() {
        DispatchQueue.main.async {
            LoadingSpinner.stop()
        }
    }
}
