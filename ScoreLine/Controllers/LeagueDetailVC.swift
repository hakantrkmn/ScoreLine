//
//  LeagueDetailVC.swift
//  ScoreLine
//
//  Created by Om Gandhi on 25/02/24.
//

import UIKit
import Alamofire
import SDWebImage
class LeagueDetailVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{
    
    //MARK: Outlets
    @IBOutlet weak var lblLeagueName: UILabel!
    @IBOutlet weak var clcTeams: UICollectionView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imgTop: UIImageView!
    
    //MARK: Variables
    var teamData = [AnyObject]()
    var leagueData: AnyObject = [:] as AnyObject
    var filteredTeamData = [AnyObject]()
    var leagueId = ""
    //MARK: Viewcontroller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "League Detail"

        getTeamData()
        // Do any additional setup after loading the view.
    }
    //MARK: Webservice methods
    func getTeamData(){
        let teamDataUrl = "https://\(apiHost)/teams?league=\(leagueId)&season=\(Calendar.current.component(.year, from: Calendar.current.date(byAdding: .year, value: -1, to: Date.init()) ?? Date()))"
        let headers:HTTPHeaders = ["x-rapidapi-key" : api_key,
                                   "x-rapidapi-host" : apiHost]
        callWebServiceToFetchJsonData(strURL: teamDataUrl, headers: headers){[self]response in
            teamData = response?["response"] as? [AnyObject] ?? []
            filteredTeamData = teamData
            clcTeams.delegate = self
            clcTeams.dataSource = self
            clcTeams.reloadData()
            
        }OnFail: { err in
            print(err)
        }
        
    }
    //MARK: Collectionview methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredTeamData.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/2) - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        let team = filteredTeamData[indexPath.row]
        let teamData = team["team"] as? AnyObject
        cell.imgLeague.sd_setImage(with: URL(string: teamData?["logo"] as? String ?? "" ))
        cell.lblLeagueName.text = teamData?["name"] as? String ?? ""
        
//        cell.layer.cornerRadius = 20
//        cell.backgroundColor = UIColor(named: "leagueBack")
        
        return cell
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lowerSearchText = searchText.lowercased()
        filteredTeamData = searchText.isEmpty ? teamData : teamData.filter {team in
            let teamData = team["team"] as? AnyObject
            let name = teamData?["name"] as? String ?? ""
            
            return name.lowercased().contains(lowerSearchText)
        }
        clcTeams.reloadData()
    }
}
