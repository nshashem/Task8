//
//  walkDetailsCell.swift
//  Task8
//
//  Created by Noura Hashem on 15/03/2022.
//

import UIKit

class walkDetailsCell: UITableViewCell {

    @IBOutlet var baseView: UIView!
    @IBOutlet var circle: UIView!
    @IBOutlet var dataView: UIView!
    @IBOutlet var dataStackView: UIStackView!
    @IBOutlet var taskTagLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var walkScoreLabel: UILabel!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var tagsLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseViewInit()
        circleInit()
        
//        dataStackViewInit()
    }

    func baseViewInit(){
        baseView.layer.cornerRadius = 10
        baseView.clipsToBounds = true
    }
    
    func circleInit(){
        circle.layer.cornerRadius = 10 //Half of square's width or height
    }
    
    func dataStackViewInit(){
//        dataView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        dataStackView.layoutMargins = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
