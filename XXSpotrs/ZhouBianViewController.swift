//
//  ZhouBianViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/16.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class ZhouBianViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!

     var dataSource = NSMutableArray()
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "ZhouBianTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        super.viewDidLoad()
               let xmlPath = Bundle.main.path(forResource: "zhoubian", ofType: "json")
        let data = try? Data.init(contentsOf: URL(fileURLWithPath: xmlPath!))
        let ison = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        
        let arr = (ison as AnyObject).object(forKey: "list") as! NSArray
        let dic = arr[0] as! NSDictionary
        let array = dic.object(forKey: "list") as! NSArray
        //遍历数组，数组中的每个元素应该对应一行
        //            print(array.count)
        for i in array {
//            print(i)
            
            let model = listModel()
            
            
            model.setValuesForKeys(i as! [String : AnyObject])
            
            //将模型添加到数组
            self.dataSource.add(model)
            
        }
        
        
        
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ZhouBianTableViewCell
        let  model = dataSource[indexPath.row] as! listModel
        let url = URL.init(string: model.thumb_2!)
//        print(url)
        cell.ZBImage.sd_setImage(with: url!)
        cell.ZBTitileLable.text = model.title
        cell.ZBPriceLable.text = model.jianjie
        return cell

        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return   M_HEIGHT/5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = TBViewController()
        let model = dataSource[indexPath.row] as! listModel
        let url = model.thumb!
        
        print(url)
        self.navigationController?.pushViewController(controller, animated: true)
        controller.urlString = url
        
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
