//
// ServiceManager.swift
// RocketLaunchDemo
//
// Created on 15.01.2022.
// Oguzhan Yalcin
//
//
//


import UIKit
import Foundation
import Alamofire

class ServiceManager {
    
    static let connected = ServiceManager()
    
    let baseUrl:String = "https://api.spacexdata.com/v3/launches"
    
    typealias tokenHandler = (_ request:URLRequest?, Bool) -> Void
    
    func getRocketLaunches(parameters:String?,_ completion:@escaping ([LaunchResponse]?, Bool) -> () )  {
        
        let errorCode = "1000"
        
        let headers = [ "Content-Type":"application/json",
                        "Accept": "application/json"]
        let httpHeaders = HTTPHeaders(headers)
        
        NAIM.startNetworkOperation()
        AF.request(baseUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: httpHeaders).responseData(completionHandler: { (response) in
            NAIM.stopNetworkOperation()
            guard let data = response.data else {
                completion(nil, false)
                return
            }
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                print("\(String(describing: json))")
                
                let theResponse = try JSONDecoder().decode([LaunchResponse].self, from: data)
                
                guard theResponse.count > 0 else {
                    completion(nil, false)
                    return
                }
                
                completion(theResponse, true)
                
            } catch {
                print("\(errorCode) Decoder Error!")
                completion(nil, false)
            }
        })
    }
    
    func getRocketLaunchesUpcoming(parameters:String?, _ completion:@escaping ([LaunchUpcomingResponse]?, Bool) -> () )  {
        
        let errorCode = "1001"
        
        let headers = [ "Content-Type":"application/json",
                        "Accept": "application/json"]
        let httpHeaders = HTTPHeaders(headers)
        
        let theUrl:String = baseUrl + "/upcoming"
        
        NAIM.startNetworkOperation()
        AF.request(theUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: httpHeaders).responseData(completionHandler: { (response) in
            NAIM.stopNetworkOperation()
            guard let data = response.data else {
                completion(nil, false)
                return
            }
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                print("\(String(describing: json))")
                
                let theResponse = try JSONDecoder().decode([LaunchUpcomingResponse].self, from: data)
                
                guard theResponse.count > 0 else {
                    completion(nil, false)
                    return
                }
                
                completion(theResponse, true)
                
            } catch {
                print("\(errorCode) Decoder Error!")
                completion(nil, false)
            }
        })
    }
}

class NAIM: NSObject {
    
    private static var loadingCount = 0
    
    class func startNetworkOperation() {
        if loadingCount == 0 {
            DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = true }
        }
        loadingCount += 1
    }
    
    class func stopNetworkOperation() {
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
        }
    }
}
