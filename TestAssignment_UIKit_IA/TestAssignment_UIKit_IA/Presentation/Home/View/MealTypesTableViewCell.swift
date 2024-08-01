//
//  MealTypesTableViewCell.swift
//  TestAssignment_UIKit_IA
//
//  Created by NeoSOFT on 01/08/24.
//

import UIKit

class MealTypesTableViewCell: UITableViewCell {
    
    // MARK: - setup variables
    var homeControllerDelegate: HomeControllerDelegate? = nil
    var mealTypesDetailData: [MealTypesDetailData]?
    
    // MARK: - setup UI elements
    let mainView: CustomMainView = {
        let view = CustomMainView()
        return view
    }()
    
    lazy var mainCollectionView: CustomCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let cv = CustomCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.register(MealTypesCollectionViewCell.self, forCellWithReuseIdentifier: ReuseIDConstants.mealTypesCVCellID.rawValue)
        return cv
    }()
    
    lazy var pageControl: CustomPageControl = {
        let pc = CustomPageControl()
        return pc
    }()
    
    // MARK: - setupData
    func setupData(_ data: [MealTypesDetailData]?) {
        mealTypesDetailData = data
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(mainView)
        mainView.addSubview(mainCollectionView)
        mainView.addSubview(pageControl)
        
        // MARK: - setup auto layout constraints
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        
        mainCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        mainCollectionView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -2).isActive = true
        
        pageControl.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 40).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -40).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
// MARK: - UICollectionViewDataSource
//
extension MealTypesTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mealTypesDetailData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let unwrappedCell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIDConstants.mealTypesCVCellID.rawValue, for: indexPath) as? MealTypesCollectionViewCell else { return UICollectionViewCell() }
        if let unwrappedTypeImage = mealTypesDetailData?[indexPath.item].typeImage,
           !unwrappedTypeImage.isEmpty {
            unwrappedCell.thumbnailImageView.image = UIImage(named: unwrappedTypeImage)
        } else {
            unwrappedCell.thumbnailImageView.image = nil
        }
        return unwrappedCell
    }
}
//
// MARK: - UICollectionViewDelegate
//
extension MealTypesTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.item
        pageControl.numberOfPages = mealTypesDetailData?.count ?? 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = mainCollectionView.contentOffset
        visibleRect.size = mainCollectionView.bounds.size
        let visiblePoint = CGPoint(x: CGFloat(visibleRect.midX), y: CGFloat(visibleRect.midY))
        let visibleIndexPathItem: Int = mainCollectionView.indexPathForItem(at: visiblePoint)?.item ?? 0
        homeControllerDelegate?.currentVisibleItem(visibleIndexPathItem)
    }
}
//
// MARK: - UICollectionViewDelegateFlowLayout
//
extension MealTypesTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
