//
//  MineViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/19.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class MineViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var dataSource = [["个人信息"],["搜索健身房","心率曲线"],["密码修改","关于APP","意见反馈"]]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headView: UIImageView!
        @IBOutlet weak var headerView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "configure"), style: .plain, target: self, action: #selector(rightButtonAction))
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: M_WIDTH, height: 60)
        tableView.tableHeaderView = view
        tableView.tableFooterView = view
        // Do any additional setup after loading the view.
    }
    func rightButtonAction(){
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var db: FMDatabase?
    override func viewWillAppear(_ animated: Bool) {
        headView.clipsToBounds = true
        headView.layer.cornerRadius = 50
        headerView.image = UIImage.init(named: "icon")
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
            let img = set?.data(forColumn: "img")
            headView.image = UIImage.init(data: img!)
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        let arr = dataSource[indexPath.section]
        cell?.textLabel?.text = arr[indexPath.row]
        return cell!

    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
            print("1")
        }else if indexPath.section == 1 && indexPath.row == 0{
            print("2")
        }else if indexPath.section == 1 && indexPath.row == 1{
            print("3")
        }else if indexPath.section == 2 && indexPath.row == 0{
            print("4")
        }else if indexPath.section == 2 && indexPath.row == 1{
            print("5")
        }else if indexPath.section == 2 && indexPath.row == 2{
            print("6")
        }
        
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
