//
//  ViewController.swift
//  PlistDemo
//
//  Created by Jony Singla on 04/01/17.
//  Copyright © 2017 Jony Singla. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tableData = [String]()
    var receipeTiming = [String]()
    var thumbnails = [String]()
    
    var stringArr = String()
    var stringArrBlank = ""
    
    
    @IBOutlet weak var buttonSaveAction: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    
    let path = Bundle.main.path(forResource: "Receipe", ofType: "plist")!
    var dictionary : NSMutableDictionary!
    let fileManager = FileManager.default
    
    var arrCheckUncheck = [String]()
    
    var str   = String()
    var str1   = String()
    var str2   = String()
    var str3   = String()
    //    var label : UILabel!
    
    @IBOutlet weak var labelDisplayValue: UILabel!
    
    @IBOutlet weak var labelDisplayMenu1: UILabel!
    
    @IBOutlet weak var labelDisplayMenu3: UILabel!
    @IBOutlet weak var labelDisplayMenu2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dictionary = NSMutableDictionary(contentsOfFile: path)
        
//        let path = Bundle.main.path(forResource: "Receipe", ofType: "plist")!
        let result = NSDictionary(contentsOfFile: path)
//        let url = NSURL.fileURL(withPath: path)
//        print(url)
        
        
//        tableData = ["\(dictionary!.object(forKey: "Num")!)"]
    
        tableData = result!.object(forKey: "RecipeName") as! [String]
        receipeTiming = result!.object(forKey: "PrepTime") as! [String]
        thumbnails = result!.object(forKey: "Thumbnail") as! [String]
        
