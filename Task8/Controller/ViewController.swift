//
//  ViewController.swift
//  Task8
//
//  Created by Noura Hashem on 15/03/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainView: WalksView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let dataModel: [WalkModel] = WalksDataManager.getData() 
        
        mainView.dataModel = dataModel
    }


}

