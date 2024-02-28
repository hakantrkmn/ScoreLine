//
//  ListTableVC.swift
//  EcomAppProduct
//
//  Created by AthulyaTech on 20/02/23.
//

import UIKit

class ListTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate{
   
    
    
    
   
    
    
    
    //MARK: Outlets
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    //MARK: Variables
    var arrList1 = [AnyObject]()
    var titleLabel = String()
    var keyName = String()
    var isSearchView = Bool()
    var onCompletionDone: ((AnyObject?) -> Void)?
    let searchController = UISearchController(searchResultsController: nil)
    var arrTemp1 = [AnyObject]()
    //===================================================================
       // MARK: - VIEW CONTROLLER LIFE CYCLE
       //===================================================================


    override func viewDidLoad() {
        super.viewDidLoad()
        arrTemp1 = arrList1

        if isSearchView == true{
            searchBar.delegate = self
            searchBar.becomeFirstResponder()
        }
        else{
            searchBar.isHidden = true
            searchBar.frame.size.height = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleText.text = titleLabel
    }
    
    //===================================================================
       // MARK: - Tableview Methods
       //===================================================================


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTemp1.count
    }
    // CREATION OF CELLS BASED ON IF KEY IS PRESENT OR NOT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListTableCell
//        let dict = arrTemp1[indexPath.row]
//        if keyName.isEmpty != true{
//            if keyName == "name"{
//                cell.lblText.text = (dict.value(forKey: keyName) as? String ?? "") + "(" + (dict.value(forKey: "dial_code") as? String ?? "") + ")"
//            }
//            else{
//                cell.lblText.text = dict.value(forKey: keyName) as? String ?? ""
//            }
//            
//        }
//        else
//        {
//            cell.lblText.text = dict as? String
//        }
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dictSelected = arrTemp1[indexPath.row]
        onCompletionDone!(dictSelected)
    }
        //==============================================================================================
        //MARK: - SEARCHBAR DELEGATE METHOD
        //==============================================================================================
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let searchString = searchText
            if (searchString.count) == 0 {
                arrTemp1 = arrList1
            } else {
                let strippedString = searchString.trimmingCharacters(in: .whitespaces)
                let predicate = NSPredicate(format: "SELF.%K CONTAINS[cd] %@",keyName,strippedString)
                let array =  (arrList1 as NSArray).filtered(using: predicate)
                arrTemp1 = array as [AnyObject]
                
            }
            tblView.reloadData()
        }

}
