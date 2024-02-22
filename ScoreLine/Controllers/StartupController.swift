//
//  StartupController.swift
//  ScoreLine
//
//  Created by Om Gandhi on 16/02/24.
//

import UIKit

class StartupController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK: Outlets
    @IBOutlet weak var clcStartupImages: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: Variables
    var startupImageArr = ["CR7","LM10","NS11"]
    var startupTextArr = ["Welcome to Football Fever! Where every kick, every goal, and every victory matters.", "Stay tuned for the latest scores, highlights, and news from the world of football.","Let's kick off the excitement together!"]
    
    //MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.setCurrentPageIndicatorImage(UIImage(named: "football"), forPage: 0)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let horizontalCenter = width / 2

            pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        pageControl.setCurrentPageIndicatorImage(UIImage(named: "football"), forPage: pageControl.currentPage)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return startupImageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "startupCell", for: indexPath) as! StartupScreenCell
        cell.imgStartup.image = UIImage(named: startupImageArr[indexPath.row])
        
        cell.btnGetStarted.layer.cornerRadius = 30
        
        if indexPath.row == startupImageArr.count - 1{
            cell.btnGetStarted.isHidden = false
            cell.lblSwipeText.isHidden = true
        }
        else
        {
            cell.btnGetStarted.isHidden = true
            cell.lblSwipeText.isHidden = false
        }
        cell.lblStartupText.text = startupTextArr[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    @IBAction func pageAction(_ sender: UIPageControl) {
        let page: Int? = sender.currentPage
            var frame: CGRect = self.clcStartupImages.frame
            frame.origin.x = frame.size.width * CGFloat(page ?? 0)
            frame.origin.y = 0
            self.clcStartupImages.scrollRectToVisible(frame, animated: true)
    }
}
