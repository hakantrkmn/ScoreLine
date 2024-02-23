//
//  HomeVC.swift
//  ScoreLine
//
//  Created by Om Gandhi on 22/02/24.
//

import UIKit
import Alamofire
import SDWebImage
class HomeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  //MARK: Outlets
    
    @IBOutlet weak var clcLiveFixtures: UICollectionView!
    
    @IBOutlet weak var clcUpcomingFixtures: UICollectionView!
    @IBOutlet weak var livePageControl: UIPageControl!
    @IBOutlet weak var upcomingPageControl: UIPageControl!
    //MARK: Variables
    var livefixtureArr = [AnyObject]()
    var upcomingfixtureArr = [AnyObject]()
    //MARK: ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let liveFixtureUrl = "https://v3.football.api-sports.io/fixtures?live=all"
        let headers:HTTPHeaders = ["x-rapidapi-key" : "ef202dc7c88478fd5250d7c20a7d5f7c",
            "x-rapidapi-host" : "v3.football.api-sports.io"]
        callWebServiceToFetchJsonData(strURL: liveFixtureUrl,headers: headers){[self] response in
            livefixtureArr = response?["response"] as? [AnyObject] ?? []
            clcLiveFixtures.delegate = self
            clcLiveFixtures.dataSource = self
            
            livePageControl.numberOfPages = livefixtureArr.count
            livePageControl.currentPage = 0
//            livePageControl.setCurrentPageIndicatorImage(UIImage(named: "football"), forPage: 0)
        }OnFail: { err in
            err
        }
    }
    func upcomingMatchData(){
        let upcomingFixtureUrl = "https://v3.football.api-sports.io/fixtures?next=10"
        let headers:HTTPHeaders = ["x-rapidapi-key" : "ef202dc7c88478fd5250d7c20a7d5f7c",
            "x-rapidapi-host" : "v3.football.api-sports.io"]
        callWebServiceToFetchJsonData(strURL: upcomingFixtureUrl,headers: headers){[self] response in
            upcomingfixtureArr = response?["response"] as? [AnyObject] ?? []
           
            
            clcUpcomingFixtures.delegate = self
            clcUpcomingFixtures.dataSource = self
            
            livePageControl.numberOfPages = livefixtureArr.count
            livePageControl.currentPage = 0
            
            
//            livePageControl.setCurrentPageIndicatorImage(UIImage(named: "football"), forPage: 0)
        }OnFail: { err in
            err
        }
    }
    
    
//MARK: Collectionview methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clcLiveFixtures{
            return livefixtureArr.count
        }
        return upcomingfixtureArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clcLiveFixtures{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveCell", for: indexPath) as! LiveMatchCell
            //MARK: Live Data Insert code
            let liveMatchData = livefixtureArr[indexPath.row]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let matchData = liveMatchData["fixture"] as? AnyObject
            let date = dateFormatter.date(from: matchData?["date"] as? String ?? "")
        
            let properDateFormatter = DateFormatter()
            properDateFormatter.dateFormat = "d MMM, h:mm a"
            let properDate = properDateFormatter.string(from: date ?? Date()) ?? ""
            
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
            
            cell.layer.cornerRadius = 30
            cell.backgroundColor = UIColor(named: "primaryBack")
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as! UpcomingFixtureCell
            //MARK: Upcoming match Data insert code
            let upcomingMatchData = upcomingfixtureArr[indexPath.row]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            let matchData = upcomingMatchData["fixture"] as? AnyObject
            let date = dateFormatter.date(from: matchData?["date"] as? String ?? "")
        
            let properDateFormatter = DateFormatter()
            properDateFormatter.dateFormat = "d MMM, h:mm a"
            let properDate = properDateFormatter.string(from: date ?? Date()) ?? ""
            
            cell.lblDate.text = properDate
            let teams = upcomingMatchData["teams"] as? AnyObject
            let homeTeam = teams?["home"] as? AnyObject
            let awayTeam = teams?["away"] as? AnyObject
            let scores = upcomingMatchData["goals"] as? AnyObject
            cell.imgHome.sd_setImage(with: URL(string: homeTeam?["logo"] as? String ?? "" ))
            cell.imgAway.sd_setImage(with: URL(string: awayTeam?["logo"] as? String ?? "" ))
           
            //MARK: Upcoming Data cell design code
            
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clcLiveFixtures{
            return CGSize(width: collectionView.frame.size.width - 10, height: 330)
        }
        return CGSize(width: collectionView.frame.size.width - 10, height: 110)
        
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
