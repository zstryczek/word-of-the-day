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
    var currentDate = String()
    var word = String()
    var definition = String()
    
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    override func viewDidLoad()
    {
        findCurrentDate()
        super.viewDidLoad()
        let urlString = "http://api.wordnik.com/v4/words.json/wordOfTheDay?date=\(currentDate)&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5"
        
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

        let word = json["word"]
        
        wordLabel.text = word.stringValue
        
        for definition in json["definitions"].arrayValue
        {
            let definitionText = definition["text"].stringValue
            
            definitionLabel.text = (definitionText)
        }
     
    }
    
    func findCurrentDate()
    {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        let result = formatter.string(from: date)
        
        currentDate = result
    }
    
}


