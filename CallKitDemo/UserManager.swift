//
//  UserManager.swift
//  CallKitDemo
//
//  Created by Larry on 2022/10/27.
//

import UIKit

class UserManager: NSObject {
    
    public static let shared = UserManager()
    
    var hasLogin = false
    var userList: [UserInfo] = []
    var loginUser: UserInfo?
    
    override init() {
        super.init()
        readUserListJson()
    }
    
    public func randomUser() -> UserInfo {
        let index = Int.random(in: 0..<userList.count)
        return userList[index]
    }
    
    public func getUserList() -> [UserInfo] {
        return userList.filter { userInfo in
            userInfo.userID != loginUser?.userID
        }
    }
    
    private func readUserListJson() {
        guard let path = Bundle.main.path(forResource: "userList", ofType: "json") else { return }
        let localData = NSData.init(contentsOfFile: path)! as Data
        do {
            let users = try JSONDecoder().decode(UserList.self, from: localData)
            if let userList = users.userList {
                self.userList = userList
            }
        } catch {
            debugPrint("===ERROR")
        }
    }
}

class UserList: Codable {
    var userList: [UserInfo]?
}

class UserInfo: Codable {
    var userName: String = ""
    var userID: String = ""
}


