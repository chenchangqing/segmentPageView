//
//  ViewController.swift
//  SSASideMenu+HMSegment+SwipeView
//
//  Created by green on 15/9/15.
//  Copyright (c) 2015年 chenchangqing. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SwipeViewDataSource, SwipeViewDelegate, SSASideMenuDelegate {
    
    // MARK: - UI HMSegmentedControl/SwipeView
    
    @IBOutlet var segmentedControl  : HMSegmentedControl!
    @IBOutlet var swipeView         : SwipeView!
    
    // MARK: - 侧边栏是否显示
    
    var sideMenuIsShow  = false
    
    // MARK: - 水平向左触发下一页最小移动距离
    
    let kHorizontalToLeftMinMoveDistance:CGFloat = 30
    
    // MARK: - 页面切换时间
    let kDuration:Double = 0.3
    
    // MARK: - Items
    
    var items:OrderedDictionary<NSNumber,UIColor> = {
    
        var items = OrderedDictionary<NSNumber,UIColor>()
        
        items[0] = UIColor.greenColor()
        items[1] = UIColor.redColor()
        items[2] = UIColor.grayColor()
        items[3] = UIColor.blueColor()
        items[4] = UIColor.magentaColor()
        
        return items
    }()
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    deinit {
        
        swipeView.delegate = nil
        swipeView.dataSource = nil
        self.sideMenuViewController?.delegate = nil
    }

    // MARK: - Set Up
    
    private func setUp() {
        
        setUpSegmentedControl()
        setUpSwipeView()
        setUpSSASideMenu()
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
        
        segmentedControl.indexChangeBlock = { (index:NSInteger) in
        
            self.swipeView.scrollToPage(index, duration: self.kDuration)
        }
        
        self.view.addSubview(segmentedControl)
    }
    
    // MARK: - Set Up SwipeView
    
    private func setUpSwipeView() {
        
        swipeView.delegate = self
        swipeView.dataSource = self
        swipeView.bounces = false
        swipeView.scrollEnabled = false
    }
    
    // MARK: - Set Up SSASideMenu
    
    private func setUpSSASideMenu() {
        
        self.sideMenuViewController?.delegate = self
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
        
        let key     = items.keys[index]
        let value   = items[key]
        
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
    
    func swipeViewDidScroll(swipeView: SwipeView!) {
        
        updateScollEnabled()
    }
    
    func swipeViewCurrentItemIndexDidChange(swipeView: SwipeView!) {
        
        self.segmentedControl.setSelectedSegmentIndex(UInt(swipeView.currentItemIndex), animated: true)
    }
    
    private func updateScollEnabled() {
        
        if swipeView.scrollOffset == 0 {
            
            swipeView.scrollEnabled = false
        }
        if swipeView.scrollOffset == 1 {
            
            swipeView.scrollEnabled = true
        }
    }
    
    // MARK: - SSASideMenuDelegate
    
    func sideMenuDidRecognizePanGesture(sideMenu: SSASideMenu, recongnizer: UIPanGestureRecognizer) {
        
        let translation = recongnizer.translationInView(self.swipeView)
        
        if translation.x >= 0
            || sideMenuIsShow
                || swipeView.scrolling
                    || swipeView.decelerating {
            return
        }
        
        let percent = fabs(translation.x)/self.swipeView.bounds.width
        
        if percent > swipeView.scrollOffset {
            
            swipeView.scrollOffset = percent
        }
        
        if recongnizer.state == UIGestureRecognizerState.Ended {
            
            if fabs(translation.x) > kHorizontalToLeftMinMoveDistance {
                
                swipeView.scrollToPage(1, duration: kDuration)
            } else {
                
                swipeView.scrollToPage(0, duration: kDuration)
            }
        }
    }
    
    func sideMenuDidShowMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        
        sideMenuIsShow = true
    }
    
    func sideMenuDidHideMenuViewController(sideMenu: SSASideMenu, menuViewController: UIViewController) {
        
        sideMenuIsShow = false
    }
}

