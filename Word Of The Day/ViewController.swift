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
    var actualCurrentDate = String()
    var currentDateTypeDate = Date()
    var currentDateLabelText = String()
    var word = String()
    var definition = String()
    var wordOfTheDay = String()
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    @IBOutlet var todaysWordButtonOutlet: UIButton!
    @IBOutlet var quizButtonOutlet: UIButton!
    
    override func viewDidLoad()
    {
        findCurrentDate()
        findCurrentDateForLabel()
        dateLabel.text = "Today"
        super.viewDidLoad()
        let urlString = "http://api.wordnik.com/v4/words.json/wordOfTheDay?date=\(actualCurrentDate)&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5"
        
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
        
        wordOfTheDay = word.stringValue
        
        wordLabel.text = word.stringValue
        
        for definition in json["definitions"].arrayValue
        {
            let definitionText = definition["text"].stringValue
            
            definitionLabel.text = (definitionText)
        }
     
    }
    
    
    
    

    @IBAction func todaysWordButtonTapped(_ sender: Any) {
        
        todaysWordButtonOutlet.setImage(UIImage(named: "todaysWordTapped"), for: UIControlState.normal)
        quizButtonOutlet.setImage(UIImage(named: "quiz"), for: UIControlState.normal)
        
    }
    
    @IBAction func shiftDateUp(_ sender: Any) {
        
        if (currentDate == actualCurrentDate)
        {
            dateLabel.text = "Today"
        }
        
        else
        {
            shiftDateUp()
            findCurrentDateForLabel()
            dateLabel.text = "\(currentDateLabelText)"
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

    }
    
    
    
    @IBAction func shiftDateDown(_ sender: Any) {
        
        shiftDateDown()
        findCurrentDateForLabel()
        dateLabel.text = "\(currentDateLabelText)"
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
    
    
    @IBAction func quizButtonTapped(_ sender: Any) {
        
        quizButtonOutlet.setImage(UIImage(named: "quizTapped"), for: UIControlState.normal)
        todaysWordButtonOutlet.setImage(UIImage(named: "todaysWord"), for: UIControlState.normal)
        
    }
    @IBAction func shareButtonTapped(_ sender: Any) {
        
        
        let vc = self.view?.window?.rootViewController
        
        let myText = "The word of the day is \(wordOfTheDay) check out the word of the day app to see what it means"
        
        let activityVC:UIActivityViewController = UIActivityViewController(activityItems: [myText], applicationActivities: nil)
        
        vc?.present(activityVC, animated: true, completion: nil)

    }
    
    func findCurrentDate()
    {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        let result = formatter.string(from: date)
        
        currentDateTypeDate = date
        actualCurrentDate = result
        currentDate = result
    }
    
    func findCurrentDateForLabel()
    {
        let date = currentDateTypeDate
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMMM d yyyy"
        
        
        
        let result = formatter.string(from: date)
        
        currentDateLabelText = result
    }
    
    
    func shiftDateUp()
    {
        let today = currentDateTypeDate
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        let result = formatter.string(from: tomorrow!)
        
        currentDateTypeDate = tomorrow!
        currentDate = result

    }
    
    func shiftDateDown()
    {
        let today = currentDateTypeDate
        let tomorrow = Calendar.current.date(byAdding: .day, value: -1, to: today)

        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        
        let result = formatter.string(from: tomorrow!)
        
        currentDateTypeDate = tomorrow!
        currentDate = result
        
    }

}


