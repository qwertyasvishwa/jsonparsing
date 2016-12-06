//
//  ViewController.swift
//  jsonparse
//
//  Created by Vishwa Raj on 06/12/16.
//  Copyright © 2016 innov8. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var datalabel: UILabel!
    @IBOutlet weak var fetchDataBtn: UIButton!
    @IBOutlet weak var nextDataBtn: UIButton!
    @IBOutlet weak var previousDataBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func fetchData(_ sender: Any) {
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
        ]
        
        Alamofire.request("http://vishwaraj.xyz/iOSServer/", method: .get, encoding: URLEncoding.default, headers:headers)
            .responseJSON { response in
                switch response.result
                {
                case.success(let JSON):
                    let response = JSON as! [[String: AnyObject]]
                    for keys in response
                    {
                        let key = (keys as NSDictionary).object(forKey: "email")!
                        print(key)
                    }
                    
                case.failure(let error):
                    
                    print("Error")
                }
        }
        
        
    }
    
    @IBAction func previousData(_ sender: Any) {
        
    }
    
    @IBAction func nextData(_ sender: Any) {
        
    }

}

