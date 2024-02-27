//
//  NewsVC.swift
//  ScoreLine
//
//  Created by Om Gandhi on 27/02/24.
//

import UIKit
import LinkPresentation
class NewsVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
    
    //MARK: Outlets

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var imgTop: UIImageView!
    @IBOutlet weak var tblNews: UITableView!

    //MARK: Variables
    var newsArr = [AnyObject]()
    
    //MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        imgTop.clipsToBounds = true
        imgTop.layer.cornerRadius = 20
        imgTop.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewTop.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.masksToBounds = true
        blurEffectView.layer.cornerRadius = 20
        viewTop.insertSubview(blurEffectView, at: 0)
        viewTop.clipsToBounds = true
        viewTop.layer.cornerRadius = 20
        viewTop.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        getNews()
        // Do any additional setup after loading the view.
    }
    //MARK: Webservice methods
    func getNews(){
        let newsUrl = "https://content.guardianapis.com/search?section=football&api-key=c5842567-b304-4483-8395-44d6aa050076"
        callWebServiceToFetchJsonData(strURL: newsUrl,method: HTTPMethodName.GET.rawValue){[self] response in
        let apiResponse = response?["response"] as? AnyObject
        newsArr = apiResponse?["results"] as? [AnyObject] ?? []
        tblNews.delegate = self
        tblNews.dataSource = self
        tblNews.reloadData()
        }OnFail: { err in
            print(err)
        }
    }
    
    //MARK: Tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        let news = newsArr[indexPath.row]
        let linkPreview = LPLinkView()
        let provider = LPMetadataProvider()
        let url = URL(string: news["webUrl"] as? String ?? "")!
        provider.startFetchingMetadata(for: url){metadata,error in
            guard let data = metadata, error == nil else{
                return
            }
            DispatchQueue.main.async {
                linkPreview.metadata = data
                cell.addSubview(linkPreview)
                linkPreview.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 280)
//                linkPreview.center = cell.center

            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    

}
