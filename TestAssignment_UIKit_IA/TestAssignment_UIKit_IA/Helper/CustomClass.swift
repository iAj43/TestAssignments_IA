//
//  CustomClass.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit
//
// MARK: - CustomListTableView
//
class CustomListTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        separatorStyle = .none
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16 + UIConstants.homeFloatingButton.rawValue, right: 0)
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 100
        sectionHeaderHeight = UITableView.automaticDimension
        estimatedSectionHeaderHeight = CGFloat.leastNormalMagnitude
        sectionFooterHeight = CGFloat.leastNormalMagnitude
        estimatedSectionFooterHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            sectionHeaderTopPadding = 0.0
        } else {
            // Fallback on earlier versions
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomMainView
//
class CustomMainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomListMainView
//
class CustomListMainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 5.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomListImageView
//
class CustomListImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .lightGray.withAlphaComponent(0.1)
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomListTitleLabel
//
class CustomListTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .black
        font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomListSubTitleLabel
//
class CustomListSubTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        textColor = UIColor.darkGray
        font = .systemFont(ofSize: 14)
        numberOfLines = 3
        lineBreakMode = .byTruncatingTail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomFloatingButton
//
class CustomFloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .themeButtonColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomCollectionView
//
class CustomCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isPagingEnabled = true
        layer.cornerRadius = 5.0
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomPageControl
//
class CustomPageControl: UIPageControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        pageIndicatorTintColor = .lightGray
        currentPageIndicatorTintColor = .themeButtonColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
// MARK: - CustomSearchBar
//
class CustomSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundImage = UIImage()
        placeholder = "Search"
        keyboardType = .alphabet
        returnKeyType = .search
        if #available(iOS 13, *) {
            searchTextField.overrideUserInterfaceStyle = .light
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
