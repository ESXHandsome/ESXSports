//
//  Home2ViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/5.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class Home2ViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
     var url:String?
    override func viewDidLoad() {
        super.viewDidLoad()
    let url1 = URL.init(string: url!)
    let request = NSURLRequest.init(url: url1!)
    webView.loadRequest(request as URLRequest)
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
