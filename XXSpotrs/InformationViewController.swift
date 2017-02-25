//
//  InformationViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/14.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var finishbutton: UIButton!
    @IBAction func finishButton(_ sender: Any) {
        
        let insertSQLString = "insert into users (name, age, weight,img) values (?,?,?,?)"
        let data = UIImagePNGRepresentation(self.headerImage.image!)
        let b = db?.executeUpdate(insertSQLString, withArgumentsIn: [nameLabel.text!,ageLabel.text!,weightLabel.text!,data!])
        print("写入\(b)")
        dismiss(animated: true, completion: nil)
        self.present(NavViewController(), animated: true, completion: nil)
    }
    @IBOutlet weak var weightLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    var mutArr: NSMutableArray = NSMutableArray()
    var db: FMDatabase?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishbutton.layer.borderWidth=5
        finishbutton.layer.cornerRadius = 16
        finishbutton.layer.borderColor = UIColor.red.cgColor
        fetchAll()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //创建相册
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.present(imagePicker, animated: true , completion: nil)
        
        
    }
    
    //当点击相册中取消按钮时，调用该方法
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancel")
    }
    
    //当选中相册中的图片时，调用该方法
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.headerImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismiss(animated: true , completion: nil)
    }
    

    func fetchAll() {
        
        mutArr.removeAllObjects()
        print(NSHomeDirectory())
        let path = NSHomeDirectory().appendingFormat("/Documents/a.db")
        db = FMDatabase(path: path)
        db?.open()
        let tableSQLString = "create table if not exists users (id integer primary key autoincrement, name varchar(256), age varchar(256), weight varchar(256), img blob)"
        
        //executeUpdate 执行
        let b = db?.executeUpdate(tableSQLString, withArgumentsIn: nil)
        print(b)
        let selectSQL = "select * from users"
        let set = db?.executeQuery(selectSQL, withArgumentsIn: nil)
        while set!.next() {
            let name = set?.string(forColumn: "name")
            let age = set?.string(forColumn: "age")
            
            let weight = set?.string(forColumn: "weight")
            
            let model = UserModel()
            model.age = age
            model.name = name
            model.weight = weight
            
            //将模型添加到数组
            mutArr.add(model)
            
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
