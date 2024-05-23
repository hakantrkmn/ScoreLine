//
//  LeagueVC.swift
//  ScoreLine
//
//  Created by Om Gandhi on 25/02/24.
//

import UIKit
import Alamofire
import SDWebImage
class LeagueVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{
    
    //MARK: Outlets
    @IBOutlet weak var clcLeagues: UICollectionView!
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imgTop: UIImageView!
    //MARK: Variables
    var leagueArr = [AnyObject]()
    var filteredLeagues = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Leagues"
        getLeagues()
        // Do any additional setup after loading the view.
    }
    //MARK: Webservice methods
    func getLeagues(){
        let getLeagueUrl = "https://\(apiHost)/leagues"
        let headers:HTTPHeaders = ["x-rapidapi-key" : api_key,
                                   "x-rapidapi-host" : apiHost]
        callWebServiceToFetchJsonData(strURL: getLeagueUrl, headers: headers){[self]response in
            leagueArr = response?["response"] as? [AnyObject] ?? []
            filteredLeagues = leagueArr
            clcLeagues.delegate = self
            clcLeagues.dataSource = self
            clcLeagues.reloadData()
            
        }OnFail: { err in
            print(err)
        }
    }
    
    //MARK: Collectionview methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredLeagues.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/2) - 10, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        let league = filteredLeagues[indexPath.row]
        let leagueData = league["league"] as? AnyObject
        cell.imgLeague.sd_setImage(with: URL(string: leagueData?["logo"] as? String ?? "" ))
        cell.lblLeagueName.text = leagueData?["name"] as? String ?? ""
        
//        cell.layer.cornerRadius = 20
//        cell.backgroundColor = UIColor(named: "leagueBack")
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "leagueTeamsStory") as! LeagueDetailVC
        let league = filteredLeagues[indexPath.row]
        let leagueData = league["league"] as? AnyObject
        vc.leagueId = String(leagueData?["id"] as? Int ?? 0)
        vc.leagueData = leagueData!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let lowerSearchText = searchText.lowercased()
        filteredLeagues = searchText.isEmpty ? leagueArr : leagueArr.filter {league in
            let leagueData = league["league"] as? AnyObject
            let name = leagueData?["name"] as? String ?? ""
            
            return name.lowercased().contains(lowerSearchText)
        }
        clcLeagues.reloadData()
    }
}
