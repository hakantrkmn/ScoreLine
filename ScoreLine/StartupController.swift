//
//  StartupController.swift
//  ScoreLine
//
//  Created by Om Gandhi on 16/02/24.
//

import UIKit

class StartupController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //MARK: Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: Variables
    var startupImageArr = ["CR7","LM10","NS11"]
    
    //MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0

        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
            let width = scrollView.frame.width
            let horizontalCenter = width / 2

            pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "startupCell", for: indexPath) as! StartupScreenCell
        cell.imgStartup.image = UIImage(named: startupImageArr[indexPath.row])
        
        if indexPath.row == startupImageArr.count{
            cell.btnGetStarted.isHidden = false
        }
        else
        {
            cell.btnGetStarted.isHidden = true
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
