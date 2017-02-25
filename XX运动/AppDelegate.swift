//
//  AppDelegate.swift
//  XX运动
//
//  Created by Ying on 2016/12/5.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //打开调试日志
        UMSocialManager.default().openLog(true)
        //初始化友盟,Appkey是在友盟创建应用所得到的AppKey
        UMSocialManager.default().umSocialAppkey = "57b432afe0f55a9832001a0a"
        //微信聊天
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")
        //微信朋友圈
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatTimeLine, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")
        //微信收藏
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatFavorite, appKey: "wxdc1e388c3822c80b", appSecret: "3baf1193c85774b3fd9d18447d76cab0", redirectURL: "http://mobile.umeng.com/social")
        //QQ
        UMSocialManager.default().setPlaform(.QQ, appKey: "100424468", appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
        //QQ空间
        UMSocialManager.default().setPlaform(UMSocialPlatformType.qzone, appKey: "100424468", appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
        //微博
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: "3921700954", appSecret: "04b48b094faeb16683c32669824ebdad", redirectURL: "http://sns.whalecloud.com/sina2/callback")
            //MARK:
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white
        let  vc = NavViewController()
        let  vc2 = InformationViewController()
        
        
        var db: FMDatabase?
        let path = NSHomeDirectory() + "/Documents/a.db"
        db = FMDatabase(path: path)
        db?.open()
        let selectSQL = "select * from users"
        let set = db?.executeQuery(selectSQL, withArgumentsIn: nil)
        
        if set == nil {
            window?.rootViewController = vc2
        }else{
            window?.rootViewController = vc
        }
//        window?.rootViewController = MineViewController()
        
        window?.makeKeyAndVisible()
        return true
    }
    
    //回调设置
    //只支持iOS 9.0以上的系统
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result{
            
        }
        return result
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        if !result{
            
        }
        return result
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

