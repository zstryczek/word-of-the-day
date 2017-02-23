//
//  ViewController.swift
//  Word Of The Day
//
//  Created by zstryczek on 2/22/17.
//  Copyright © 2017 zstryapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    var word = String()
    var definition = String()
    
    @IBOutlet var wordLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let urlString = "http://developer.wordnik.com/v4/words.json"
        
        //if url is a valid url
        if let url = NSURL(string: urlString)
        {
            if let myData = try? NSData(contentsOf: url as URL, options: [])//try cheks for url connection
            {
                let json = JSON(data: myData as Data)//created jason object taking ns data and making it usable withinn jason
                
                print("ok to parse")
                parse(json: json)
            
            }
        }
    }
    
    func parse(json: JSON)
    {
        
        let word = "word"
        for result in json ["definitions"].arrayValue
        {
            let definition = "text"
        }
        
       wordLabel.text = word
    }
    
}


