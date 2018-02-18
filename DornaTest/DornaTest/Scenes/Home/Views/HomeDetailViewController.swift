//
//  HomeDetailViewController.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright © 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomeDetailViewController: LibViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var prixNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    var headerModel: HomeListModel?
    var tableViewDataSource: [(key: String, value:[HomeDetailModel])]?
    
    // MARK: - Private Methods
    
    override func viewDidLoad() {
        presenter.viewIsReady()
        initialize()
    }
    
    func initialize() {
        setTableView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: String(describing: HomeDetailTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HomeDetailTableViewCell.getCellIdentifier())
        tableView.accessibilityIdentifier = "gpDetailTableViewIdentifier" //For UITests
    }
    
    func reloadHeader() {
        dayLabel.text = headerModel?.day_begin
        monthLabel.text = headerModel?.month_begin
        flagImageView.image = headerModel?.circuit_flag
        prixNameLabel.text = headerModel?.name
        dateLabel.text = headerModel?.allDays
        backgroundImage.image = headerModel?.backgroundImage
    }
}

// MARK: - HomeDetailViewControllerProtocol

extension HomeDetailViewController: HomeDetailViewControllerProtocol {

    func reloadData(headerModel: HomeListModel, detailModel: [(key: String, value:[HomeDetailModel])]) {
        self.headerModel = headerModel
        tableViewDataSource = detailModel
        reloadHeader()
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewDataSource != nil {
            let dic:(key: String, value:[HomeDetailModel]) = tableViewDataSource![section]
            return dic.value.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeDetailTableViewCell.getHeight()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dic:(key: String, value:[HomeDetailModel]) = tableViewDataSource![section]
        return dic.key
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeDetailTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: HomeDetailTableViewCell.getCellIdentifier()) as! HomeDetailTableViewCell
        
        let dic:(key: String, value:[HomeDetailModel]) = tableViewDataSource![indexPath.section]

        let model: HomeDetailModel = dic.value[indexPath.row] as HomeDetailModel

        cell.timeLabel.text = (model.start_time == model.end_time) ? "\(model.start_time!)" : "\(model.start_time!) - \(model.end_time!)" 
        cell.prixLabel.text = model.champ_name
        cell.satatePrixLabel.text = model.name
        
        return cell
    }
    
}
