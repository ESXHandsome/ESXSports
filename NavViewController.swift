//
//  NavViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/5.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class NavViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = HomeViewController()
        let nvc = UINavigationController.init(rootViewController: vc)
        nvc.tabBarItem.image = UIImage.init(named: "retro_tv" )?.withRenderingMode(.alwaysOriginal)

        
       // nvc.tabBarItem.selectedImage = UIImage.init(named: "知识B")?.withRenderingMode(.alwaysOriginal)
        
        nvc.tabBarItem.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        nvc.tabBarItem.title = "知识"
        self.tabBar.isTranslucent = false
//        self.tabBar.backgroundColor = UIColor.purple
        nvc.navigationBar.backgroundColor = UIColor.white
        vc.navigationItem.title = "知识"
        
        let healthViewController = HealthHomeViewController()
        let naHealthViewController = UINavigationController.init(rootViewController: healthViewController)
        healthViewController.navigationItem.title = "健康"
        naHealthViewController.tabBarItem.image = UIImage.init(named: "torso")?.withRenderingMode(.alwaysOriginal)
        //naHealthViewController.tabBarItem.selectedImage = UIImage.init(named: "健康B")?.withRenderingMode(.alwaysOriginal)
        naHealthViewController.tabBarItem.title = "健康"
        naHealthViewController.tabBarItem.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        
        let runRouteViewController = MineViewController()
        let naRunRouteViewController = UINavigationController.init(rootViewController: runRouteViewController)
        runRouteViewController.title = "我的"
        naRunRouteViewController.tabBarItem.image = UIImage.init(named: "administrative_tools")?.withRenderingMode(.alwaysOriginal)
        let zhouBian = ZhouBianViewController()
        let nvZhouBian = UINavigationController.init(rootViewController: zhouBian)
        zhouBian.title = "周边"
        nvZhouBian.tabBarItem.image = UIImage.init(named: "coffee")?.withRenderingMode(.alwaysOriginal)
        //nvZhouBian.tabBarItem.selectedImage = UIImage.init(named: "我的B")?.withRenderingMode(.alwaysOriginal)
        nvZhouBian.tabBarItem.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.viewControllers = [nvc,naHealthViewController,nvZhouBian,naRunRouteViewController]
        self.tabBarController?.selectedIndex = 2
        // Do any additional setup after loading the view.
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
