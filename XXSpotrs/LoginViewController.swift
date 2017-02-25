//
//  LoginViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/20.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func QQLogin(_ sender: Any) {
        self.loginWithPlatform(platform: .QQ)
    }
    @IBAction func weCheatLogiin(_ sender: Any) {
        self.loginWithPlatform(platform: .wechatSession)
    }
    @IBAction func finishBtn(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置页面标题
        self.title  = "登录"
        //导航栏右侧注册按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "注册", style: .plain, target: self, action: #selector(rightButtonAction))
        // Do any additional setup after loading the view.
    }
    //导航栏右侧按钮的点击事件（注册按钮的触发事件）
    func rightButtonAction(){
        self.navigationController?.pushViewController(RegistureViewController(), animated: true)
    }
    //第三方登录
    func loginWithPlatform (platform:UMSocialPlatformType){
        UMSocialManager.default().getUserInfo(with: platform, currentViewController: self) { (result, error) in
            if error == nil{
                let res = result as! UMSocialUserInfoResponse
                print(res.name)
                print(res.gender)
                print(res.iconurl)
                print(res.originalResponse)
            }else{
                //判定登录失败
                print("登录失败")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
