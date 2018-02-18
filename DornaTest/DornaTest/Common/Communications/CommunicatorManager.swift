//
//  CommunicatorManager.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 13/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import Alamofire

protocol GrandPrixesRequestDelegate {
    func didGetAllGrandPrixesResponse(prixes: [GrandPrix])
    func didGetGrandPrixDetailResponse(gpSessions: [GPSession])
}

class CommunicatorManager {
    
    static let sharedInstance = CommunicatorManager()
    var delegate: GrandPrixesRequestDelegate?

    // MARK: Init
    public init() { self.initComponents()}
    
    // MARK: - Private Methods
    func initComponents() {
    }
    
    // MARK: - Public Methods
    func getAllGrandPrixes(delegate: GrandPrixesRequestDelegate) {
        self.delegate = delegate
        Alamofire.request(BASE_URL).responseJSON(completionHandler: { (response) in
            self.parseResponse(response: response)
        })
    }
    
    func getGrandPrixDetail(id: String, delegate: GrandPrixesRequestDelegate) {
        self.delegate = delegate
        Alamofire.request(BASE_URL+id).responseJSON(completionHandler: { (response) in
            self.parseDetailResponse(currentGpId: id, response: response)
        })
    }
    
    // MARK: - Parse responses
    
    func parseResponse(response: DataResponse<Any>) {
        print("Parse GPs response")
        do{
            if let aResult: NSDictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                print(aResult)
                let eventsArray: [NSDictionary] = aResult.arrayForKey(key: "events") as! [NSDictionary]
                
                var gps: [GrandPrix] = [GrandPrix]()
                
                for dic:NSDictionary in eventsArray {
                    let id = dic.stringForKey(key: "id")
                    let name = dic.stringForKey(key: "name")
                    let date_begin = dic.stringForKey(key: "date_begin")
                    let date_finish = dic.stringForKey(key: "date_finish")
                    let circuit_flag = dic.stringForKey(key: "circuit_flag")
                    let top_mobile_image_url = dic.stringForKey(key: "top_mobile_image_url")
                    
                    let dataFlag:Data?
                    let dataTop:Data?
                    
                    if let urlFlag = URL(string: circuit_flag) {
                        dataFlag = try? Data(contentsOf: urlFlag)
                    }
                    else {
                        let image:UIImage = UIImage(named: "defaultFlag")!
                        dataFlag = UIImagePNGRepresentation(image)
                    }
                    
                    if let urlTop = URL(string: top_mobile_image_url) {
                        dataTop = try? Data(contentsOf: urlTop)
                    }
                    else {
                        let image:UIImage = UIImage(named: "defaultCellBackground")!
                        dataTop = UIImageJPEGRepresentation(image, 1)
                    }
                    
                    let gp = GrandPrix.init(withImageData: id, name: name, date_begin: date_begin, date_finish: date_finish, top_mobile_image_data: dataTop!, circuit_flag_data: dataFlag!)
                    
                    gps.append(gp)
                }
                
                delegate?.didGetAllGrandPrixesResponse(prixes: gps)
            }
        } catch let error as NSError  {
            print(error)
        }
    }
    
    func parseDetailResponse(currentGpId: String, response: DataResponse<Any>) {
        print("Parse detail response")
        do{
            if let aResult: NSDictionary = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                
                let sessionsDic: NSDictionary = aResult.dictionaryForKey(key: "sessions")!
                let sessionsArray: [NSDictionary] = sessionsDic.arrayForKey(key: "data") as! [NSDictionary]
                
                var sessions: [GPSession] = [GPSession]()
                
                for session: NSDictionary in sessionsArray {
                    let id = session.stringForKey(key: "id")
                    let name = session.stringForKey(key: "shortname")
                    let champ_name = session.stringForKey(key: "champ_name")
                    let start_time = session.stringForKey(key: "start_time")
                    let end_time = session.stringForKey(key: "end_time")
                    
                    let gpSession = GPSession.init(gpID: currentGpId, sessionID: id, start_time: start_time, end_time: end_time, champ_name: champ_name, name: name)
                    
                    sessions.append(gpSession)
                }
                
                delegate?.didGetGrandPrixDetailResponse(gpSessions: sessions)
            }
        } catch let error as NSError  {
            print(error)
        }
    }
}
