//
//  ViewController.swift
//  ToucanNetwork
//
//  Created by bing wang on 21/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let logInBtn = UIButton.init(frame: CGRect.init(x: 10, y: 40, width: 100, height: 44))
        logInBtn.setTitle("LogIn", for: .normal)
        logInBtn.backgroundColor = UIColor.orange
        logInBtn.addTarget(self, action: #selector(performSignIn), for: .touchUpInside)
        self.view.addSubview(logInBtn)
        
        let signUpBtn = UIButton.init(frame: CGRect.init(x: 10, y: 90, width: 100, height: 44))
        signUpBtn.setTitle("SignUp", for: .normal)
        signUpBtn.backgroundColor = UIColor.orange
        signUpBtn.addTarget(self, action: #selector(performSignUp), for: .touchUpInside)
        self.view.addSubview(signUpBtn)
        
        
        let userInfoBtn = UIButton.init(frame: CGRect.init(x: 10, y: 140, width: 100, height: 44))
        userInfoBtn.setTitle("UserInfo", for: .normal)
        userInfoBtn.backgroundColor = UIColor.orange
        userInfoBtn.addTarget(self, action: #selector(performGetUserInfo), for: .touchUpInside)
        self.view.addSubview(userInfoBtn)
        
        
        let updateUserInfoBtn = UIButton.init(frame: CGRect.init(x: 10, y: 190, width: 100, height: 44))
        updateUserInfoBtn.setTitle("updateU", for: .normal)
        updateUserInfoBtn.backgroundColor = UIColor.orange
        updateUserInfoBtn.addTarget(self, action: #selector(performUpdateUserInfo), for: .touchUpInside)
        self.view.addSubview(updateUserInfoBtn)
        
        
        let forgetPassBtn = UIButton.init(frame: CGRect.init(x: 10, y: 240, width: 100, height: 44))
        forgetPassBtn.setTitle("forget", for: .normal)
        forgetPassBtn.backgroundColor = UIColor.orange
        forgetPassBtn.addTarget(self, action: #selector(performForgetpassword), for: .touchUpInside)
        self.view.addSubview(forgetPassBtn)
        
        
        
        let changePassBtn = UIButton.init(frame: CGRect.init(x: 10, y: 290, width: 100, height: 44))
        changePassBtn.setTitle("changepsd", for: .normal)
        changePassBtn.backgroundColor = UIColor.orange
        changePassBtn.addTarget(self, action: #selector(performChangepassword), for: .touchUpInside)
        self.view.addSubview(changePassBtn)
        
        let signoutBtn = UIButton.init(frame: CGRect.init(x: 10, y: 340, width: 100, height: 44))
        signoutBtn.setTitle("signout", for: .normal)
        signoutBtn.backgroundColor = UIColor.orange
        signoutBtn.addTarget(self, action: #selector(performSignout), for: .touchUpInside)
        self.view.addSubview(signoutBtn)
        
        
        let randomBtn = UIButton.init(frame: CGRect.init(x: 10, y: 390, width: 100, height: 44))
        randomBtn.setTitle("Update random", for: .normal)
        randomBtn.backgroundColor = UIColor.orange
        randomBtn.addTarget(self, action: #selector(performUpdateRandom), for: .touchUpInside)
        self.view.addSubview(randomBtn)
        
        let submitTokenBtn = UIButton.init(frame: CGRect.init(x: 10, y: 440, width: 100, height: 44))
        submitTokenBtn.setTitle("SubmitTOKEN", for: .normal)
        submitTokenBtn.backgroundColor = UIColor.orange
        submitTokenBtn.addTarget(self, action: #selector(performSubmitToken), for: .touchUpInside)
        self.view.addSubview(submitTokenBtn)
        
        
        
        let lightListBtn = UIButton.init(frame: CGRect.init(x: 120, y: 40, width: 100, height: 44))
        lightListBtn.setTitle("LightList", for: .normal)
        lightListBtn.backgroundColor = UIColor.orange
        lightListBtn.addTarget(self, action: #selector(performGetLightList), for: .touchUpInside)
        self.view.addSubview(lightListBtn)
    }

    @objc func performSignIn() {
        
        let signInOp = SignInOperation(email: "icewong401@163.com", password: "12345678")
        signInOp.success = { item in
            print("***SignIn******successful********")
            print("random = \(item.random)")
            print("userId = \(item.userId)")
        }
        
        signInOp.failure = { error in
            print("***SignIn******error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(signInOp)
    }
    
    @objc func performSignUp() {
        
        let signUpOp = SignUpOperation(accountname: "455542966@qq.com", password: "123456789", firstname: "zhanhsan", lastname: "lisi")
        signUpOp.success = { item in
            
            print("****signUp successful***\(String(describing: item.statuscode))")
            print("****signUp successful***\(item.responseMessage)")

        }
        
        signUpOp.failure = { error in
            print("****signUp*****error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(signUpOp)
    }
    
    
    @objc func performUpdateUserInfo() {
        let updateProOp = UpdateProfileOperation(firstname: "custom", lastname: "test")
        updateProOp.success = { item in
     
            print("****performUpdateUserInfo***\(String(describing: item.statuscode))")
            print("****performUpdateUserInfo***\(item.responseMessage)")
        }
        
        updateProOp.failure = { error in
            print("***performUpdateUserInfo******error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(updateProOp)
    }
    
    @objc func performForgetpassword() {
        let forgetOp = ForgetPsdOperation(email: "icewong40123@163.com")
        forgetOp.success = { item in
        
            print("****forgetpsdOperation***\(String(describing: item.statuscode))")
            print("****forgetpsdOperation***\(item.responseMessage)")
        }
        
        forgetOp.failure = { error in
            print("****performForgetpassword*****error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(forgetOp)
    }
    @objc func performChangepassword() {
        let changrOp = ChangePsdOperation(newpasswod: "12345678", oldpassword: "123456789")
        changrOp.success = { item in
            
            print("****performChangepassword***\(String(describing: item.statuscode))")
            print("****performChangepassword***\(item.responseMessage)")
        }
        
        changrOp.failure = { error in
            print("****performChangepassword*****error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(changrOp)
    }
    @objc func performGetUserInfo() {
        let signUpOp = ProfileInfoOperation()
        signUpOp.success = { item in
            
             print("****Get userInfo successful.")
            print("****UserInfo email**\(item.accountname).")
            print("****UserInfo firstname**\(item.firstname).")
            print("****UserInfo lastname**\(item.lastname).")
        }
        
        signUpOp.failure = { error in
            print("****Get userInfo*****error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(signUpOp)
    }
    
    @objc func performSignout() {
        let signOutOp = SignOutOperation()
            signOutOp.success = { item in
            
            print("****PerformSignout successful.")
      
        }
        
        signOutOp.failure = { error in
            print("****Get userInfo*****error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(signOutOp)
    }
    
    @objc func performUpdateRandom() {
        let updateRandomOp = UpdateRandomOperation()
        updateRandomOp.success = { item in
            
            print("****performUpdateRandom ***\(String(describing: item.random)).")
            print("****performUpdateRandom successful.")
        }
        
        updateRandomOp.failure = { error in
            print("****Get userInfo*****error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(updateRandomOp)
    }
    
    @objc func performSubmitToken() {
        let submitTokenOp = SubmitTokenOperation(pushTopken: "¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥")
        submitTokenOp.success = { item in
            
            print("****performSubmitToken ***\(String(describing: item.statuscode)).")
            print("****performSubmitToken successful.")
        }
        
        submitTokenOp.failure = { error in
            print("****performSubmitToken*****error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(submitTokenOp)
    }
    @objc func performGetLightList() {
        let getLightListOp = LightListOperation()
        getLightListOp.success = { item in
            
            //print("****performSubmitToken ***\(String(describing: item.statuscode)).")
            print("****performSubmitToken successful.")
        }
        
        getLightListOp.failure = { error in
            print("****performSubmitToken*****error********")
            print(error.localizedDescription)
            print(error.code)
        }
        NetworkQueue.shared.addOperation(getLightListOp)
    }
}

