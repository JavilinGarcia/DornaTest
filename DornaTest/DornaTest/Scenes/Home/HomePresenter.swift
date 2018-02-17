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
    
    func getDaysOfPrix(sessions: [GPSession]) -> [String] {
        var days = [String]()
        for sessionModel:GPSession in sessions {
            let dateComponents = sessionModel.start_time?.components(separatedBy: "T")
            let dateSubComponents = dateComponents?.first?.components(separatedBy: "-")
            
            if let day = dateSubComponents?.last {
                if !days.contains(day) {
                    days.append(day)
                }
            }
        }
        days.sort()
        return days
    }
    
    func getModelsForDay(sessions: [GPSession], day: String) -> [HomeDetailModel] {
        var sessionsForDay: [HomeDetailModel] = [HomeDetailModel]()
        
        for sessionModel:GPSession in sessions {
            let startDateComponents = sessionModel.start_time?.components(separatedBy: "T")
            let endDateComponents = sessionModel.end_time?.components(separatedBy: "T")
            
            var startString = ""
            var endString = ""
            
            if let date = startDateComponents?.first {
                let dateComponents = date.components(separatedBy: "-")
                if let sDay = dateComponents.last {
                    if sDay == day {
                        if let startTime = startDateComponents?.last {
                            let timeComponents = startTime.components(separatedBy: ":")
                            startString = "\(timeComponents[0]):\(timeComponents[1])"
                        }
                        
                        if let endTime = endDateComponents?.last {
                            let timeComponents = endTime.components(separatedBy: ":")
                            endString = "\(timeComponents[0]):\(timeComponents[1])"
                        }
                        
                        let detailModel: HomeDetailModel = HomeDetailModel(start_time: startString, end_time: endString, champ_name: sessionModel.champ_name!, name: sessionModel.name!)
                        sessionsForDay.append(detailModel)
                    }
                }
            }
        }
        
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
    
    func reloadData(models: [GrandPrix]) {
        
        listDataSource = [HomeListModel]()
        
        for model:GrandPrix in models {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
            dateFormatter.calendar = Calendar.current
            dateFormatter.locale = Locale.current
            
            let startDate = Date.fromUTCToLocalDate(stringDate: model.date_begin!)
            
            let dBegin = dateFormatter.date(from: model.date_begin!)
            let sBegin = dBegin?.toStringWithFormat(format: "dd:MMM")
            let dayBegin = sBegin?.components(separatedBy: ":").first
            
            let dFinish = dateFormatter.date(from: model.date_finish!)
            let sFinish = dFinish?.toStringWithFormat(format: "dd:MMM")
            let dayFinish = sBegin?.components(separatedBy: ":").first
            
            let month = sBegin?.components(separatedBy: ":").last?.capitalized
            
            
            let dates = Date().generateDatesArrayBetweenTwoDates(startDate: dBegin! , endDate:dFinish!)
            var dateStrArray: [String] = [String]()
            let monthStr = dates.first?.toStringWithFormat(format: "MMM")
            for date in dates {
                dateStrArray.append(date.toStringWithFormat(format: "dd"))
            }
            
            let finalStr = dateStrArray.joined(separator: "/") + " \(monthStr!)"

            let listModel: HomeListModel = HomeListModel(id: model.id!, day_begin: dayFinish!, month_begin: month!, allDays: finalStr, name: model.name!, backgroundImage: model.top_mobile_image!, circuit_flag: model.circuit_flag!)
            print("homelistmodel - \(listModel.name!)")
            listDataSource?.append(listModel)
        }
        
        viewController.reloadData(listModel: listDataSource!)
    }
    
    func reloadDetail(model: GrandPrix) {
        
        let headerModel: HomeListModel = listDataSource![indexSelected!]
        
        detailDataSource = [(key: String, value:[HomeDetailModel])]()
        
        let days: [String] = getDaysOfPrix(sessions: model.sessions!)
        
        var dic: Dictionary = [String: [HomeDetailModel]]()
        
        for i in 0 ..< days.count {
            let day = days[i]
            switch (i) {
            case 0:
                dic["Viernes \(day)"] = getModelsForDay(sessions: model.sessions!, day: day)
                break
            case 1:
                dic["Sabado \(day)"] = getModelsForDay(sessions: model.sessions!, day: day)
                break
            case 2:
                dic["Domingo \(day)"] = getModelsForDay(sessions: model.sessions!, day: day)
                break
            default:
                break
            }
        }

        let array: [(key: String, value:[HomeDetailModel])] = dic.sorted(by: { $0.0 > $1.0 })
        
        detailDataSource = array
       
        detailViewController?.reloadData(headerModel: headerModel, detailModel: detailDataSource!)
    }
    
    //COMMON
    
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
        viewController.showAlertWithTitle(title: title, message: message)
    }
    
}
