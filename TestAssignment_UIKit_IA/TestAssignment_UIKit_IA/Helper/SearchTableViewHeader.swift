//
//  SearchTableViewHeader.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit

class SearchTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - setup UI elements
    let searchBar: CustomSearchBar = {
        let sb = CustomSearchBar()
        return sb
    }()
    
    // MARK: - init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        contentView.backgroundColor = .themeBackgroundColor
        contentView.addSubview(searchBar)
        
        // MARK: - setup auto layout constraints
        searchBar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        searchBar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 320).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
