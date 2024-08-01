//
//  HomeController.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit
// MARK: - HomeControllerDelegate
protocol HomeControllerDelegate {
    func currentVisibleItem(_ index: Int)
}
//
// MARK: - HomeController
//
class HomeController: UIViewController {
    
    // MARK: - setup variables
    private var homeViewModel: HomeViewModel?
    private var navigationBarTitle: String = ""
    private var selectedIndex: Int = 0
    
    // MARK: - setup UI elements
    lazy var mainTableView: CustomListTableView = {
        let tv = CustomListTableView(frame: .zero, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.register(MealTypesTableViewCell.self, forCellReuseIdentifier: ReuseIDConstants.mealTypesTVCellID.rawValue)
        tv.register(MealListTableViewCell.self, forCellReuseIdentifier: ReuseIDConstants.mealListTVCellID.rawValue)
        tv.register(SearchTableViewHeader.self, forHeaderFooterViewReuseIdentifier: ReuseIDConstants.searchTVHeaderID.rawValue)
        return tv
    }()
    
    lazy var homeFloatingButton: CustomFloatingButton = {
        let button = CustomFloatingButton()
        button.setImage(UIImage(named: ImageConstants.ic_home_floating.rawValue), for: .normal)
        button.addTarget(self, action: #selector(handleHomeFloatingButton), for: .touchUpInside)
        button.layer.applyCornerRadiusShadow(
            color: .black,
            alpha: 0.38,
            x: 0,
            y: 3,
            blur: 10,
            spread: 0,
            cornerRadiusValue: UIConstants.homeFloatingButton.rawValue / 2.0
        )
        return button
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
    
    func getData() {
        homeViewModel = HomeViewModel()
        homeViewModel?.getLocalJSONData(completion: { isSuccessFlag, error in
            if !isSuccessFlag {
                self.showAlert(title: CommonMessages.failed.rawValue, message: error?.localizedDescription ?? "", duration: 2.0)
            } else {
                if let unwrappedArray = self.homeViewModel?.viewModelPublishers.mealTypesDetailData,
                   !unwrappedArray.isEmpty {
                    self.navigationBarTitle = self.homeViewModel?.viewModelPublishers.mealTypesDetailData?.first?.typeTitle ?? ""
                    self.title = self.navigationBarTitle
                    self.homeViewModel?.viewModelPublishers.selection = self.selectedIndex
                    self.homeViewModel?.filterListData()
                } else {
                    self.showAlert(title: CommonMessages.noRecordsFound.rawValue, message: "", duration: 2.0)
                }
            }
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        })
    }
    
    @objc func handleHomeFloatingButton(_ sender: UIButton) {
        var dataArray: [String]?
        dataArray = [String]()
        if let listData = homeViewModel?.viewModelPublishers.mealTypesDetailData?[selectedIndex].listData as? [ListData] {
            let titles = listData.map { $0.title ?? "" }
            let dictionary = homeViewModel?.topThreeCharacters(in: titles)
            dictionary?.forEach({ item in
                dataArray?.append("\(item.character.uppercased()) = \(item.count)")
            })
            guard let popupViewController = CustomPopupView.instantiate() else { return }
            popupViewController.delegate = self
            popupViewController.titleString = "\(navigationBarTitle) (\(listData.count) items)"
            popupViewController.dataArray = dataArray
            let popupVC = BottomSheetViewController(
                contentController: popupViewController,
                position: .bottom(0),
                popupWidth: self.view.frame.width,
                popupHeight: UIConstants.bottomPopupHeight.rawValue
            )
            popupVC.cornerRadius = 15
            popupVC.backgroundAlpha = 0.0
            popupVC.backgroundColor = .clear
            popupVC.canTapOutsideToDismiss = true
            popupVC.shadowEnabled = true
            popupVC.delegate = self
            popupVC.modalPresentationStyle = .popover
            self.present(popupVC, animated: true, completion: nil)
        } else {
            self.showAlert(title: CommonMessages.noRecordsFound.rawValue, message: "", duration: 2.0)
        }
    }
}
//
// MARK: - setupUI
//
extension HomeController {
    
    func setupUI() {
        view.backgroundColor = .themeBackgroundColor
        view.addSubview(mainTableView)
        view.addSubview(homeFloatingButton)
        
        // MARK: - setup auto layout constraints
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        homeFloatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        homeFloatingButton.widthAnchor.constraint(equalToConstant: UIConstants.homeFloatingButton.rawValue).isActive = true
        homeFloatingButton.heightAnchor.constraint(equalToConstant: UIConstants.homeFloatingButton.rawValue).isActive = true
        if #available(iOS 13.0, *) {
            homeFloatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        } else {
            homeFloatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        }
    }
}
//
// MARK: - UITableViewDataSource
//
extension HomeController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            if let unwrappedMealTypesDetailData = homeViewModel?.viewModelPublishers.mealTypesDetailData,
               unwrappedMealTypesDetailData.count > 0 {
                return 1
            } else {
                return 0
            }
        case 2:
            return homeViewModel?.viewModelPublishers.filteredList.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let unwrappedCell = tableView.dequeueReusableCell(withIdentifier: ReuseIDConstants.mealTypesTVCellID.rawValue, for: indexPath) as? MealTypesTableViewCell else { return UITableViewCell() }
            unwrappedCell.homeControllerDelegate = self
            unwrappedCell.setupData(homeViewModel?.viewModelPublishers.mealTypesDetailData)
            return unwrappedCell
        case 2:
            guard let unwrappedCell = tableView.dequeueReusableCell(withIdentifier: ReuseIDConstants.mealListTVCellID.rawValue, for: indexPath) as? MealListTableViewCell else { return UITableViewCell() }
            unwrappedCell.setterObj = homeViewModel?.viewModelPublishers.filteredList[indexPath.row]
            return unwrappedCell
        default:
            return UITableViewCell()
        }
    }
}
//
// MARK: - UITableViewDelegate
//
extension HomeController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0,2:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2,
           let unwrappedMealTypesDetailData = homeViewModel?.viewModelPublishers.mealTypesDetailData,
           unwrappedMealTypesDetailData.count > 0 {
            return 60
        } else {
            return CGFloat.leastNormalMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 {
            guard let unwrappedHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReuseIDConstants.searchTVHeaderID.rawValue) as? SearchTableViewHeader else { return nil }
            unwrappedHeader.searchBar.delegate = self
            return unwrappedHeader
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
//
// MARK: - HomeControllerDelegate methods
//
extension HomeController: HomeControllerDelegate {
    
    func currentVisibleItem(_ index: Int) {
        self.navigationBarTitle = homeViewModel?.viewModelPublishers.mealTypesDetailData?[selectedIndex].typeTitle ?? ""
        self.title = self.navigationBarTitle
        self.selectedIndex = index
        homeViewModel?.viewModelPublishers.selection = self.selectedIndex
        homeViewModel?.filterListData()
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}
//
// MARK: - UISearchBarDelegate methods
//
extension HomeController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        homeViewModel?.viewModelPublishers.searchText = searchText.lowercased()
        homeViewModel?.filterListData()
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location == 0 && text == " " { // prevent space on first character
            return false
        }
        
        if searchBar.text?.last == " " && text == " " { // allowed only single space
            return false
        }
        
        if text == " " { return true } // now allowing space between name
        
        if text.rangeOfCharacter(from: CharacterSet.letters.inverted) != nil {
            return false
        }
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        homeViewModel?.viewModelPublishers.searchText = searchBar.searchTextField.text ?? ""
        homeViewModel?.filterListData()
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.searchTextField.text = nil
        homeViewModel?.viewModelPublishers.searchText = ""
        homeViewModel?.filterListData()
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
//
// MARK: - BottomSheetViewControllerDelegate, CustomPopupViewDelegate
//
extension HomeController: BottomSheetViewControllerDelegate, CustomPopupViewDelegate {
    
    public func popupViewControllerDidDismissByTapGesture(_ sender: BottomSheetViewController) {
        dismiss(animated: true) {
            //            print("Popup Dismiss")
        }
    }
    
    func customPopupViewExtension(sender: CustomPopupView, didSelectNumber: Int) {
        dismiss(animated: true) {
            if didSelectNumber == 1 {
                //                print("Custom Popup Dismiss On Done Button Action")
            }
        }
    }
}
