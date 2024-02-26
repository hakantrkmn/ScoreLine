//
//  MatchVC.swift
//  ScoreLine
//
//  Created by Om Gandhi on 26/02/24.
//

import UIKit
import Alamofire

class MatchVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    //MARK: Outlets
    @IBOutlet weak var segDataControl: UISegmentedControl!
    @IBOutlet weak var lblLeague: UILabel!
    @IBOutlet weak var lblStadium: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var tblTeamData: UITableView!
    @IBOutlet weak var clcEvents: UICollectionView!
    @IBOutlet weak var lblHomeName: UILabel!
    @IBOutlet weak var lblAwayName: UILabel!
    @IBOutlet weak var imgAway: UIImageView!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var lblHomeScore: UILabel!
    @IBOutlet weak var lblAwayScore: UILabel!
    //MARK: Variables
    var matchData: AnyObject = [] as AnyObject
    var liveData: AnyObject = [] as AnyObject
    var eventArr = [AnyObject]()
    var homeTeam:AnyObject = [] as AnyObject
    var awayTeam:AnyObject = [] as AnyObject
    var startingXIHomeArr = [AnyObject]()
    var startingXIAwayArr = [AnyObject]()
    var substituteHomeArr = [AnyObject]()
    var substituteAwayArr = [AnyObject]()
    var coachHomeArr = [AnyObject]()
    var coachAwayArr = [AnyObject]()
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getFixtureData()
        getLineUpData()
    }
    //MARK: Webservice methods
    func getFixtureData(){
        let fixtureUrl = "https://v3.football.api-sports.io/fixtures?id=\(matchData["id"] as? Int ?? 0)"
        let headers:HTTPHeaders = ["x-rapidapi-key" : "ef202dc7c88478fd5250d7c20a7d5f7c",
                                   "x-rapidapi-host" : "v3.football.api-sports.io"]
        callWebServiceToFetchJsonData(strURL: fixtureUrl,headers: headers){[self]response in
            var responseData = response?["response"] as? [AnyObject]
            liveData = responseData?[0] as AnyObject
            let fixtureData = liveData["fixture"] as? AnyObject
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let date = dateFormatter.date(from: fixtureData?["date"] as? String ?? "")
            
            let properDateFormatter = DateFormatter()
            properDateFormatter.dateFormat = "d MMM, h:mm a"
            let properDate = properDateFormatter.string(from: date ?? Date())
            
            lblDate.text = properDate
            let venueData = fixtureData?["venue"] as? AnyObject
            lblStadium.text = venueData?["name"] as? String ?? ""
            
            let leagueData = liveData["league"] as? AnyObject
            lblLeague.text = leagueData?["name"] as? String ?? ""
            
            let teamData = liveData["teams"] as? AnyObject
            let homeTeam = teamData?["home"] as? AnyObject
            imgHome.sd_setImage(with: URL(string: homeTeam?["logo"] as? String ?? ""))
            let awayTeam = teamData?["away"] as? AnyObject
            imgAway.sd_setImage(with: URL(string: awayTeam?["logo"] as? String ?? ""))
            
            lblHomeName.text = homeTeam?["name"] as? String ?? ""
            lblAwayName.text = awayTeam?["name"] as? String ?? ""
            
            let goalsData = liveData["goals"] as? AnyObject
            lblHomeScore.text = "\(goalsData?["home"] as? Int ?? 0)"
            lblAwayScore.text = "\(goalsData?["away"] as? Int ?? 0)"
            
            eventArr = liveData["events"] as? [AnyObject] ?? []
            clcEvents.delegate = self
            clcEvents.dataSource = self
            clcEvents.reloadData()
            
            tblTeamData.delegate = self
            tblTeamData.dataSource = self
            tblTeamData.reloadData()
            
        }OnFail: { err in
            print(err)
        }
    }
    func getLineUpData(){
        let lineupUrl = "https://v3.football.api-sports.io/fixtures/lineups?fixture=\(matchData["id"] as? Int ?? 0)"
        let headers:HTTPHeaders = ["x-rapidapi-key" : "ef202dc7c88478fd5250d7c20a7d5f7c",
                                   "x-rapidapi-host" : "v3.football.api-sports.io"]
        
        callWebServiceToFetchJsonData(strURL: lineupUrl, headers: headers){[self] response in
            var teamArr = response as? [AnyObject] ?? []
            if teamArr.count != 0 || !teamArr.isEmpty{
                homeTeam = teamArr[0] as AnyObject
                awayTeam = teamArr[1] as AnyObject
            }
            
            
            startingXIHomeArr = homeTeam["startXI"] as? [AnyObject] ?? []
            startingXIAwayArr = awayTeam["startXI"] as? [AnyObject] ?? []
            
            substituteHomeArr = homeTeam["substitutes"] as? [AnyObject] ?? []
            substituteAwayArr = awayTeam["substitutes"] as? [AnyObject] ?? []
            
            coachHomeArr = [homeTeam["coach"]] as? [AnyObject] ?? []
            coachAwayArr = [awayTeam["coach"]] as? [AnyObject] ?? []
            
            tblTeamData.delegate = self
            tblTeamData.dataSource = self
            tblTeamData.reloadData()
            
            
        }OnFail: { err in
            print(err)
        }
    }
    //MARK: Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segDataControl.selectedSegmentIndex == 0{
            if section == 0{
                if startingXIHomeArr.count == 0 || startingXIHomeArr.isEmpty{
                    return 1
                }
                else{
                    return startingXIHomeArr.count
                }
            }
            else {
                if startingXIAwayArr.count == 0 || startingXIAwayArr.isEmpty{
                    return 1
                }
                else{
                    return startingXIAwayArr.count
                }
            }
        }
        else if segDataControl.selectedSegmentIndex == 1{
            if section == 0{
                if substituteHomeArr.count == 0 || substituteHomeArr.isEmpty{
                    return 1
                }
                else{
                    return substituteHomeArr.count
                }
            }
            else {
                if substituteAwayArr.count == 0 || substituteAwayArr.isEmpty{
                    return 1
                }
                else{
                    return substituteAwayArr.count
                }
            }
        }
        else{
            if section == 0{
                if coachHomeArr.count == 0 || coachHomeArr.isEmpty{
                    return 1
                }
                else{
                    return coachHomeArr.count
                }
            }
            else {
                if coachAwayArr.count == 0 || coachAwayArr.isEmpty{
                    return 1
                }
                else{
                    return coachAwayArr.count
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            let homeTeamData = homeTeam["team"] as? AnyObject
            return homeTeamData?["name"] as? String ?? ""
        }
        let awayTeamData = awayTeam["team"] as? AnyObject
        return awayTeamData?["name"] as? String ?? ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segDataControl.selectedSegmentIndex == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
            if indexPath.section == 0{
                if startingXIHomeArr.count == 0 || startingXIHomeArr.isEmpty{
                    cell.lblPlayerName.text = "No data found"
                    cell.lblPlayerNo.text = ""
                }
                else{
                    let playerData = startingXIHomeArr[indexPath.row]
                    let player = playerData["player"] as? AnyObject
                    cell.lblPlayerName.text = player?["name"] as? String ?? ""
                    cell.lblPlayerNo.text = "\(player?["number"] as? Int ?? 0)"
                }
            }
            else{
                if startingXIAwayArr.count == 0 || startingXIAwayArr.isEmpty{
                    cell.lblPlayerName.text = "No data found"
                    cell.lblPlayerNo.text = ""
                }
                else{
                    let playerData = startingXIAwayArr[indexPath.row]
                    let player = playerData["player"] as? AnyObject
                    cell.lblPlayerName.text = player?["name"] as? String ?? ""
                    cell.lblPlayerNo.text = "\(player?["number"] as? Int ?? 0)"
                }
            }
            return cell
        }
        else if segDataControl.selectedSegmentIndex == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
            if indexPath.section == 0{
                if substituteHomeArr.count == 0 || substituteHomeArr.isEmpty{
                    cell.lblPlayerName.text = "No data found"
                    cell.lblPlayerNo.text = ""
                }
                else{
                    let playerData = substituteHomeArr[indexPath.row]
                    let player = playerData["player"] as? AnyObject
                    cell.lblPlayerName.text = player?["name"] as? String ?? ""
                    cell.lblPlayerNo.text = "\(player?["number"] as? Int ?? 0)"
                }
            }
            else{
                if substituteAwayArr.count == 0 || substituteAwayArr.isEmpty{
                    cell.lblPlayerName.text = "No data found"
                    cell.lblPlayerNo.text = ""
                }
                else{
                    let playerData = substituteAwayArr[indexPath.row]
                    let player = playerData["player"] as? AnyObject
                    cell.lblPlayerName.text = player?["name"] as? String ?? ""
                    cell.lblPlayerNo.text = "\(player?["number"] as? Int ?? 0)"
                }
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "coachCell", for: indexPath) as! CoachCell
            if indexPath.section == 0{
                if coachHomeArr.count == 0 || coachHomeArr.isEmpty{
                    cell.lblCoachName.text = "No data found"
                    cell.imgCoach.image = UIImage(named: "bench")
                }
                else{
                    let coachData = coachHomeArr[indexPath.row]
                    cell.lblCoachName.text = coachData["name"] as? String ?? ""
                    cell.imgCoach.sd_setImage(with: URL(string: coachData["photo"] as? String ?? ""))
                }
            }
            else{
                if coachAwayArr.count == 0 || coachAwayArr.isEmpty{
                    cell.lblCoachName.text = "No data found"
                    cell.imgCoach.image = UIImage(named: "bench")
                }
                else{
                    let coachData = coachAwayArr[indexPath.row]
                    cell.lblCoachName.text = coachData["name"] as? String ?? ""
                    cell.imgCoach.sd_setImage(with: URL(string: coachData["photo"] as? String ?? ""))
                }
            }
            return cell
        }
    }
    //MARK: Collectionview methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! LiveMatchEventCell
        let eventData = eventArr[indexPath.row]
        let timeData = eventData["time"] as? AnyObject
        cell.lblTime.text = "\(timeData?["elapsed"] as? Int ?? 0)'"
        let teamData = eventData["team"] as? AnyObject
        cell.lblTeamName.text = teamData?["name"] as? String ?? ""
        let playerData = eventData["player"] as? AnyObject
        cell.lblPlayerName.text = playerData?["name"] as? String ?? "Name not found"
        let type = eventData["type"] as? String ?? ""
       
        switch type{
        case "Goal":  cell.imgEvent.image = UIImage(named: "goalEvent")
            break
        case "Card":  let typeDetail = eventData["detail"] as? String ?? ""
            if typeDetail == "Yellow Card"{
                cell.imgEvent.image = UIImage(named: "yellowEvent")
            }
            else{
                cell.imgEvent.image = UIImage(named: "redEvent")
            }
            break
        case "Subst": cell.imgEvent.image = UIImage(named: "subEvent")
            break
        case "Var": cell.imgEvent.image = UIImage(named: "offEvent")
            break
        default: cell.imgEvent.image = UIImage(named: "footballTabBar")
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 155)
    }
    
}
