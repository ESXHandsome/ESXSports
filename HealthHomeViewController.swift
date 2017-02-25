//
//  HealthHomeViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/9.
//  Copyright © 2016年 李英. All rights reserved.
//




//  Created by Brad Larson on 5/6/2015.
//  Sunset Lake Software LLC.

import UIKit
import HealthKit

class HealthHomeViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var right2Label: UILabel!
    @IBOutlet weak var left2Label: UILabel!
    @IBOutlet weak var right1Label: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var healrtLB: UILabel!
    @IBOutlet weak var right2Image: UIImageView!
    @IBOutlet weak var left2Image: UIImageView!
    @IBOutlet weak var right1Image: UIImageView!
    @IBOutlet weak var left1Image: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var weightLable: UILabel!
    let healthStore = HKHealthStore()
    var healthArray = [String]()
    var heartRote : NSString?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "configure")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(shareButtonAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "runner")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightButtonAction))
        
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        let stepRateType = HKQuantityType.quantityType(forIdentifier: .stepCount)
       
        
        
        if (HKHealthStore.isHealthDataAvailable()){
            var csvString = "Time,Date,Heartrate(BPM)\n"
            self.healthStore.requestAuthorization(toShare: nil, read:[heartRateType], completion:{(success, error) in
                let sortByTime = NSSortDescriptor(key:HKSampleSortIdentifierEndDate, ascending:false)
                let timeFormatter = DateFormatter()
                timeFormatter.dateFormat = "hh:mm:ss"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/YYYY"
                
                let query = HKSampleQuery(sampleType:heartRateType, predicate:nil, limit:600, sortDescriptors:[sortByTime], resultsHandler:{(query, results, error) in
                    guard let results = results else { return }
                    for quantitySample in results {
                        let quantity = (quantitySample as! HKQuantitySample).quantity
                        let heartRateUnit = HKUnit(from: "count/min")
                        
                        //                        csvString.extend("\(quantity.doubleValueForUnit(heartRateUnit)),\(timeFormatter.stringFromDate(quantitySample.startDate)),\(dateFormatter.stringFromDate(quantitySample.startDate))\n")
                        //                        println("\(quantity.doubleValueForUnit(heartRateUnit)),\(timeFormatter.stringFromDate(quantitySample.startDate)),\(dateFormatter.stringFromDate(quantitySample.startDate))")
                        csvString += "\(timeFormatter.string(from: quantitySample.startDate)),\(dateFormatter.string(from: quantitySample.startDate)),\(quantity.doubleValue(for: heartRateUnit))\n"
//                        print("\(timeFormatter.string(from: quantitySample.startDate)),\(dateFormatter.string(from: quantitySample.startDate)),\(quantity.doubleValue(for: heartRateUnit))")
                        let a = "\(quantity.doubleValue(for: heartRateUnit))"
                        self.healthArray.append(a)
                        
                        
                    }
                    DispatchQueue.main.async {
                        
                        if self.healthArray.first != nil{
                            self.healrtLB.text =  self.healthArray.first!
                        }else{
                            self.healrtLB.text = "无"
                            self.right2Label.text = "无"
                            self.left2Label.text = "无"
                            self.right1Label.text = "无"
                        }

                        self.setLabel()
                        
                        
                    }
                   
                    
                    
                    do {
                        let documentsDir = try FileManager.default.url(for: .documentDirectory, in:.userDomainMask, appropriateFor:nil, create:true)
                        try csvString.write(to: URL(string:"heartratedata.csv", relativeTo:documentsDir)!, atomically:true, encoding:String.Encoding.ascii)
                    }
                    catch {
                        print("Error occured")
                    }
                    
                })
                self.healthStore.execute(query)
            })
            
        }
        self.setImage()
     
    }
    
    func shareButtonAction (){
        
        self.navigationController?.pushViewController(StepViewController(), animated: true)
    }
    func shareWebToPlantform(platform:UMSocialPlatformType){
        let web = UMShareWebpageObject()
        web.webpageUrl = "www.baidu.com"
        web.title = "标题标题";
        web.thumbImage = UIImage.init(named: "icon")
        let message = UMSocialMessageObject()
        message.shareObject = web
        UMSocialManager.default().share(to: platform, messageObject: message, currentViewController: self) { (result, error) in
            if error == nil{
                print("分享成功")
            }else{
                print("分享失败")
            }
        }
        
    }
    func rightButtonAction (){
        self.navigationController?.pushViewController(RunRouteViewController(), animated: true)
    }
    func setLabel (){
        if self.healrtLB.text != "无"{
            let a = (self.healrtLB.text! as NSString).doubleValue
            if a<60{
                right2Label.text = "危险"
            }else if a<100{
                right2Label.text = "正常"
            }else if a<180{
                right2Label.text = "运动"
            }else if a>180{
                right2Label.text = "危险"
            }
            if a<120 {
                right1Label.text = "有氧"
                left2Label.text  = "少"
            }else if  120<a&&a<140{
                right1Label.text = "减脂"
                left2Label.text = "多"
            }else if 220>a&&a>140{
                right1Label.text = "无氧"
                left2Label.text = "少"
            }else{
                right1Label.text = "危险"
                left2Label.text = "危险"
            }

            
        }
    }
    
    
    
    func setImage (){
        userImage.image = UIImage.init(named: "健康A")
        userImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(userImageTouchAction))
        userImage.addGestureRecognizer(gesture)
        userImage.clipsToBounds = true
        userImage.layer.borderWidth = 2
        userImage.layer.borderColor = UIColor.red.cgColor
        userImage.layer.cornerRadius = userImage.frame.size.height/4
        
        left1Image.clipsToBounds = true
        left1Image.layer.borderWidth = 2
        left1Image.layer.borderColor = UIColor.red.cgColor
        left1Image.layer.cornerRadius = left1Image.frame.size.width/5
        
        left2Image.clipsToBounds = true
        left2Image.layer.borderWidth = 2
        left2Image.layer.borderColor = UIColor.red.cgColor
        left2Image.layer.cornerRadius = left2Image.frame.size.width/5
        
        right1Image.clipsToBounds = true
        right1Image.layer.borderWidth = 2
        right1Image.layer.borderColor = UIColor.red.cgColor
        right1Image.layer.cornerRadius = left2Image.frame.size.width/5
        
        right2Image.clipsToBounds = true
        right2Image.layer.borderWidth = 2
        right2Image.layer.borderColor = UIColor.red.cgColor
        right2Image.layer.cornerRadius = left2Image.frame.size.width/5
        
        print(healthArray)
        if (self.healthArray.first == nil ){
            self.healrtLB.text = "无"
        }else{ self.healrtLB.text = "\(self.healthArray.first)"
        }
        
        }
    
    
    //userImage触摸事件
    func userImageTouchAction(){
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
        let picVc = UIImagePickerController()
        picVc.sourceType = .photoLibrary
        picVc.allowsEditing = true
        picVc.delegate = self
        present(picVc, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //显示的图片
        let image:UIImage!
        if isEditing {
            //获取编辑后的图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //获取选择的原图
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        
        self.userImage.image = image
        //图片控制器退出
        let updateSQLString = "update users set img = ? where id = 1"
        let data = UIImagePNGRepresentation(image!)
        let b = db?.executeUpdate(updateSQLString, withArgumentsIn: [data!])
        print(b)
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
    var db: FMDatabase?
    override func viewWillAppear(_ animated: Bool) {
        //获得当前应用程序的沙盒目录
        let sandBoxPath = NSHomeDirectory() + "/Documents/a.db"
        print(sandBoxPath)
        
        //创建对象
        db = FMDatabase(path: sandBoxPath)
        //创建数据库
        
        //如果设置的路径下没有数据库文件，open代表创建数据库并打开数据库
        //如果路径下已经存在数据库文件，open代表打开数据库
        let b = db?.open()
        let selectSQLString = "select * from users where id = 1"
        let set = db?.executeQuery(selectSQLString, withArgumentsIn: nil)
        //遍历结果集合
        print("取出\(b)")
        while set!.next() {
            nameLable.text = set?.string(forColumn: "name")
            let weightString = set?.string(forColumn: "weight")
            weightLable.text = weightString! + "KG"
            let ageString = set?.string(forColumn: "age")
            ageLable.text = ageString! + "岁"
            let img = set?.data(forColumn: "img")
            userImage.image = UIImage.init(data: img!)
        }
    }

}

