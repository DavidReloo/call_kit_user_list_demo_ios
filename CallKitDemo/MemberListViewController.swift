//
//  MemberListViewController.swift
//  CallKitDemo
//
//  Created by Larry on 2022/10/27.
//

import UIKit

class MemberListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var userList = UserManager.shared.getUserList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = UserManager.shared.loginUser?.userName ?? ""
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UserInfoCell.self, forCellReuseIdentifier: "UserInfoCell")
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell") as! UserInfoCell
        let userInfo = userList[indexPath.row]
        cell.updateCell(user: userInfo)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
}
