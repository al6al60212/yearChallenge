//
//  ViewController.swift
//  yearChallenge
//
//  Created by 董禾翊 on 2022/10/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var describeLable: UILabel!
    @IBOutlet weak var controllerSlider: UISlider!
    @IBOutlet weak var controllerDatePicker: UIDatePicker!
    //照片
    let photos = ["202009", "202010", "202011", "202012", "202101", "202102", "202103", "202104", "202105", "202106", "202107", "202108", "202109", "202110", "202111", "202112", "202201", "202202", "202203", "202204", "202205", "202206", "202207", "202208", "202209", "202210"]

    var timer: Timer?
    
    var i = 0
    
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
//自動播放執行的指令
    @objc func autoChangePhoto(){
        pictureView.image = UIImage(named: photos[i])
        //連動slider
        controllerSlider.value = Float(i)
        //連動lable
        describeLable.text = photos[i]
        //連動datePicker
        dateFormatter.dateFormat = "yyyyMM"
        let date = dateFormatter.date(from: photos[i])
        controllerDatePicker.date = date!
        
        i = (i + 1) % photos.count
    }
    
    @IBAction func slider(_ sender: UISlider) {
        controllerSlider.value = sender.value.rounded()
        pictureView.image = UIImage(named: photos[Int(sender.value)])
        //連動datePicker
        dateFormatter.dateFormat = "yyyyMM"
        let date = dateFormatter.date(from: photos[Int(sender.value)])
        controllerDatePicker.date = date!
        //連動lable
        describeLable.text = photos[Int(sender.value)]
        i = Int(sender.value)
    }
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: controllerDatePicker.date)
        let year = dateComponents.year!
        let yearString = "\(year)"
        let month = dateComponents.month!
        var monthString = ""
        switch month{
            case 10, 11, 12:
                monthString = "\(month)"
            default :
                monthString = "0" + "\(month)"
        }
        pictureView.image = UIImage(named: yearString + monthString)
        //連動lable
        describeLable.text = yearString + monthString
        //連動slider
        controllerSlider.value = Float(photos.firstIndex(of: yearString + monthString)!)
        i = Int(controllerSlider.value)
    }
    
    //自動播放開關
    @IBAction func autoPlay(_ sender: UISwitch) {
        if sender.isOn{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(autoChangePhoto), userInfo: nil, repeats: true)
        }else{
            timer?.invalidate()
        }
    }
    
    
}

