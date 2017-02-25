//
//  BaseRequest.swift
//  SwiftPokitchen
//
//  Created by qianfeng on 2016/12/1.
//  Copyright © 2016年 贾文鹏. All rights reserved.
//

import UIKit
    class BaseRequest{
        
        //设置类方法(网络请求)
        class func getWithURL(url:String!,para:NSDictionary!,callBack:@escaping (_ data:NSData?,_ error:NSError)->Void)->Void{
        let session = URLSession.shared
        let urlStr = NSMutableString(string: url)
            if para != nil {
                urlStr.append(self.encodeUniCode(string: self.parasToString(para: para!) as NSString) as String)
                
            }
        let request = NSMutableURLRequest.init(url: URL(string: urlStr as String)!)
        request.httpMethod = "GET"
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                //            let res:NSHTTPURLResponse = response as! NSHTTPURLResponse
                if data != nil
                {
                    callBack(data as NSData?,error! as NSError)
                }else
                {
                    callBack(nil,error as! NSError)
                }
            }
            //启动请求任务
            dataTask .resume()
        }
        
        //设置类方法(网络请求)
        class func PostWithURL(url:String!,para:NSDictionary!,callBack:@escaping (_ data:NSData?,_ error:NSError)->Void)->Void{
            let session = URLSession.shared
            let urlStr = NSMutableString(string: url)
            if para != nil {
                urlStr.append(self.encodeUniCode(string: self.parasToString(para: para!) as NSString) as String)
                
            }
            let request = NSMutableURLRequest.init(url: URL(string: urlStr as String)!)
            request.httpMethod = "POST"
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                //            let res:NSHTTPURLResponse = response as! NSHTTPURLResponse
                if data != nil
                {
                    callBack(data as NSData?,error! as NSError)
                }else
                {
                    callBack(nil,error as! NSError)
                }
            }
            //启动请求任务
            dataTask .resume()
        }

 
        class func parasToString(para:NSDictionary?)->String
        {
            let paraStr = NSMutableString.init(string: "?")
            for (key,value) in para as! [String :String]
            {
                paraStr.appendFormat("%@=%@&", key,value)
            }
            if paraStr.hasSuffix("&"){
                paraStr.deleteCharacters(in: NSMakeRange(paraStr.length - 1, 1))
            }
            //将URL中的特殊字符进行转吗
            //        paraStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
            //移除转码
            //        paraStr.stringByRemovingPercentEncoding
            return String(paraStr)
        }

        
        //字符串转码函数(中文--UIcoide码)
        class func encodeUniCode(string:NSString)->NSString
        {
            return string.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlFragmentAllowed)! as NSString
        }

        



}
