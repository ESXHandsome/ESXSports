//
//  RegistureViewController.swift
//  XX运动
//
//  Created by Ying on 2017/2/25.
//  Copyright © 2017年 李英. All rights reserved.
//

import UIKit

class RegistureViewController: UIViewController {
    @IBOutlet weak var telephoneNumber: UITextField!
    @IBOutlet weak var identify: UITextField!
    @IBOutlet weak var photoNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置页面标题
        self.title = "注册"
        

        // Do any additional setup after loading the view.
    }
 
    @IBAction func `continue`(_ sender: Any) {
        self.navigationController?.pushViewController(NewUserViewController(), animated: true)
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
