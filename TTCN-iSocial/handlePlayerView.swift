//
//  handlePlayerView.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/18/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Alamofire
import MediaPlayer
import Accelerate

extension playerViewController {
    func draw(_ rect: CGRect) {
        self.convertToPoints()
        var f = 0
        let aPath = UIBezierPath()
        let aPath2 = UIBezierPath()
        aPath.lineWidth = 2.0
        aPath2.lineWidth = 2.0
        aPath.move(to: CGPoint(x:0.0 , y:rect.height/2 ))
        aPath2.move(to: CGPoint(x:0.0 , y:rect.height ))
        // print(readFile.points)
        for _ in readFile.points{
            //separation of points
            var x:CGFloat = 2.5
            aPath.move(to: CGPoint(x:aPath.currentPoint.x + x , y:aPath.currentPoint.y ))
            //Y is the amplitude
            aPath.addLine(to: CGPoint(x:aPath.currentPoint.x  , y:aPath.currentPoint.y - (readFile.points[f] * 70) - 1.0))
            aPath.close()
            //print(aPath.currentPoint.x)
            x += 1
            f += 1
        }
        //If you want to stroke it with a Orange color
        UIColor.init(red: 197, green: 124, blue: 172, alpha: 1).set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
        f = 0
        aPath2.move(to: CGPoint(x:0.0 , y:rect.height/2 ))
        
        //Reflection of waveform
        for _ in readFile.points{
            var x:CGFloat = 2.5
            aPath2.move(to: CGPoint(x:aPath2.currentPoint.x + x , y:aPath2.currentPoint.y ))
            
            //Y is the amplitude
            aPath2.addLine(to: CGPoint(x:aPath2.currentPoint.x  , y:aPath2.currentPoint.y - ((-1.0 * readFile.points[f]) * 50)))
            
            // aPath.close()
            aPath2.close()
            
            //print(aPath.currentPoint.x)
            x += 1
            f += 1
        }
        
        //If you want to stroke it with a Orange color with alpha2
        UIColor.orange.set()
        aPath2.stroke(with: CGBlendMode.normal, alpha: 0.5)
        //   aPath.stroke()
        
        //If you want to fill it as well
        aPath2.fill()
    }
    
    
    
    
    func readArray( array:[Float]){
        readFile.arrayFloatValues = array
    }
    
    func convertToPoints() {
        var processingBuffer = [Float](repeating: 0.0,
                                       count: Int(readFile.arrayFloatValues.count))
        let sampleCount = vDSP_Length(readFile.arrayFloatValues.count)
        //print(sampleCount)
        vDSP_vabs(readFile.arrayFloatValues, 1, &processingBuffer, 1, sampleCount);
        // print(processingBuffer)
        var multiplier = 1.0
        print(multiplier)
        if multiplier < 1{
            multiplier = 1.0
        }

        let samplesPerPixel = Int(150 * multiplier)
        let filter = [Float](repeating: 1.0 / Float(samplesPerPixel),
                             count: Int(samplesPerPixel))
        let downSampledLength = Int(readFile.arrayFloatValues.count / samplesPerPixel)
        var downSampledData = [Float](repeating:0.0,
                                      count:downSampledLength)
        vDSP_desamp(processingBuffer,
                    vDSP_Stride(samplesPerPixel),
                    filter, &downSampledData,
                    vDSP_Length(downSampledLength),
                    vDSP_Length(samplesPerPixel))
        readFile.points = downSampledData.map{CGFloat($0)}
        
        
    }


