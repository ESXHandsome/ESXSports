//
//  TBViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/19.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class TBViewController: UIViewController {
    var urlString : String?
    @IBOutlet weak var TBWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(urlString)
        let url = URL.init(string: urlString!)
        let requset = URLRequest.init(url: url!)
        TBWebView.loadRequest(requset)

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
