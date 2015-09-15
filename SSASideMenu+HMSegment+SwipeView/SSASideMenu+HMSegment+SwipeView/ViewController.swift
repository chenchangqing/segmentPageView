//
//  ViewController.swift
//  SSASideMenu+HMSegment+SwipeView
//
//  Created by green on 15/9/15.
//  Copyright (c) 2015年 chenchangqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - HMSegmentedControl
    
    var segmentedControl: HMSegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

    // MARK: - Set Up
    
    private func setUp() {
        
        setUpSegmentedControl()
    }
    
    // MARK: - Set Up SegmentedControl
    
    private func setUpSegmentedControl() {
        
        segmentedControl = HMSegmentedControl(frame: CGRectMake(0, 64, UIScreen.mainScreen().bounds.size.width, 40))
        segmentedControl.sectionTitles               = ["景点","餐饮","购物","酒店","活动"]
        segmentedControl.selectionIndicatorHeight    = 2.0
        segmentedControl.selectionIndicatorColor     = UIColor.blueColor()
        segmentedControl.selectionIndicatorLocation  = HMSegmentedControlSelectionIndicatorLocationDown
        segmentedControl.backgroundColor             = UIColor.lightGrayColor()
        segmentedControl.titleTextAttributes         = [NSFontAttributeName:UIFont.systemFontOfSize(14)]
        segmentedControl.shouldAnimateUserSelection  = true
        segmentedControl.selectionStyle              = HMSegmentedControlSelectionStyleFullWidthStripe
        
        self.view.addSubview(segmentedControl)
    }
}