    func setSong(songSelected:Int){
        var url = NSURL(string: songArr[songSelected].streamURL)
        if !(songArr[songSelected].streamURL.hasPrefix("http")){
            let songDownloadedDicretory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appending("/SongDownloaded")
            let path = Bundle.path(forResource: songArr[songSelected].streamURL, ofType: "mp3", inDirectory: songDownloadedDicretory)
            url = NSURL(fileURLWithPath: path!)
        }
        do{
            playerItem = AVPlayerItem(url: url! as URL)
            player = AVPlayer(playerItem: playerItem)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch{
            print("Không thể phát bài hát")
        }
        player.volume = volumeValue
    }
    
    func changeSong(isNext:Bool){
        if playerMode == "shuffe"{
            for i in 0..<songArrShuffed.count{
                if songArrShuffed[i] == songSelected{
                    if isNext == true {
                        if i + 1 == songArrShuffed.count{
                            songSelected = songArrShuffed[0]
                        }else{
                            songSelected = songArrShuffed[i+1]
                        }
                    }else{
                        if i == 0{
                            songSelected = songArrShuffed[songArrShuffed.count - 1]
                        }else{
                            songSelected = songArrShuffed[i-1]
                        }
                    }
                    break
                }
            }
        }else{
            if playerItem.currentTime().timescale != playerItem.asset.duration.timescale || playerMode != "repeatOne"{
                if isNext == true {
                    if songSelected == songArr.count - 1{
                        songSelected = 0
                    }else{
                        songSelected += 1
                    }
                }else{
                    if songSelected == 0 {
                        songSelected = songArr.count - 1
                    }else{
                        songSelected -= 1
                    }
                }
            }
        }
        player.pause()
        setSong(songSelected: songSelected)
        player.play()
    }
    func updateSlider(){
        sldTime.value += 0.1
        secs = lround(CMTimeGetSeconds(playerItem.currentTime()))
        minutes = (Int)(secs/60)
        seconds = (Int)(secs%60)
        lblStartTime.text = (String)(minutes) + ":" +  ((seconds < 10) ? "0" : "") + (String)(seconds)
    }
    func initDisplay(){
        sldTime.setThumbImage(UIImage(named: "thumbTint"), for: .normal)
        sldVolume.setThumbImage(UIImage(named: "thumbTint"), for: .normal)
        sldVolume.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
        sldVolume.minimumValue = 0
        sldVolume.maximumValue = 1
        sldTime.minimumValue = 0
    }

    //--------------------------------------Support function--------------------------------------
    func play(){
        imgTitle.layer.removeAllAnimations()
        //rotateSpinningView()

        btnPlay.setImage(UIImage(named:"pause"), for: .normal)
        player.play()
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyArtist : songArr[songSelected].artist,  MPMediaItemPropertyTitle : songArr[songSelected].title, MPMediaItemPropertyPlaybackDuration : Float(CMTimeGetSeconds(playerItem.asset.duration)), MPNowPlayingInfoPropertyElapsedPlaybackTime : CMTimeGetSeconds(player.currentTime()), MPMediaItemPropertyRating : 1]
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(playerViewController.updateSlider), userInfo: nil, repeats: true)
    }
    
    func pause(){
        imgTitle
            .layer.removeAllAnimations()
        timer.invalidate()
        btnPlay.setImage(UIImage(named:"play"), for: .normal)
        player.pause()
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyArtist : songArr[songSelected].artist,  MPMediaItemPropertyTitle : songArr[songSelected].title, MPMediaItemPropertyPlaybackDuration : Float(CMTimeGetSeconds(playerItem.asset.duration)), MPNowPlayingInfoPropertyElapsedPlaybackTime : CMTimeGetSeconds(player.currentTime()), MPMediaItemPropertyRating : 0]
    }
    
    func reloadDisplay(){
        //Refresh objects in Scroll View
      // tableView.reloadData()
//        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
//        pageControl.currentPage = Int(pageNumber)
        imgTitle.loadImageFromUsingCache(urlString: arrSong[songSelected].avatarURL)
        //Lyrics Textview
        if songArr[songSelected].lyricsURL != ""{
            if songArr[songSelected].lyricsURL.hasPrefix("http"){
                let url = NSURL(string: songArr[songSelected].lyricsURL)
                do{
                    let lyrics = try String(contentsOf:url! as URL)
                    
                    let decodedString = String(htmlEncodedString: lyrics)
                    txtLyrics.text = decodedString
                }catch{
                    txtLyrics.text = "Chưa có lời bài hát cho bản nhạc này"
                }
            }else{
                txtLyrics.text = songArr[songSelected].lyricsURL
            }
        }else{
            txtLyrics.text = "Chưa có lời bài hát cho bản nhạc này"
        }
        txtLyrics.scrollRangeToVisible(NSMakeRange(0, 0))
        
        if sldVolume.value == sldVolume.minimumValue {
            btnVolume.setImage(UIImage(named: "volumeOff"), for: UIControlState.normal)
        }
        //Title Label & Artist Label
        lblName.text = songArr[songSelected].title
        lblAuth.text = songArr[songSelected].artist
        
    }
}
