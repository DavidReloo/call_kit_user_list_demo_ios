//
//  ViewController.swift
//  CallKitDemo
//
//  Created by Larry on 2022/10/27.
//

import UIKit
import ZegoUIKitSDK
import ZegoUIKitSignalingPlugin
import ZegoUIKitPrebuiltCall

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userIDLabel: UILabel!
    
    var userInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userInfo = UserManager.shared.randomUser()
        userNameLabel.text = userInfo?.userName
        userIDLabel.text = userInfo?.userID
    }

    @IBAction func pressRandomButton(_ sender: UIButton) {
        userInfo = UserManager.shared.randomUser()
        userNameLabel.text = userInfo?.userName
        userIDLabel.text = userInfo?.userID
    }
    
    @IBAction func pressLoginButton(_ sender: UIButton) {
        UserManager.shared.loginUser = userInfo
        
        /// After successful login
        registerUserInfo()
        
        presentUserListVC()
    }
    
    public func registerUserInfo() {
        let appID: UInt32 = <#Your App ID#>
        let appSign = <#Your App Sign#>
        let userID = UserManager.shared.loginUser?.userID ?? ""
        let userName = UserManager.shared.loginUser?.userName ?? ""
        
        let config = ZegoUIKitPrebuiltCallInvitationConfig([ZegoUIKitSignalingPlugin()])
        ZegoUIKitPrebuiltCallInvitationService.shared.initWithAppID(appID, appSign: appSign, userID: userID, userName: userName, config: config)
        ZegoUIKitPrebuiltCallInvitationService.shared.delegate = self
    }
    
    private func presentUserListVC() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MemberListViewController") as? MemberListViewController
        if let vc = vc {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}

extension ViewController: ZegoUIKitPrebuiltCallInvitationServiceDelegate {
    //MARK: -ZegoUIKitPrebuiltCallInvitationServiceDelegate
    func requireConfig(_ data: ZegoCallInvitationData) -> ZegoUIKitPrebuiltCallConfig {
        let config = ZegoUIKitPrebuiltCallConfig(.oneOnOneVideoCall)
        return config
    }
}
