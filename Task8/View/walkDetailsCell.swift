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
    @IBOutlet var noteView: UIView!
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var tagsView: UIView!
    @IBOutlet var tagsLabel: UILabel!
    @IBOutlet var ratingView: UIView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet var ratingImage: UIImageView!
    @IBOutlet weak var topLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initBaseView()
        initCircle()
    }

    func initBaseView(){
        baseView.layer.cornerRadius = 10
        baseView.clipsToBounds = true
    }
    
    func initCircle(){
        circle.layer.cornerRadius = 10 //Half of square's width or height
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
