//
//  ViewController.swift
//  jsonparse
//
//  Created by Vishwa Raj on 06/12/16.
//  Copyright © 2016 innov8. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var datalabel: UILabel!
    @IBOutlet weak var fetchDataBtn: UIButton!
    @IBOutlet weak var nextDataBtn: UIButton!
    @IBOutlet weak var previousDataBtn: UIButton!
    var actInd = UIActivityIndicatorView()
    var dataTableView = UITableView()
    var emails = ["Loading..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actInd = UIActivityIndicatorView(frame: CGRect(x:self.view.bounds.size.width - 25,y:self.view.bounds.size.height - 25, width:50, height:50)) as UIActivityIndicatorView
        actInd.center = self.view.center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(actInd)
        
        dataTableView = UITableView(frame:  CGRect(x:20,y:140, width:self.view.bounds.size.width - 40, height:self.view.bounds.size.height - 140), style: UITableViewStyle.plain)
        dataTableView.dataSource = self
        dataTableView.delegate = self
        dataTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(self.dataTableView)
    }
    @IBAction func fetchData(_ sender: Any) {
        actInd.startAnimating()
        Alamofire.request("http://vishwaraj.xyz/iOSServer/", method: .get, encoding: URLEncoding.default, headers:[ "Content-Type": "application/x-www-form-urlencoded", ])
            .responseJSON { response in
                switch response.result {
                    case.success(let JSON):
                        self.emails.remove(at: 0)
                        let response = JSON as! [[String: AnyObject]]
                        for keys in response {
                            let key = (keys as NSDictionary).object(forKey: "email")!
                            self.emails.append(key as! String);
                        }
                        self.actInd.stopAnimating()
                        self.dataTableView.reloadData()
                    case.failure(let error):
                        print("Error %@", error.localizedDescription)
                }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = dataTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.emails[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func previousData(_ sender: Any) {
        
    }
    
    @IBAction func nextData(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
    
}

