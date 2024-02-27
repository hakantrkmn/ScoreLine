//
//  HomeVC.swift
//  ScoreLine
//
//  Created by Om Gandhi on 22/02/24.
//

import UIKit
import Alamofire
import SDWebImage
class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{
    
    
    //MARK: Outlets
    
    @IBOutlet weak var viewNoLive: UIView!
    @IBOutlet weak var clcLiveFixtures: UICollectionView!
    
    @IBOutlet weak var viewTblHeader: UIView!
    @IBOutlet weak var livePageControl: UIPageControl!
    
    @IBOutlet weak var tblUpcomingFixtures: UITableView!
    //MARK: Variables
    var livefixtureArr = [AnyObject]()
    var upcomingfixtureArr = [AnyObject]()
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        liveMatchData()
        upcomingMatchData()
        // Do any additional setup after loading the view.
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        
        livePageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        //        livePageControl.setCurrentPageIndicatorImage(UIImage(named: "football"), forPage: livePageControl.currentPage)
    }
    //MARK: Webservice methods
    func liveMatchData(){
        let liveFixtureUrl = "https://\(apiHost)/fixtures?live=all"
        let headers:HTTPHeaders = ["x-rapidapi-key" : api_key,
                                   "x-rapidapi-host" : apiHost]
        callWebServiceToFetchJsonData(strURL: liveFixtureUrl,headers: headers){[self] response in
            livefixtureArr = response?["response"] as? [AnyObject] ?? []
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = viewNoLive.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.layer.masksToBounds = true
            blurEffectView.layer.cornerRadius = 20
            viewNoLive.insertSubview(blurEffectView, at: 0)
            if livefixtureArr.count == 0 || livefixtureArr.isEmpty {
                viewNoLive.isHidden = false
                clcLiveFixtures.isHidden = true
            }
            else{
                viewNoLive.isHidden = true
                clcLiveFixtures.isHidden = false
            }
            clcLiveFixtures.delegate = self
            clcLiveFixtures.dataSource = self
            clcLiveFixtures.reloadData()
            livePageControl.numberOfPages = livefixtureArr.count
            livePageControl.currentPage = 0
            //            livePageControl.setCurrentPageIndicatorImage(UIImage(named: "football"), forPage: 0)
        }OnFail: { err in
            print(err)
        }
    }
    func upcomingMatchData(){
        let upcomingFixtureUrl = "https://\(apiHost)/fixtures?next=20"
        let headers:HTTPHeaders = ["x-rapidapi-key" : api_key,
                                   "x-rapidapi-host" : apiHost]
        callWebServiceToFetchJsonData(strURL: upcomingFixtureUrl,headers: headers){[self] response in
            upcomingfixtureArr = response?["response"] as? [AnyObject] ?? []
            
            tblUpcomingFixtures.delegate = self
            tblUpcomingFixtures.dataSource = self
            tblUpcomingFixtures.tableHeaderView = viewTblHeader
            tblUpcomingFixtures.reloadData()
            
        }OnFail: { err in
            print(err)
        }
    }
    //MARK: Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingfixtureArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as! UpcomingFixtureCell
        
        cell.selectionStyle = .none
        let upcomingMatchData = upcomingfixtureArr[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let matchData = upcomingMatchData["fixture"] as? AnyObject
        let date = dateFormatter.date(from: matchData?["date"] as? String ?? "")
        
        let properDateFormatter = DateFormatter()
        properDateFormatter.dateFormat = "d MMM, h:mm a"
        let properDate = properDateFormatter.string(from: date ?? Date()) 
        
        cell.lblDate.text = properDate
        let teams = upcomingMatchData["teams"] as? AnyObject
        let homeTeam = teams?["home"] as? AnyObject
        let awayTeam = teams?["away"] as? AnyObject
        cell.imgHome.sd_setImage(with: URL(string: homeTeam?["logo"] as? String ?? "" ))
        cell.imgAway.sd_setImage(with: URL(string: awayTeam?["logo"] as? String ?? "" ))
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = cell.viewBack.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.masksToBounds = true
        blurEffectView.layer.cornerRadius = 20
        cell.viewBack.insertSubview(blurEffectView, at: 0)
        cell.viewBack.viewShadow()
        cell.viewBack.layer.cornerRadius = 20
        return cell
    }
    //MARK: Collectionview methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return livefixtureArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveCell", for: indexPath) as! LiveMatchCell
        //MARK: Live Data Insert code
        let liveMatchData = livefixtureArr[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let matchData = liveMatchData["fixture"] as? AnyObject
        let date = dateFormatter.date(from: matchData?["date"] as? String ?? "")
        
        let properDateFormatter = DateFormatter()
        properDateFormatter.dateFormat = "d MMM, h:mm a"
        let properDate = properDateFormatter.string(from: date ?? Date())
        
        cell.lblDateTime.text = properDate
        let teams = liveMatchData["teams"] as? AnyObject
        let homeTeam = teams?["home"] as? AnyObject
        let awayTeam = teams?["away"] as? AnyObject
        let scores = liveMatchData["goals"] as? AnyObject
        cell.imgHome.sd_setImage(with: URL(string: homeTeam?["logo"] as? String ?? "" ))
        cell.imgAway.sd_setImage(with: URL(string: awayTeam?["logo"] as? String ?? "" ))
        cell.lblHomeName.text = homeTeam?["name"] as? String ?? ""
        cell.lblAwayName.text = awayTeam?["name"] as? String ?? ""
        cell.lblHomeScore.text = String(scores?["home"] as? Int ?? 0)
        cell.lblAwayScore.text = String(scores?["away"] as? Int ?? 0)
        
        let venueData = matchData?["venue"] as? AnyObject
        cell.lblVenue.text = venueData?["name"] as? String ?? ""
        
        let matchStatus = matchData?["status"] as? AnyObject
        cell.lblStatus.text = "\(matchStatus?["long"] as? String ?? ""), \(matchStatus?["elapsed"] as? Int ?? 0)'"
        
        //MARK: Live Data cell design code
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = cell.viewBack.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.masksToBounds = true
        blurEffectView.layer.cornerRadius = 20
        cell.viewBack.insertSubview(blurEffectView, at: 0)
        cell.viewBack.viewShadow()
        cell.viewBack.layer.cornerRadius = 30
        return cell
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width - 10, height: 330)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let liveMatchData = livefixtureArr[indexPath.row]
        let matchData = liveMatchData["fixture"] as AnyObject
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "matchStory") as! MatchVC
        vc.matchData = matchData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: Button Methods
    
    @IBAction func pageControl(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
        var frame: CGRect = self.clcLiveFixtures.frame
        frame.origin.x = frame.size.width * CGFloat(page ?? 0)
        frame.origin.y = 0
        self.clcLiveFixtures.scrollRectToVisible(frame, animated: true)
    }
}
