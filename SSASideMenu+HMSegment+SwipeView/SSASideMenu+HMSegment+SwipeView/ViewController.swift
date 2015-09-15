//
//  ViewController.swift
//  SSASideMenu+HMSegment+SwipeView
//
//  Created by green on 15/9/15.
//  Copyright (c) 2015年 chenchangqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SwipeViewDataSource, SwipeViewDelegate {
    
    // MARK: - UI HMSegmentedControl/SwipeView
    
    @IBOutlet var segmentedControl  : HMSegmentedControl!
    @IBOutlet var swipeView         : SwipeView!
    
    // MARK: - Items
    
    var items:[NSNumber:UIColor] = [
        0:UIColor.greenColor(),
        1:UIColor.redColor(),
        2:UIColor.grayColor(),
        3:UIColor.blueColor(),
        4:UIColor.magentaColor()
    ]
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    deinit {
        
        swipeView.delegate = nil
        swipeView.dataSource = nil
    }

    // MARK: - Set Up
    
    private func setUp() {
        
        setUpSegmentedControl()
        setUpSwipeView()
    }
    
    // MARK: - Set Up SegmentedControl
    
    private func setUpSegmentedControl() {
        
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
    
    // MARK: - Set Up SwipeView
    
    private func setUpSwipeView() {
        
        swipeView.delegate = self
        swipeView.dataSource = self
    }
    
    // MARK: - SwipeViewDataSource
    
    func swipeView(swipeView: SwipeView!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        
        var label:UILabel?
        var resultView = view
        
        if resultView == nil {
            
            resultView = UIView(frame: self.swipeView.bounds)
            resultView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
            
            label = UILabel(frame: self.swipeView.bounds)
            label?.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
            label?.backgroundColor = UIColor.clearColor()
            label?.textAlignment = NSTextAlignment.Center
            label?.font = label?.font.fontWithSize(50)
            label?.tag = 1
            
            resultView.addSubview(label!)
        } else {
            
            label = view.viewWithTag(1) as? UILabel
        }
        
        let key     = items.keys.array[index]
        let value   = items.values.array[index]
        
        label?.text = "\(key)"
        resultView.backgroundColor = value
        
        return resultView
    }
    
    func numberOfItemsInSwipeView(swipeView: SwipeView!) -> Int {
        
        return items.count
    }
    
    // MARK: - SwipeViewDelegate
    
    func swipeViewItemSize(swipeView: SwipeView!) -> CGSize {
        
        return self.swipeView.bounds.size
    }
}

