//
//  NewUserViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/19.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //添加你所要分享的平台:添加友盟预定义的平台
        UMSocialUIManager.setPreDefinePlatforms([UMSocialPlatformType.QQ,UMSocialPlatformType.qzone,UMSocialPlatformType.wechatSession,UMSocialPlatformType.wechatFavorite,UMSocialPlatformType.wechatTimeLine])
        
        //设置分享面板
        UMSocialShareUIConfig.shareInstance().shareTitleViewConfig.isShow = true
        //设置显示面板的位置，屏幕中央／底端
        UMSocialShareUIConfig.shareInstance().sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType.bottom
        //"是否取消分享"这句话
        UMSocialShareUIConfig.shareInstance().shareCancelControlConfig.isShow = true
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
//            self.shareTextToPlatform(platform:platformType)
            print("调用分享的方法")
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
