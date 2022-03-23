//
//  Walks.swift
//  Task8
//
//  Created by Noura Hashem on 15/03/2022.
//

import UIKit

class WalksView: UIView {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var arrowUpButton: UIButton!
    var sections = [WalkSectionsModel]()
    var dataModel = [WalkModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit(){
        let nibView = Bundle.main.loadNibNamed("Walks", owner: self, options: nil)![0] as! UIView
        nibView.frame = self.bounds
        addSubview(nibView)
        initTableView()
    }
    func initView (walks: [WalkModel]){
        dataModel = walks
        prepareSectionData(walks: dataModel)
        tableView.reloadData()
    }
    
    private func initTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        registerTableViewCells()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func registerTableViewCells() {
        let walkDetailsCellNib = UINib(nibName: Constants.tableViewCellIdentifier, bundle: .main)
        self.tableView.register(walkDetailsCellNib, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        let walksSectionHeaderNib = UINib(nibName: "WalksSectionHeader", bundle: .main)
        self.tableView.register(walksSectionHeaderNib, forHeaderFooterViewReuseIdentifier: "WalksSectionHeader")
    }
    
    private func prepareSectionData(walks: [WalkModel]){
        if !(walks.isEmpty){
            let sortedWalks = walks.sorted { WalkModel1, WalkModel2 in
                return WalkModel1.perceiveTime ?? 0 > WalkModel2.perceiveTime ?? 0
            }
            let groupedData = Dictionary(grouping: sortedWalks) { (walk) -> Int in
                return walk.perceiveTime ?? 0
            }
            sections = groupedData.map { (record) -> WalkSectionsModel in
                let timeInterval = TimeInterval(record.key)
                let date = Date(timeIntervalSince1970: timeInterval)
                let title = date.dateToString()
                let walks = record.value
                return WalkSectionsModel(title: title, walks: walks)
            }
        }
    }
    
    @IBAction func moveToTopOfTableButtonClick(_ sender: Any) {
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}

extension WalksView: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].walks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //or remove if and place return cell ?? UI
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier) as? walkDetailsCell {
            
            let element = sections[indexPath.section].walks[indexPath.row]
            
            if indexPath.section == 0 && indexPath.row == 0 {
                cell.topLineView.isHidden = true
            } else {
                cell.topLineView.isHidden = false
            }

            cell.walkScoreLabel.text = String(element.walkScore ?? 0)
            
            if element.taskTag != nil {
                if element.taskTag == "long" {
                    cell.taskTagLabel.text = "Long walk"
                } else {
                    cell.taskTagLabel.text = "Daily walk"
                }
            }
            
            if element.perceiveTime != nil {
                let timeInterval = TimeInterval(element.perceiveTime ?? 0)
                let time = Date(timeIntervalSince1970: timeInterval)
                cell.timeLabel.text = time.timeToString()
            } else {
                cell.timeLabel.text = ""
            }
            
            if element.note != nil {
                cell.noteView.isHidden = false
                cell.noteLabel.text = element.note ?? ""
            } else {
                cell.noteView.isHidden = true
            }
            
            if element.tags != [] {
                cell.tagsView.isHidden = false
                var tagsString: String = ""
                tagsString = element.tags?.joined(separator: ", ") ?? ""
                cell.tagsLabel.text = tagsString
            } else {
                cell.tagsView.isHidden = true
            }
            
            if element.rating != nil {
                cell.ratingView.isHidden = false
                switch element.rating ?? 0 {
                case 1:
                    cell.ratingLabel.text = "Awful"
                    cell.ratingImage.image = UIImage(named: "awfulSelected")
                case 2:
                    cell.ratingLabel.text = "Bad"
                    cell.ratingImage.image = UIImage(named: "badSelected")
                case 3:
                    cell.ratingLabel.text = "Fine"
                    cell.ratingImage.image = UIImage(named: "fineSelected")
                case 4:
                    cell.ratingLabel.text = "Good"
                    cell.ratingImage.image = UIImage(named: "goodSelected")
                case 5:
                    cell.ratingLabel.text = "Great"
                    cell.ratingImage.image = UIImage(named: "greatSelected")
                default:
                    break
                }
            } else {
                cell.ratingView.isHidden = true
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}

extension WalksView: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WalksSectionHeader") as? WalksSectionHeader{
            view.dateLabel.text = String(sections[section].title)
            if section == 0 {
                view.lineView.isHidden = true
            } else {
                view.lineView.isHidden = false
            }
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}

extension Date {
    func dateToString() -> String{

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
    
        let datetime = formatter.string(from: self)
        return datetime
    }
    
    func timeToString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US")

        let datetime = formatter.string(from: self)
        return datetime
    }
}
