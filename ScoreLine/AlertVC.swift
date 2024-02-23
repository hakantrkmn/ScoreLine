//
//  AlertVC.swift
//  JMSC_POS_CORP_iPAD
//
//  Created by Athulya Tech on 29/12/22.
//

import UIKit

class AlertVC: UIViewController, UIGestureRecognizerDelegate {
    
    // CREATED BLOCK FOR SELECTED OBJ
    var onCompletionDone: (() -> Void)?
    var onCompletionClose: (() -> Void)?
    var onCompletionCancel: (() -> Void)?
    
    // MARK: - OUTLATES 
    @IBOutlet var vwpopup: UIView!
    @IBOutlet var lblalerttitle: UILabel!
    @IBOutlet var lblalertmsg: UILabel!
    @IBOutlet var stackvc: UIStackView!
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var btnOther: UIButton!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var imgAlert: UIImageView!
    @IBOutlet weak var viewalerttitle: UIView!
    @IBOutlet weak var titleStackview: UIStackView!
    @IBOutlet var titlehight: NSLayoutConstraint!
    
    // MARK: - VARIABLES 
    var isSingleBtn : Bool = false
    var isDissmissView : Bool = false
    var stralerttitle = ""
    var stralertmsg = ""
    var btncanceltitle = ""
    var btnothertitle = ""
    var textAlignment : NSTextAlignment = .left
    var image =  ""
    var backgroundColor = UIColor()
    var otherButtonColor = UIColor()
    var cancelButtonColor = UIColor()
    //===================================================================
    // MARK: - VIEW CONTROLLER LIFE CYCLE
    //===================================================================
    override func viewDidLoad() {
        super.viewDidLoad()

        // For Transference Background
        self.view.backgroundColor = .ecom_transparent
        
        // SET FONT
      
        
        // SET LOGO
        imgAlert.layer.cornerRadius = 10
        imgAlert.layer.borderWidth = 1.0
        imgAlert.layer.borderColor = UIColor.ecom_black?.cgColor
//        imgAlert.sd_setImage(with: URL(string: IMAGEURL + (hostSettings?.custAppThemeDetails?.first?.alertIconImage ?? "")), placeholderImage: UIImage(named: "placeholderProduct"))


    }
    //SET ALERT TITLE AND MESSAGE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.lblalerttitle.text = stralerttitle
        self.lblalerttitle.textAlignment = textAlignment
        self.lblalertmsg.text = stralertmsg
        
        //titleStackview.btnShadow()
        titleStackview.layer.cornerRadius = 10
        titleStackview.btnShadow()
        viewalerttitle.layer.cornerRadius = 10
        viewalerttitle.btnShadow()
        btnCancel.setTitle(btncanceltitle, for: .normal)
        btnOther.setTitle(btnothertitle, for: .normal)
        btnCancel.layer.cornerRadius = 10
        btnOther.layer.cornerRadius = 10
        //SET BUTTO COLORS
        btnOther.backgroundColor = otherButtonColor
        btnCancel.backgroundColor = cancelButtonColor
        
        if stralerttitle == "" {
            titlehight.constant = 0
        } else {
            titlehight.constant = 40
        }
        
        if isSingleBtn == true {
            btnCancel.isHidden = true
        } else {
            btnCancel.isHidden = false
        }
        
        if isDissmissView == true {
            tapGestureVW()
        }
        viewBack.layer.cornerRadius = 20
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // SET BACKGROUND COLOR
        self.vwpopup.backgroundColor = backgroundColor
    }
    
    //===================================================================
    // MARK: - TAPGESTURE METHODS
    //===================================================================
    func tapGestureVW() {
        // tap gesture view
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }

    //===================================================================
    // MARK: - UIBUTTON ACTIONS METHODS
    //===================================================================
    @objc func handleTap(_ sender: UITapGestureRecognizer?) {
        dismiss(animated: true)
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        if let onCompletionCancel = onCompletionCancel {
            onCompletionCancel()
        } else if let onCompletionClose = onCompletionClose {
            onCompletionClose()
        }
    }
    
    @IBAction func btnOtherClicked(_ sender: Any) {
        if (onCompletionDone != nil) {
            onCompletionDone!()
        }
    }

}
