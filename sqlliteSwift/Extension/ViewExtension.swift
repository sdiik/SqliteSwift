//
//  ViewExtension.swift
//  sqlliteSwift
//
//  Created by ahmad shiddiq on 09/04/21.
//  Copyright © 2021 ahmad shiddiq. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

extension UIView {
    func hideSkeleton() {
        self.hideSkeleton()
        self.isHidden = true
    }
    
    func showSkeleton() {
        self.isHidden = false
        self.showSkeleton()
    }
}
