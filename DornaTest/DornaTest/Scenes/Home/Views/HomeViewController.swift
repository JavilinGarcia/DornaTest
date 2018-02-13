//
//  HomeViewController.swift
//  DornaTest
//
//  Created by Javier Garcia Castro on 12/2/18.
//  Copyright (c) 2018 Javier Garcia Castro. All rights reserved.
//

import UIKit

class HomeViewController: LibViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    var dataSource: [HomeListModel]?
    
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
    }
}

// MARK: - HomeViewControllerProtocol

extension HomeViewController: HomeViewControllerProtocol {
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return HomeListTableViewCell.getHeight()
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: HomeListTableViewCell.getCellIdentifier()) as! HomeListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.userDidTapRow(indexPath.row)
    }
}
