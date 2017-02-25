//
//  StepViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/21.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit
import CoreMotion
class StepViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let lengthFormatter = LengthFormatter()
        let pedometer = CMPedometer()
        pedometer.startUpdates(from: Date()) { (data, error) in
            if error == nil{
                let distance = data?.distance?.doubleValue
                print(data?.numberOfSteps)
                print(data?.distance)
                let time = data?.endDate.timeIntervalSince((data?.startDate)!)
                let speed = distance! / time!
                print(speed)
            }else{
                print("计步器不可用")
            }
        }
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
