//
//  helperFiles.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/1/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import UIKit
import SCLAlertView
import CVCalendar
import Alamofire
import AVFoundation
import CVCalendar

//Enum
enum ViewControllerType {
    case login
    case main
}
//variable global

var get                     = request()
var status                  = false
let appearanceWithButton    = SCLAlertView.SCLAppearance()
let appearanceWithoutButton = SCLAlertView.SCLAppearance(showCloseButton: false)
let showWait                = SCLAlertView(appearance: appearanceWithoutButton)
let showSuccess             = SCLAlertView(appearance: appearanceWithButton)
let showError               = SCLAlertView(appearance: appearanceWithoutButton)
var resultFinal     : String!

var arrSchool   = ["DTC","DTE","DTZ","DTF"]
var arrSubject:[Date]    = []
var selectedDay     :DayView!
var currentCalendar : Calendar?
var resultFrom      : String!
var sessionLogin    : String    = ""
var subjectId       :[String]   = []
var subjectDate     :[String]   = []
var subjectPlace    :[String]   = []
var subjectTime     :[String]   = []
let imageCache      = NSCache<AnyObject, AnyObject>()
var requestRow = 10
var name = ""
var id = ""
var myClass = ""
var job = ""
var academicYear = ""
var HeDaoTao = ""
var arrMenuOffline  :[String] = ["Thư viện bài hát","Lịch sử đồng bộ"]
var arrMenuOnline   :[String] = ["Ưa thích","Danh sách phát","Tải lên","Theo dõi"]
var arrtitleMenu    :[String] = ["Nghe nhạc trực tuyến","Nghe nhạc ngoại tuyến"]

var arrSongOnline   : [Song]  = []

var currentDay      : Int = 0
var songSelected    = -1
let calendar = Calendar.current
let date = Date()
let components = calendar.dateComponents([.year, .month, .day], from: date)
var arrQuote:   [String] = [""]
var arrAuth :   [String] = [""]
var songArr:    [Song]   = []
var player:AVPlayer!
var playerItem:AVPlayerItem!
let dateFormatter = DateFormatter()
var isSeach = false
var arrSong:[Song] = []
var songArrOnline:[Song] = []
var songArrOffline:[Song] = []
var arrSongg: [song] = []
var songArrShuffed:[Int] = []
var volumeValue:Float   = 0.5
var _subjectID: [String] = []
var _subjectName: [String] = []
var _subjectNameNews: [String] = []
var _subjectTeacher: [String] = []
var _subjectTeacherNews: [String] = []
var _subjectNews: [String] = []
var playerMode: String = "shuffe"
var secs:Int!
var seconds:Int!
var minutes:Int!
var timer:Timer = Timer()
var arrSubjectDate:[CVDate] = []
var arrimageURL: [String] = []

//var contact = contacts()
//Struct Color
struct Color {
    static let selectedText = UIColor.white
    static let text = UIColor.black
    static let textDisabled = UIColor.gray
    static let currentDay = UIColor.lightText
    static let selectionBackground = UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
    static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
    static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
    static let sundaySelectionBackground = sundayText
}
struct song {
    var nameSong:String
    var url:String
    var desc:String
    var played:Bool
    var descLong:String
    init(nameSong:String, url:String,desc:String, descLong:String) {
        self.nameSong = nameSong
        self.url = url
        self.desc = desc
        self.descLong = descLong
        self.played = false
    }
}

extension UITextField{
    func customTextField(borderWidth:CGFloat, borderColor:UIColor, placeholderText:String, placeholderColor:UIColor, paddingLeft:CGFloat){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSForegroundColorAttributeName: placeholderColor])
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: paddingLeft, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
    }
}

extension UIImageView{
    func loadImageFromUsingCache(urlString: String){
        //Load image online
        if urlString.hasPrefix("http"){
            self.image = nil
            //Check cache for image
            if let downloadedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
                self.image = downloadedImage
                return
            }
            
            //Otherwise fire off a new download
            Alamofire.request(urlString).responseData(completionHandler: { (responseData) in
                if responseData.result.isFailure{
                    return
                }
                if let downloadedImage = UIImage(data: responseData.result.value!){
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }else{
                    self.image = UIImage(named: "defaultUserAvatar")
                    return
                }
            })
            
            //Load image offline
        }else{
            let avatarDownloadedDicretory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/AvatarDownloaded")
            let avatarPath = avatarDownloadedDicretory.appending("/\(urlString)")
            if FileManager.default.fileExists(atPath: avatarPath) {
                self.image = UIImage(contentsOfFile: avatarPath)
            }else{
                self.image = UIImage(named: "defaultSongAvatar")
            }
        }
    }
}

extension String {
    init(htmlEncodedString: String) {
        let encodedData = htmlEncodedString.data(using: String.Encoding.utf8)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType as AnyObject,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8 as AnyObject
        ]
        let attributedString = try! NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
        self.init(attributedString.string)!
    }
}
extension String {
    mutating func replace(_ originalString:String, with newString:String) {
        self = self.replacingOccurrences(of: originalString, with: newString)
    }
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}
extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
struct readFile {
    static var arrayFloatValues:[Float] = []
    static var points:[CGFloat] = []
    
}

extension Array where Element: Equatable {
    func arrayRemovingObject(object: Element) -> [Element] {
        return filter { $0 != object }
    }
}

extension Array where Element: Equatable {
    var orderedSetValue: Array  {
        return reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
    }
}

func isFirstLaunch() -> Bool {
    let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
    let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
    if (isFirstLaunch) {
        UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
        UserDefaults.standard.synchronize()
    }
    return isFirstLaunch
}














