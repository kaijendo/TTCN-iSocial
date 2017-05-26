//
//  seachViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/7/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class seachViewController: UIViewController {
//MARK: Variable
    var loadingView: UIView = UIView()
    let source:[String] = ["nhaccuatui.com", "mp3.zing.vn", "chiasenhac.com"]
    var sourceIndex:Int = 0
    var searchBarActive:Bool = false
    var activityIndicatorView:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
//MARK: IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblSeach: UITableView!
    @IBOutlet weak var lblMessage: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.enablesReturnKeyAutomatically = false
        tblSeach.register(UINib(nibName: "configSeachTableViewCell", bundle: nil), forCellReuseIdentifier: "cellForConfigSeach")
        tblSeach.delegate   = self
        tblSeach.dataSource = self
        tblSeach.tableFooterView = UIView()
        lblMessage.isHidden = false
        lblMessage.text = "Chưa có dữ liệu"
        configLoadingView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
