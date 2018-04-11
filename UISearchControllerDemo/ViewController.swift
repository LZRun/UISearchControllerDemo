//
//  ViewController.swift
//  UISearchControllerDemo
//
//  Created by LZR on 11/04/2018.
//  Copyright © 2018 Run. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    var searchContrl: UISearchController!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchContrl()
    }
    
    func setupSearchContrl() {
        searchContrl = UISearchController.init(searchResultsController: nil)
        searchContrl.searchResultsUpdater = self
        // 去掉边框
        searchContrl.searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        searchContrl.searchBar.isTranslucent = false
        // 设置背景色
        searchContrl.searchBar.barTintColor = UIColor.red
        searchContrl.searchBar.searchBarStyle = .minimal
        // 设置光标和其它按钮颜色
        searchContrl.searchBar.tintColor = UIColor.black
        // 调整输入框高度, 宽度可以设置大于0的任意值，高度为输入框显示高度
        let image = self.searchFieldImage(CGSize.init(width: 100, height: 30))
//        image = image?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 45, bottom: 0, right: 45), resizingMode: UIImageResizingMode.stretch)
        searchContrl.searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        tableView.tableHeaderView = searchContrl.searchBar

    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.adjustSearchBarSubViewColor()
    }
    
    // MARK: - Cutome method
    // 当光标和按钮颜色不同时，设置按钮或光标颜色
    func adjustSearchBarSubViewColor() {
        // iOS7.0以后searchBar多了一个子视图
        guard let containerView = searchContrl.searchBar.subviews.first else {
            return
        }
        
        // 猜想：CancelButton为懒加载机制，设置为true，强制初始化CancelButton
        searchContrl.searchBar.showsCancelButton = true
        for subView in containerView.subviews {
            if subView.isKind(of: UIButton.classForCoder()) {
                let button = subView as! UIButton
                button.setTitleColor(UIColor.blue, for: .normal)
            }
//            if subView.isKind(of: UITextField.classForCoder()) {
//                let textField = subView as! UITextField
//                textField.tintColor = UIColor.orange
//            }
        }
    }
    
    func searchFieldImage(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        UIColor.white.setFill()
        UIRectFill(CGRect.init(origin: CGPoint.zero, size: size))
        // 圆角效果
//        let path = UIBezierPath.init(roundedRect: CGRect.init(origin: CGPoint.zero, size: size), cornerRadius: size.height / 2)
//        path.fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

