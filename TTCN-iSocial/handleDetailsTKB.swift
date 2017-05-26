//
//  handleDetailsTKB.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 3/25/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation
import UIKit

extension detailsTKBViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subject.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsView", for: indexPath) as! customDetailsTKBTableViewCell
        cell.lblSubjectTime.text = subjectTime[indexPath.row]
        cell.lblSubjectClass.text = subjectLocation[indexPath.row]
        cell.lblTeacher.text = subjectTeacher[indexPath.row]
        cell.lblSubjectName.text = subjectName[indexPath.row]
        return cell
    }
}

extension detailsTKBViewController {
    
    func handleSubject() {
        for i in 0..<subject.count {
            for j in 0..<_subjectNews.count {
                if subject[i] == _subjectNews[j] {
                    subjectTeacher.append(_subjectTeacherNews[j])
                    subjectName.append(_subjectNameNews[j])
                }
            }
        }
        if subjectName.count != 0 {
            lblNotification.isHidden = true
        } else {
            lblNotification.isHidden = false
        }
    }
    
    func displayCurrentWeather() {
        imgLocation.text = city
        WeatherSevices.sharedWeatherService().getCurrentWeather(city + "," + "VietNam", completion: { (data) -> () in
            OperationQueue.main.addOperation({ () -> Void in
                if let weatherData = data {
                    self.lblStatus.text = weatherData.weather.capitalized
                    self.lblCesius.text = String(format: "%d", weatherData.temperature) + "\u{00B0}"
                    self.lblLowTemp.text = "\(weatherData.lowtemperature)"
                    self.lblHightTemp.text = "\(weatherData.highttemperature)"
                    let imgURL = URL(string:"http://openweathermap.org/img/w/\(weatherData.image).png")
                    if imgURL != nil {
                        let request = URLRequest(url: imgURL!)
                        let task = URLSession.shared.dataTask(with: request) {data, response, error in
                            if (response as? HTTPURLResponse) != nil {
                                self.self.imgStatus.image = UIImage(named: "logo.png")
                            }
                            self.imgStatus.image = UIImage(data: data! as Data)
                        }
                        task.resume()
                    }
                }
            })
        })
    }
}




