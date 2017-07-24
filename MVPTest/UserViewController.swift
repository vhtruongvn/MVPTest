//
//  ViewController.swift
//  MVPTest
//
//  Created by Truong Vo on 7/24/17.
//  Copyright © 2017 Truong Vo. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    fileprivate let userPresenter = UserPresenter(userService: UserService())
    fileprivate var usersToDisplay = [UserViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userPresenter.attachViewProtocol(viewProtocol: self)
        userPresenter.getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UserViewController: UserViewProtocol {
    
    func startLoading() {
        activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator?.stopAnimating()
    }
    
    func setUsers(users: [UserViewData]) {
        usersToDisplay = users
        tableView?.isHidden = false
        emptyView?.isHidden = true;
        tableView?.reloadData()
    }
    
    func setEmptyUsers() {
        tableView?.isHidden = true
        emptyView?.isHidden = false;
    }
}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "UserCell")
        let userViewData = usersToDisplay[indexPath.row]
        cell.textLabel?.text = userViewData.name
        cell.detailTextLabel?.text = userViewData.age
        return cell
    }
    
}

