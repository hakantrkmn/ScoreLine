//
//  DatePickerVC.swift
//  Popover
//
//  Created by AthulyaTech on 20/02/23.
//

import UIKit

class DatePickerVC: UIViewController{
   
//MARK: Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
//MARK: Variables
    var titleLabel = "DateTime"
    var showDateTime = ""
    var minDate=Date()
    var noOfDays = Int()
    var maxDate = Date()
    var isTimePicker = false
    var onCompletionDone: ((String?) -> Void)?
    //===================================================================
       // MARK: - VIEW CONTROLLER LIFE CYCLE
       //===================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }
    //SET DATE TIME FORMAT AND TYPE OF PICKER
    override func viewWillAppear(_ animated: Bool) {
        if isTimePicker{
            datePicker.minimumDate = minDate
            if noOfDays != 0{
                //datePicker.maximumDate = maxDate
                datePicker.maximumDate = Calendar.current.date(byAdding: .day, value: noOfDays, to: Date())

            }else{
                datePicker.maximumDate = maxDate

            }
        }
        
        datePicker.date = Date()
        if titleLabel == "DateTime" {
            datePicker.date = getlocalToserverDate(date: showDateTime, input: "MM/dd/yyyy h:mm:ss a") ?? Date()
            datePicker.datePickerMode = .dateAndTime
            datePicker.preferredDatePickerStyle = .inline
        } else if titleLabel == "Date" {
            datePicker.date = getlocalToserverDate(date: showDateTime, input: "MM/dd/yyyy") ?? Date()
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .inline
        } else if titleLabel == "Time" {
            datePicker.date = getlocalToserverDate(date: showDateTime, input: "h:mm a") ?? Date()
            datePicker.datePickerMode = .time
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.center = view.center
        } else {
            datePicker.datePickerMode = .dateAndTime
            datePicker.preferredDatePickerStyle = .inline
        }
        
    }
    override func viewDidLayoutSubviews() {
        btnDone.tintColor = .ecom_buttonColor
        btnCancel.tintColor = .red
        datePicker.tintColor = .ecom_buttonColor
    }
    //===================================================================
       // MARK: - Button methods
       //===================================================================
    @IBAction func btnDone(_ sender: Any) {
        valueChanged()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    //SET DATE TIME ON VALUE CHANGED
    func valueChanged(){
        if titleLabel == "DateTime" {
            let strDate = getserverToLocalDate(date: datePicker.date, output: "MM/dd/yyyy h:mm:ss a")
            self.onCompletionDone!(strDate)
        } else if titleLabel == "Date" {
            let strDate = getserverToLocalDate(date: datePicker.date, output: "MM/dd/yyyy")
            self.onCompletionDone!(strDate)
        } else if titleLabel == "Time" {
            let strDate = getserverToLocalDate(date: datePicker.date, output: "h:mm a")
            self.onCompletionDone!(strDate)
        } else {
            let strDate = getserverToLocalDate(date: datePicker.date, output: "MM/dd/yyyy h:mm:ss a")
            self.onCompletionDone!(strDate)
        }
    }
}

