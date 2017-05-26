//
//  playerViewController.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/16/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import UIKit
import Social
import MediaPlayer
import AVFoundation

class playerViewController: UIViewController {
//MARK: IBOutlet
    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAuth: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var btnMode: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var sldVolume: UISlider!
    @IBOutlet weak var txtLyrics: UITextView!
    @IBOutlet weak var btnVolume: UIButton!
    @IBOutlet weak var sldTime: UISlider!
    
//MARK: IBAction
    @IBAction func abtnStartPause(_ sender: Any) {
        if player.rate == 1.0{
            pause()
        }else{
            play()
        }
    }
    
    @IBAction func abtnSldTime(_ sender: Any) {
        timer.invalidate()
        player.seek(to: CMTimeMakeWithSeconds(Float64(sldTime.value), 60000)) { (action) in
            if player.rate != 1.0{
                self.btnPlay.setImage(UIImage(named:"pause"), for: .normal)
                player.play()
            }
            MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyArtist : songArr[songSelected].artist,  MPMediaItemPropertyTitle : songArr[songSelected].title, MPMediaItemPropertyPlaybackDuration : Float(CMTimeGetSeconds(playerItem.asset.duration)), MPNowPlayingInfoPropertyElapsedPlaybackTime : CMTimeGetSeconds(player.currentTime()), MPMediaItemPropertyRating : 1]
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(playerViewController.updateSlider), userInfo: nil, repeats: true)
        
    }
    @IBAction func abtnNext(_ sender: Any) {
        changeSong(isNext: true)
        reloadDisplay()
    }
    
    @IBAction func abtnPre(_ sender: Any) {
        changeSong(isNext: false)
        reloadDisplay()
        
    }
    @IBAction func abtnRepeat(_ sender: Any) {
        switch playerMode {
        case "repeatOne":
            playerMode = "repeatOne"
            btnMode.setImage(UIImage(named: "repeatOne"), for: .normal)
        case "repeatAll":
            playerMode = "repeatAll"
            btnMode.setImage(UIImage(named: "repeatAll"), for: .normal)
        case "shuffe":
            playerMode = "shuffe"
            btnMode.setImage(UIImage(named: "shuffe"), for: .normal)
            let arrIndex = Array(0..<arrSong.count)
            songArrShuffed = arrIndex.shuffled()
        default:
            break
        }
        if player.rate == 1.0 {
            timer.invalidate()
            player.pause()
            play()
        }else{
            btnPlay.setImage(UIImage(named:"play"), for: .normal)
        }
        secs = lround(CMTimeGetSeconds(playerItem.asset.duration))
        minutes = (Int)(secs/60)
        seconds = (Int)(secs%60)
        lblEndTime.text = (String)(minutes) + ":" +  ((seconds < 10) ? "0" : "") + (String)(seconds)

        secs = lround(CMTimeGetSeconds(playerItem.currentTime()))
        minutes = (Int)(secs/60)
        seconds = (Int)(secs%60)
        lblStartTime.text = (String)(minutes) + ":" +  ((seconds < 10) ? "0" : "") + (String)(seconds)
        
    }

    @IBAction func abtnVolume(_ sender: Any) {
        sldVolume.isHidden = (sldVolume.isHidden == false) ? true : false
    }
    
    @IBAction func abtnSldVolume(_ sender: Any) {
        player.volume = sldVolume.value
        volumeValue = sldVolume.value
        if sldVolume.value == sldVolume.minimumValue {
            btnVolume.setImage(UIImage(named: "volumeOff"), for: UIControlState.normal)
        }else{
            btnVolume.setImage(UIImage(named: "volumeOn"), for: UIControlState.normal)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        sldVolume.isHidden      = true
        txtLyrics.isEditable    = false
        initDisplay()
        if let _:AVPlayer = player{
            //Check if player is playing
            let currentPlayerAsset = player.currentItem?.asset
            var url:String = (currentPlayerAsset as! AVURLAsset).url.absoluteString
            if !url.hasPrefix("http"){
                url = url.replacingOccurrences(of: ".mp3", with: "")
                if url.hasSuffix("/\(songArr[songSelected].streamURL)"){
                    url = songArr[songSelected].streamURL
                }
            }
            if url != songArr[songSelected].streamURL{
                player.pause()
                setSong(songSelected: songSelected)
                player.play()
            }
        }else{
            setSong(songSelected: songSelected)
            
            player.play()
        }
//        NotificationCenter.default.addObserver(self, selector: playerViewController.reloadMainPlayer(_:), name: "reloadMainPlayer", object: nil)
//        NotificationCenter.defaultCenter().removeObserver(subPlayerViewController.self, name: AVPlayerItemDidPlayToEndTimeNotification, object: playerItem)
//        reloadDisplay()
//    }
        lblName.text = songArr[songSelected].title
        lblAuth.text = songArr[songSelected].artist
    }
    
    func reloadMainPlayer(notification: NSNotification){
        reloadDisplay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
}
