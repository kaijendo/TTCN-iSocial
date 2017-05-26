//
//  iSoundViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/15/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit

class iSoundViewController: UIViewController {
    
//MARK: IBOutlet
    @IBOutlet weak var tblMenu: UITableView!
//MARK: Variable
    let arrVC:[[String]] = [["allMusic"],["favOnline","playlistOnline"],["myMusic","PlaylistOffline"],["Setting","Helps","About"]]
    let arrHeader:[String] = ["","TRỰC TUYẾN","NGOẠI TUYẾN","THÔNG TIN"]
    var arrMenu:[[String]] =
        [["Tất cả bài hát"],
         ["Ưa thích", "Playlist online"],
         ["Nhạc của tui","Playlist của tui"],
         ["Cài đặt", "Hướng dẫn", "Giới thiệu"]]
 
    override func viewDidLoad() {
        super.viewDidLoad()

        tblMenu.register(UINib(nibName: "configCellTableViewCell", bundle: nil), forCellReuseIdentifier: "cellForSoundMenu")
        tblMenu.delegate    = self
        tblMenu.dataSource  = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
