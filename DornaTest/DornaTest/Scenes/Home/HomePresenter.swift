//
//  HomePresenter.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomePresenter: LibPresenter {
    
    var viewController: HomeViewControllerProtocol!
    var interactor: HomeInteractorProtocol!
    var detailViewController: HomeDetailViewController?

    var listDataSource: [HomeListModel]?
    var detailDataSource: [(key: String, value: [HomeDetailModel])]?
    
    var currentListModel: HomeListModel?
    var indexSelected: Int?
    
    // MARK: - Private Methods
    
    func prepareData(model: GrandPrix) -> [String: [HomeDetailModel]] {
        let subStringBegin = model.date_begin!.components(separatedBy:"T").first
        let beginDate = Date.toDate(str: subStringBegin!)
        
        let subStringFinish = model.date_finish!.components(separatedBy:"T").first
        let finishDate = subStringFinish?.toDate()
        
        let dates = Date.generateDatesArrayBetweenTwoDates(startDate: beginDate!, endDate:finishDate!)
        
        var keys:[String] = [String]()
        for date in dates {
            if let dayKey = date.dayOfWeek() {
                keys.append(dayKey)
            }
        }
        
        var dic: Dictionary = [String: [HomeDetailModel]]()
        if keys.count > 0 {
            for key in keys { // e.g.: VIernes 20
                dic[key] = getModelsForDay(datesOfGP: dates, sessions: model.sessions!, day: key)
            }
        }
        
        return dic
    }
    
    //Return array of HomeDetailModel for a expecific day
    func getModelsForDay(datesOfGP: [Date], sessions: [GPSession], day: String) -> [HomeDetailModel] {
        var sessionsForDay: [HomeDetailModel] = [HomeDetailModel]()
        
        for sessionModel:GPSession in sessions {
            
            var startString = ""
            var endString = ""
            
            let startTime = Date.toDate(str: sessionModel.start_time!, "yyy-MM-dd'T'HH:mm:ssZ")
            let endTime = Date.toDate(str: sessionModel.end_time!, "yyy-MM-dd'T'HH:mm:ssZ")

            if startTime!.dayOfWeek() == day {
                
                startString = startTime!.timeToString()
                endString = endTime!.timeToString()
                
                let detailModel: HomeDetailModel = HomeDetailModel(start_time: startString, end_time: endString, champ_name: sessionModel.champ_name!, name: sessionModel.name!)
                sessionsForDay.append(detailModel)
            }
        }
        
        //Sort sessions
        if sessionsForDay.count > 0 {
            sessionsForDay.sort(by: { (first: HomeDetailModel, second: HomeDetailModel) -> Bool in
                return first.start_time!.compare(second.start_time!) == .orderedAscending
            })
        }
        
        return sessionsForDay
    }
}

extension HomePresenter: HomePresenterProtocol {

    func viewIsReady() {
        if detailViewController == nil {
            (viewController as! UIViewController).navigationController?.setNavigationBarHidden(true, animated: false)
            interactor.viewIsReady()
        }
        else {
            interactor.getDetail()
        }
    }
    
    func userDidTapRow(_ index: Int) {
        indexSelected = index
        interactor.userDidTapRow(index)
    }
    
    // MARK: - Reload data
    
    func reloadData(models: [GrandPrix]) {
        
        listDataSource = [HomeListModel]()
        
        for model:GrandPrix in models {
            
            let subStringBegin = model.date_begin!.components(separatedBy:"T").first
            let beginDate = subStringBegin?.toDate()
            
            let subStringFinish = model.date_finish!.components(separatedBy:"T").first
            let finishDate = subStringFinish?.toDate()
            
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone.init(identifier: "ZZZZ")
            formatter.dateFormat = "dd-MMM"
            formatter.timeZone = TimeZone.autoupdatingCurrent
            
            formatter.dateFormat = "MMM"
            let monthString = formatter.string(from: finishDate!).capitalized
            
            let dates = Date.generateDatesArrayBetweenTwoDates(startDate: beginDate!, endDate:finishDate!)
            var dateStrArray: [String] = [String]()

            for date in dates {
                dateStrArray.append(date.toStringWithFormat(format: "dd"))
            }

            let finalStr = dateStrArray.joined(separator: "/") + " \(monthString)" // -> dd/dd/dd MMM

            let dayToShow = (model.name?.uppercased().contains("TEST"))! ? beginDate?.dayToString() : finishDate?.dayToString()
            
            let listModel: HomeListModel = HomeListModel(id: model.id!, day_begin: dayToShow!, month_begin: monthString, allDays: finalStr, name: model.name!, backgroundImage: model.top_mobile_image!, circuit_flag: model.circuit_flag!)

            listDataSource?.append(listModel)
        }
        
        (viewController as! UIViewController).navigationController?.setNavigationBarHidden(false, animated: false)

        viewController.reloadData(listModel: listDataSource!)
    }
    
    // MARK: - Reload detail data
    
    func reloadDetail(model: GrandPrix) {
        
        let headerModel: HomeListModel = listDataSource![indexSelected!]
        
        detailDataSource = nil
        
        let dic: Dictionary = prepareData(model: model)
        // Sort by day
        detailDataSource = dic.sorted(by: { (first: (key: String, value:[HomeDetailModel]), second: (key: String, value:[HomeDetailModel])) -> Bool in
            return first.key.components(separatedBy: " ").last!.compare(second.key.components(separatedBy: " ").last!) == .orderedAscending
        })
        
        detailViewController?.reloadData(headerModel: headerModel, detailModel: detailDataSource!)
    }
    
    // MARK: - Common
    
    func showLoading(loadingMessage: String) {
        super.showLoading(loadingMessage: loadingMessage, viewController: viewController)
    }
    
    func dismissLoading() {
        super.dismissLoading(viewController: viewController)
    }
    
    func dismissLoadingWithCompletion(animated: Bool?, completion: @escaping () -> ()) {
        super.dismissLoadingWithCompletion(viewController: viewController, completion: completion)
    }
    
    func showError(error: Error) {
        super.showError(error: error, viewController: viewController)
    }
    
    func showAlertWithTitle(title: String, message: String) {
        super.showAlertWithTitle(title: title, message: message, viewController: viewController)
    }
    
}
