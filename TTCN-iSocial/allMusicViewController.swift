//
//  allMusicViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 4/6/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

var songg: Song!

class allMusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblAllMusic: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataMusic()
        tblAllMusic.delegate = self
        tblAllMusic.dataSource = self
        // Do any additional setup after loading the view.
    }

    func getDataMusic(){
        let url = Bundle.main.url(forResource: "musicOnline", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        let result = json["station"] as! [[String:Any]]
        for i in result {
            arrSongg.append(song(nameSong: i["name"] as! String, url: i["streamURL"] as! String, desc:  i["desc"] as! String, descLong: i["name"] as! String))
            arrimageURL.append(i["imageURL"] as! String)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSongg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customCellTableViewCell
        cell.lblTitle.text = arrSongg[indexPath.row].nameSong
        cell.lblDes.text = arrSongg[indexPath.row].desc
        cell.imgAvatar.image = UIImage(named: arrimageURL[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrSongOnline.count > 0{
            songSelected = indexPath.row
            songArr = arrSongOnline
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "playerView") as! playerViewController
            self.navigationController?.pushViewController(vc, animated: true)        }
    }
    
}

