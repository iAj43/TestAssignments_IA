//
//  CustomPopupView.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit

protocol CustomPopupViewDelegate: AnyObject{
    func customPopupViewExtension(sender: CustomPopupView, didSelectNumber: Int)
}

class CustomPopupView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - setup variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    var titleString: String?
    var dataArray: [String]?
    
    weak var delegate: CustomPopupViewDelegate?
    static func instantiate() -> CustomPopupView? {
        return CustomPopupView(nibName: nil, bundle: nil)
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleString ?? ""
        doneButton.layer.cornerRadius = 5.0
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    @objc func doneButtonAction() {
        delegate?.customPopupViewExtension(sender: self, didSelectNumber: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.textLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        cell.textLabel?.textColor = .darkGray
        cell.textLabel?.text = dataArray?[indexPath.row]
        return cell
    }
}
