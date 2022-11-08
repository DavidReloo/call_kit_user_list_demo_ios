//
//  UserInfoCell.swift
//  CallKitDemo
//
//  Created by Larry on 2022/10/27.
//

import UIKit
import ZegoUIKitSDK
import ZegoUIKitSignalingPlugin
import ZegoUIKitPrebuiltCall

let CellHeight: CGFloat = 80.0

class UserInfoCell: UITableViewCell {

    let nameLabel = UILabel()
    let userIDLabel = UILabel()
    
    var callButton = ZegoStartCallInvitationButton(.videoCall)
    var userInfo: UserInfo?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
        public func updateCell(user: UserInfo) {
            userInfo = user
            
            nameLabel.text = "Name: " + user.userName
            userIDLabel.text = "ID: " + user.userID
            
            let zegoUser: ZegoUIkitUser = ZegoUIkitUser(user.userID, user.userName)
            callButton.inviteeList = [zegoUser]
        }
    
    private func configUI() {
        let cellWidth = UIScreen.main.bounds.width
        self.selectionStyle = .none
        
        self.contentView.addSubview(callButton)
        callButton.frame = CGRect(x: cellWidth - 80, y: (CellHeight - 40) / 2 , width: 40, height: 40)
        
        self.contentView.addSubview(nameLabel)
        nameLabel.frame = CGRect(x: 40, y: (CellHeight - 70) / 2, width: 200, height: 30)
        
        self.contentView.addSubview(userIDLabel)
        userIDLabel.frame = CGRect(x: 40, y: (CellHeight - 70) / 2 + 40, width: 200, height: 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
