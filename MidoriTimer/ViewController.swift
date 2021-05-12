//
//  ViewController.swift
//  MidoriTimer
//
//  Created by Andrew Cheberyako on 27.04.2021.
//

import UIKit

var randomNomber = 0

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    let jsonTest = ParseJSON.shared.self
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
   var arrayNote = [TestElement]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.layer.cornerRadius = 5
        ParseJSON.shared.loadJson()
        arrayNote = ParseJSON.shared.test
      
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
        backgroundNotification()
       
        
    
        
        // Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(notificationBaner), userInfo: nil, repeats: true)
        
    }
    
    
    func backgroundNotification () {
        let periodInSeconds =  5
        var components = DateComponents()
        components = intervalToComponents(perionInSeconds: periodInSeconds)
        let content = UNMutableNotificationContent()
        content.sound = .default
        guard let randomeNote = arrayNote.randomItem() else {return}
        print(randomeNote)
        content.body = randomeNote.title
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: "reminderNotificationId", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(error?.localizedDescription)
            }
        }
    }
       
     private func intervalToComponents(perionInSeconds: Int) -> DateComponents {
       // Текущая дата
       let date = NSDate() as Date
       // Нахождение даты срабатывания уведомления
       let notificationDate = date.addingTimeInterval(Double(perionInSeconds))
       // Извлечение из даты срабатывания элементов (день, час, минута) и помещение их в компоненты
       let calendar = Calendar.current
       let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificationDate)
       return components
     }
    
    @objc func notificationBaner() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour == 12 {
          appDelegate?.scheduleNotification(notifaicationType: "Еще 12 часов")
            print(hour)
        }
        
    }
    
    
    @objc func updateLabel() {
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        let dayString = String(day - 10)
        let hourString = String(hour)
        let minutesString = String(minutes)
        let secondString = String(second)
        dayLabel.text = "День \(dayString)"
        hourLabel.text = "Часы \(hourString)"
        minuteLabel.text = "Минуты \(minutesString)"
        secondLabel.text = "Секунды \(secondString)"
        
    }
    
    
}
extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        randomNomber = index
        return self[index]
    }
}


