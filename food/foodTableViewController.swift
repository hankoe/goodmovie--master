//
//  foodTableViewController.swift
//  food
//
//  Created by user_17 on 2016/12/30.
//  Copyright © 2016年 user_17. All rights reserved.
//

import UIKit

class foodTableViewController: UITableViewController {

    var isAddFood = false
    
    var foods = [[String:String]]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isAddFood{
            isAddFood = false
            let indexPath = IndexPath(row:0,section:0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func updateFile(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory,in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("food.txt")
        (foods as NSArray).write(to: url!, atomically: true)
    }
    
    func addfoodNoti(noti:Notification) {
        let dic = noti.userInfo as! [String:String]
        foods.insert(dic, at: 0)
        updateFile()
        isAddFood = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        /*foods = [["name":"八方雲集","location":"我家樓下","goodToEat":"4"],
                 ["name":"董娘","location":"我家樓下","goodToEat":"3"],
                 ["name":"QQ","location":"我家樓下往上走","goodToEat":"4"],
                 ["name":"五味","location":"我家樓下往下走","goodToEat":"4"],
                 ["name":"肯德基","location":"外送就好","goodToEat":"5"],
                 ["name":"麥當勞","location":"我家樓下往下走","goodToEat":"5"],
                 ["name":"范師傅","location":"我家樓下","goodToEat":"4"],
                 ["name":"咖哩飯","location":"我家樓下seven-eleven","goodToEat":"4"]]*/
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for:.documentDirectory, in:.userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("food.txt")
        let array = NSArray(contentsOf:url!)
        if array != nil{
            foods = array as![[String:String]]
        }
        let notiName = Notification.Name("addFood")
        NotificationCenter.default.addObserver(self, selector: #selector(foodTableViewController.addfoodNoti(noti:)), name: notiName, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foods.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! foodTableViewCell

        let dic = foods[indexPath.row]
        
        // Configure the cell...
        
        cell.nameLabel.text = dic["name"]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        foods.remove(at: indexPath.row)
        updateFile()
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let dic:[String:String]
            dic = foods[indexPath!.row]
            
            
            let controller = segue.destination as! foodDetailViewController
            controller.foodInfoDic = dic
        }
    }
    

}
