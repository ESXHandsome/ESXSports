//
//  HomeViewController.swift
//  XX运动
//
//  Created by Ying on 2016/12/5.
//  Copyright © 2016年 李英. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    var dataSource = NSMutableArray()
    let tableView = UITableView()
    var tmpUrl = ""
    var currentPage = 110

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRequest("http://wp.wrok.cn/get_post_from_category_id?category_id=%d", cnt: currentPage)
        MakeList()
        self.addFreshing()
        self.addLoading()

    }
    
    func loadRequest(_ urlString: String, cnt:Int) {
        tmpUrl = urlString
//        print(urlString)
        
        let session = URLSession.shared
        //拼接接口
        let st = NSString(format: urlString as NSString, cnt)
        let url = URL(string: st as String)
        let task = session.dataTask(with: url!, completionHandler: { (data, resp , error) in
            if error == nil {
            let dict = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            let arr = (dict as AnyObject).object(forKey: "list") as! NSArray
            let dic = arr[0] as! NSDictionary
            let array = dic.object(forKey: "list") as! NSArray
                
            //遍历数组，数组中的每个元素应该对应一行
//            print(array.count)
            for i in array {
//                print(i)
                
                let model = listModel()
                
                
                model.setValuesForKeys(i as! [String : AnyObject])
                
                //将模型添加到数组
                self.dataSource.add(model)
                
                
            }
            
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
            })
            }
        })
        task.resume()
    }
    //下拉刷新
    func addFreshing() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            //编写下拉刷新的功能
//            print("调用刷新的接口，重新加载网络数据")
            
            
            //下边这句话实际上应该写在loadRequest方法中，我之所以在这写，是为了模拟下拉刷新能够停下来的动作
            self.tableView.mj_header.endRefreshing()
            
        })
    }
    
    
    
    //上拉加载
    func addLoading() {
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            //上拉加载时，你想完成什么功能
            self.currentPage += 1
            self.loadRequest(self.tmpUrl, cnt: self.currentPage)
            
            
        })
        
    }

    
    
    
    func MakeList(){
        
        tableView.frame = CGRect(x: 0, y: 0, width:M_WIDTH , height: M_HEIGHT)
        tableView.backgroundColor = UIColor.white
        
        tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HomeTableViewCell
        let model =  dataSource[indexPath.row] as! listModel
//        print(model.thumb)

        let url = URL.init(string: "\(model.thumb!)")
        cell.img.sd_setImage(with: url)
//        cell.title.text = model.catename
        cell.subtitle.text = model.subcatename
        cell.dateLb.text = model.edittime
        
        
        return cell

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(dataSource.count)
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return M_HEIGHT/3
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = Home2ViewController()
        let model = dataSource[indexPath.row] as! listModel
        let st = "http://wp.wrok.cn/?p=\(model.ID!)"
        print(st)
        
        self.navigationController?.pushViewController(vc, animated: true)
        vc.url=st
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
