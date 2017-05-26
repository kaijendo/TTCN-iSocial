//
//  handleSeach.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/7/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

extension seachViewController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSongOnline.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForConfigSeach", for: indexPath) as! configSeachTableViewCell
        
        if !(indexPath.row > arrSongOnline.count - 1) {
            cell.lblNameSong?.text = arrSongOnline[indexPath.row].title
            cell.lblArtist?.text = arrSongOnline[indexPath.row].artist
            cell.lblSource?.text = arrSongOnline[indexPath.row].host
            if arrSongOnline[indexPath.row].avatarURL != ""{
                cell.imgSong?.loadImageFromUsingCache(urlString: arrSongOnline[indexPath.row].avatarURL)
            }else{
                cell.imgSong.image = UIImage(named: "defaultSongAvatar")
            }
            cell.lblQuality?.text = arrSongOnline[indexPath.row].quality
            cell.lblQuality?.layer.cornerRadius = 10
            cell.lblQuality?.layer.borderWidth = 1
            cell.lblQuality?.layer.borderColor = cell.lblNameSong.textColor.cgColor
            cell.lblQuality?.textColor = cell.lblNameSong.textColor
            cell.lblQuality?.clipsToBounds = true
            cell.imgSong?.layer.cornerRadius = cell.imgSong.frame.size.width/2
            cell.imgSong?.clipsToBounds = true
            cell.imgSong?.tintColor = UIColor(red:0.48, green:0.52, blue:0.99, alpha:1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if arrSongOnline.count > 0{
            songSelected = indexPath.row
            songArr = arrSongOnline
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "playerView") as! playerViewController
            self.navigationController?.pushViewController(vc, animated: true)        }
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        var footerHeight:CGFloat = 0
        if section == 0 && player != nil{
            footerHeight = self.view.frame.size.height/10
        }
        return footerHeight
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //Button "Download"
        let downloadButton = UITableViewRowAction(style: .default, title: "Tải về", handler: { (action, indexPath) in
            //Handle Download
       // self.handleDownloadSong(arrSongOnline[indexPath.row])
        })
        //Button "Add to playlist"
        let addPlaylistButton = UITableViewRowAction(style: .default, title: "Thêm", handler: { (action, indexPath) in
 // self.handleAddSongToPlaylist(indexPath.row)
        })
        return [downloadButton, addPlaylistButton]
    }
    
}

private var requestTask:Request!

extension seachViewController {
    func configLoadingView() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        activityIndicatorView.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(activityIndicatorView)
        view.addSubview(loadingView)
        activityIndicatorView.startAnimating()
        loadingView.isHidden = true

    }
}
extension seachViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.becomeFirstResponder()
        showResults(searchText: searchText)
    }
    
    func showResults(searchText: String){
        if searchText != ""{
            let code:String = "54db3d4b-518f-4f50-aa34-393147a8aa18"
            arrSongOnline = []
            requestTask?.cancel()
            //Show activityIndicatorView
            if loadingView.isHidden == true{
                loadingView.isHidden = false
            }
            
            let input = searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            
            requestTask = Alamofire.request("http://j.ginggong.com/jOut.ashx?k=\(input!)&h=\(source[sourceIndex])&code=\(code)").responseJSON(completionHandler: { (responseData) in
                if responseData.result.value != nil{
                    let json = JSON(responseData.result.value!)
                    if let results:Array<Dictionary<String,AnyObject>> = json.arrayObject as? Array<Dictionary<String,AnyObject>>{
                        for i in results{
                            let song:Song = Song(dic: i)
                            if song.streamURL != ""{
                                arrSongOnline.append(song)
                            }
                        }
                    }
                    self.loadingView.isHidden = true
                    self.tblSeach.reloadData()
                    if arrSongOnline.count != 0{
                        self.lblMessage.isHidden = true
                    }else{
                        self.lblMessage.text = "Rất tiếc, chúng tôi không tìm thấy bài hát mà bạn yêu cầu!"
                        self.lblMessage.isHidden = false
                    }
                }
            })
            
        }
        
    }

}


