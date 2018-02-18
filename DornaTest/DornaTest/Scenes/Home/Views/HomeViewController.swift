//
//  HomeViewController.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomeViewController: LibViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var presenter: HomePresenterProtocol!
    var dataSource: [HomeListModel] = [HomeListModel]()
    let refreshControl = UIRefreshControl()

    // MARK: - Private Methods
    
    override func viewDidLoad() {
        presenter.viewIsReady()
        initialize()
    }
    
    func initialize() {
        title = Localize(key: "home_title")        
        setTableView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: String(describing: HomeListTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HomeListTableViewCell.getCellIdentifier())
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        let color = UIColor(hex: kGreenColor, alpha: 1.0)
        refreshControl.tintColor = color
        refreshControl.attributedTitle = NSAttributedString(string: Localize(key: "updating_data"), attributes: [NSAttributedStringKey.foregroundColor:color as Any])

        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    
    @objc func refreshData(_ sender: Any) {
        refreshControl.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(850)) {
            self.presenter.userDidPullToRefresh()
        }
    }
    
}

// MARK: - HomeViewControllerProtocol

extension HomeViewController: HomeViewControllerProtocol {
    
    func reloadData(listModel: [HomeListModel]) {        
        refreshControl.endRefreshing()

        dataSource = listModel
        tableView.reloadData()
        
        UIView.animate(withDuration: 1.5) {
            self.backgroundImageView.alpha = 0
            self.tableView.alpha = 1
            self.nameLabel.textColor = .black
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeListTableViewCell.getHeight()
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: HomeListTableViewCell.getCellIdentifier()) as! HomeListTableViewCell
        let model: HomeListModel = dataSource[indexPath.row] as HomeListModel
        
        cell.gpNameLabel.text = model.name
        cell.gpDayLabel.text = model.day_begin
        cell.gpMonthLabel.text = model.month_begin
        cell.gpFlagImageView.image = model.circuit_flag
        cell.gpBackgroundImage.image = model.backgroundImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidTapRow(indexPath.row)
    }
}
