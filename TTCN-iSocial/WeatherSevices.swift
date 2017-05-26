//
//  WeatherSevices.swift
//  TTCN-iSocial
//
//  Created by Kai Jendo on 4/1/17.
//  Copyright © 2017 Kai Jendo. All rights reserved.
//

import Foundation


open class WeatherSevices {
    public typealias WeatherDataCompletionBlock = (_ data: WeatherData?) -> ()
    
    let openWeatherBaseAPI = "http://api.openweathermap.org/data/2.5/weather?appid=97cce5b42320d87100a885f5dfa0dac9&units=metric&q="
    let urlSession:URLSession = URLSession.shared
    
    open class func sharedWeatherService() -> WeatherSevices {
        return _sharedWeatherService
    }
    
    open func getCurrentWeather(_ location:String, completion: @escaping WeatherDataCompletionBlock) {
        let openWeatherAPI = openWeatherBaseAPI + location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let request = URLRequest(url: URL(string: openWeatherAPI)!)
        let weatherData = WeatherData()
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {
                if let error = error  {
                    print(error)
                }
                return
            }
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                let jsonWeather = jsonResult?["weather"] as! [AnyObject]
                for jsonCurrentWeather in jsonWeather {
                    weatherData.weather = jsonCurrentWeather["description"] as! String
                    weatherData.image = jsonCurrentWeather["icon"] as! String
                }
                print(weatherData.image)
                let jsonMain = jsonResult?["main"] as! Dictionary<String, AnyObject>
                weatherData.temperature = jsonMain["temp"] as! Int
                weatherData.lowtemperature = jsonMain["temp_min"] as! Int
                weatherData.highttemperature = jsonMain["temp_max"] as! Int
                weatherData.water = jsonMain["humidity"] as! Int
                
                let jsonWind = jsonResult?["wind"] as! Dictionary<String, AnyObject>
                weatherData.windSpeed = jsonWind["speed"] as! Int
                print(weatherData.windSpeed)
                completion(weatherData)
                
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
}

let _sharedWeatherService: WeatherSevices = { WeatherSevices() }()
