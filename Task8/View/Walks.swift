//
//  Walks.swift
//  Task8
//
//  Created by Noura Hashem on 15/03/2022.
//

import UIKit

class Walks: UIView {

    @IBOutlet var tableview: UITableView!
    var tableData: [Walk]?
    @IBOutlet var arrowUpButton: UIButton!
    var groupedData: Dictionary<Int, [Walk]>?
    var itemsInSection: [[Walk]] = [[]]
    var sections: [String] = []
    
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
        tableViewInit()
        getData()
    }
    
    private func tableViewInit(){
        tableview.dataSource = self
        tableview.delegate = self
        registerTableViewCells()
        tableview.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func registerTableViewCells() {
        let cell = UINib(nibName: Keywords.tableViewCellIdentifier, bundle: .main)
        self.tableview.register(cell, forCellReuseIdentifier: Keywords.tableViewCellIdentifier)
        let cell2 = UINib(nibName: "WalksSectionHeader", bundle: .main)
        self.tableview.register(cell2, forHeaderFooterViewReuseIdentifier: "WalksSectionHeader")
    }
    
    private func getData() {
        if let path = Bundle.main.path(forResource: "Journey", ofType: "json") {
            do {
                if let jsonData = try String(contentsOfFile: path).data(using: .utf8) {
                    let decodedData = try JSONDecoder().decode(FullData.self, from: jsonData)
                    tableData = decodedData.walks
                    tableview.reloadData()
                    prepareSectionData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func prepareSectionData(){
        groupedData = Dictionary(grouping: tableData!) { (walk) -> Int in
            return walk.perceiveTime ?? 0
        }
        for (key,value) in groupedData! {
            sections.append(getDate(value: key))
            itemsInSection.append(value)
        }
    }
    
    func getDate(value: Int) -> String{
        let timeInterval = TimeInterval(value)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "en_US")
    
        let datetime = formatter.string(from: myNSDate)
        return datetime
    }
    
    func getTime(value: Int) -> String {
        let timeInterval = TimeInterval(value)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        let formatter2 = DateFormatter()
        formatter2.dateStyle = .none
        formatter2.timeStyle = .short
        formatter2.locale = Locale(identifier: "en_US")

        let datetime2 = formatter2.string(from: myNSDate)
        return datetime2
    }
    
    @IBAction func moveToTopOfTable(_ sender: Any) {
        let topRow = IndexPath(row: 0, section: 0)
//        tableview.scrollToRow(at: topRow,at: .top, animated: true)
        if (self.tableview.numberOfSections > topRow.section && self.tableview.numberOfRows(inSection: topRow.section) > topRow.row ) {
            self.tableview.scrollToRow(at: topRow, at: .top, animated: true)
        }
    }
}

extension Walks: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsInSection[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: Keywords.tableViewCellIdentifier) as? walkDetailsCell {
            
            cell.walkScoreLabel.text = String(itemsInSection[indexPath.section][indexPath.row].walkScore ?? 0)
            if itemsInSection[indexPath.section][indexPath.row].taskTag != nil  {
                if itemsInSection[indexPath.section][indexPath.row].taskTag! == "long" {
                    cell.taskTagLabel.text = "Long walk"
                } else {
                    cell.taskTagLabel.text = "Daily walk"
                }
            }
            
            if itemsInSection[indexPath.section][indexPath.row].perceiveTime != nil{
                cell.timeLabel.text = self.getTime(value: itemsInSection[indexPath.section][indexPath.row].perceiveTime!)
            } else {
                cell.timeLabel.text = ""
            }
            
            
            cell.noteLabel.isHidden = false
            if itemsInSection[indexPath.section][indexPath.row].note != nil {
                cell.noteLabel.text = itemsInSection[indexPath.section][indexPath.row].note!
            } else {
                cell.noteLabel.isHidden = true
            }
            
            cell.tagsLabel.isHidden = false
            if itemsInSection[indexPath.section][indexPath.row].tags != nil {
                var tagsString: String = ""
                tagsString = itemsInSection[indexPath.section][indexPath.row].tags!.joined(separator: ", ")
                cell.tagsLabel.text = tagsString
            } else {
                cell.tagsLabel.isHidden = true
            }
            
            cell.ratingLabel.isHidden = false
            if itemsInSection[indexPath.section][indexPath.row].rating != nil {
                switch itemsInSection[indexPath.section][indexPath.row].rating! {
                case 1:
                    cell.ratingLabel.text = "Awful"
                case 2:
                    cell.ratingLabel.text = "Bad"
                case 3:
                    cell.ratingLabel.text = "Fine"
                case 4:
                    cell.ratingLabel.text = "Good"
                case 5:
                    cell.ratingLabel.text = "Great"
                default:
                    break
                }
            } else {
                cell.ratingLabel.isHidden = true 
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}

extension Walks: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableview.dequeueReusableHeaderFooterView(withIdentifier: "WalksSectionHeader") as? WalksSectionHeader{
            view.dateLabel.text = String(sections[section])
            return view
        }
        return UIView()
    }
}