//        stringArr = String(describing: tableData)
        print(stringArr)
        
        print(tableData)
        print(receipeTiming)
        print(thumbnails)

        checkFile()
        buttonReadAction(self)
        
        print(tableData)
        for i in (0..<tableData.count)
        {
            print(i)
            arrCheckUncheck.append("Uncheck")
            print(arrCheckUncheck)
        }

    }
    
    func checkFile() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0)as! NSString
        let path = documentsDirectory.appendingPathComponent("Receipe.plist")
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path))
        {
            let srcPath = Bundle.main.path(forResource: "Receipe", ofType: "plist")
            do {
                //Copy the project plist file to the documents directory.
                try fileManager.copyItem(atPath: srcPath!, toPath: path)
            } catch {
                print("File copy error!")
            }
        }
        else
        {
            print("path found")
        }
    }
    @IBAction func buttonDeleteAction(_ sender: Any) {
        
        print("btnDel")
        labelDisplayValue.text = ""
        do {
            try fileManager.removeItem(atPath: path)
        } catch {
            print("Unable to delete the plist file")
        }
    }
    @IBAction func buttonSaveAction(_ sender: Any) {
        
        dictionary.setValue(str, forKey: "Str")
        dictionary.setValue(str1, forKey: "Str1")
        dictionary.setValue(str2, forKey: "Str2")
        dictionary.setValue(str3, forKey: "Str3")
        dictionary.write(toFile: path, atomically: true)
        print("write")
    }
    @IBAction func buttonReadAction(_ sender: Any) {
//        labelDisplayValue.text = stringArr
//        labelDisplayMenu1.text = stringArr
        print(stringArr)
        labelDisplayValue.text = "\(dictionary!.object(forKey: "Str")!)"
        labelDisplayMenu1.text = "\(dictionary!.object(forKey: "Str1")!)"
        labelDisplayMenu2.text = "\(dictionary!.object(forKey: "Str2")!)"
        labelDisplayMenu3.text = "\(dictionary!.object(forKey: "Str3")!)"
        
        var conStr = String ()
        conStr = "\(dictionary!.object(forKey: "Str")!)" + "\(dictionary!.object(forKey: "Str1")! )," + "\(dictionary!.object(forKey: "Str2")!)," + "\(dictionary!.object(forKey: "Str3")!)"
        print(conStr)
        
//        print(dictionary!.object(forKey: "Num")!)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! CellTableViewCell
        let row = indexPath.row
        cell.labelMenuName.text = tableData[row]
        cell.labelTiming.text = receipeTiming[row]
        cell.imageView?.image = UIImage(named: thumbnails[row])
        
        // Configure the cell..
        
//        if arrCheckUncheck[indexPath.row] == "Uncheck" {
//            cell.btnCheckBox.setImage(UIImage(named: "check_box_off"), for: .normal)
//            
//        }else{
//            cell.btnCheckBox.setImage(UIImage(named: "check_box_on"), for: .normal)
//        }
        
        cell.btnCheckBox.addTarget(self, action: #selector(checkUncheckBtnClick(_:)), for: .touchUpInside)
        
        return cell
    }
    @IBAction func checkUncheckBtnClick(_ sender: Any) {
        
        if let button = sender as? UIButton {
            if let indexPath = getIndexPathForSender(sender: button)
            {
                stringArr = String(describing: tableData)
                stringArr = "\(tableData[indexPath.row])"
                print(stringArr)
                print(indexPath.row)
                let checkVal = arrCheckUncheck[indexPath.row] as String
                if indexPath.row == 0 {
                    if checkVal == "Uncheck" {
                        arrCheckUncheck[indexPath.row] = "check"
                        button.setImage(UIImage(named: "check_box_on"), for: .normal)
                        dictionary.setValue(stringArr, forKey: "Str")
                        dictionary.write(toFile: path, atomically: true)
                        
                    }else{
                        arrCheckUncheck[indexPath.row] = "Uncheck"
                        button.setImage(UIImage(named: "check_box_off"), for: .normal)
                        dictionary.setValue(stringArrBlank, forKey: "Str")
                        do {
                            try fileManager.removeItem(atPath: path)
                        } catch {
                            print("Unable to delete the plist file")
                        }
                    }
                }
                if indexPath.row == 1 {
                    if checkVal == "Uncheck" {
                        arrCheckUncheck[indexPath.row] = "check"
                        button.setImage(UIImage(named: "check_box_on"), for: .normal)
                        dictionary.setValue(stringArr, forKey: "Str1")
                        dictionary.write(toFile: path, atomically: true)
                        
                    }else{
                        
                        arrCheckUncheck[indexPath.row] = "Uncheck"
                        button.setImage(UIImage(named: "check_box_off"), for: .normal)
                        dictionary.setValue(stringArrBlank, forKey: "Str1")
                        do {
                            try fileManager.removeItem(atPath: path)
                        } catch {
                            print("Unable to delete the plist file")
                        }
                    }
                }
                
                if indexPath.row == 2 {
                    if checkVal == "Uncheck" {
                        arrCheckUncheck[indexPath.row] = "check"
                        button.setImage(UIImage(named: "check_box_on"), for: .normal)
                        dictionary.setValue(stringArr, forKey: "Str2")
                        dictionary.write(toFile: path, atomically: true)
                        
                    }else{
                        
                        arrCheckUncheck[indexPath.row] = "Uncheck"
                        button.setImage(UIImage(named: "check_box_off"), for: .normal)
                        dictionary.setValue(stringArrBlank, forKey: "Str2")
                        do {
                            try fileManager.removeItem(atPath: path)
                        } catch {
                            print("Unable to delete the plist file")
                        }
                    }
                }
                
                if indexPath.row == 3 {
                    if checkVal == "Uncheck" {
                        arrCheckUncheck[indexPath.row] = "check"
                        button.setImage(UIImage(named: "check_box_on"), for: .normal)
                        dictionary.setValue(stringArr, forKey: "Str3")
                        dictionary.write(toFile: path, atomically: true)
                        
                    }else{
                        
                        arrCheckUncheck[indexPath.row] = "Uncheck"
                        button.setImage(UIImage(named: "check_box_off"), for: .normal)
                        dictionary.setValue(stringArrBlank, forKey: "Str3")
                        do {
                            try fileManager.removeItem(atPath: path)
                        } catch {
                            print("Unable to delete the plist file")
                        }
                    }
                }
            }
        }
    }
    private func getIndexPathForSender(sender : UIView) -> IndexPath?
    {
        var currentView : UIView? = sender
        while currentView != nil {
            if currentView is CellTableViewCell {
                return tableView.indexPath(for: currentView as! CellTableViewCell)
            }
            else
            {
                currentView = currentView?.superview
            }
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

