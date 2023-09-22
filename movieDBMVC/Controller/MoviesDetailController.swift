//
//  MoviesDetailController.swift
//  movieDBMVC
//
//  Created by Muhammad Fahmi on 21/09/23.
//

import UIKit

class MoviesDetailController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        collectionView.delegate = self
        
        collectionView.dataSource = self
        collectionView.register(MoviesDetailCell.self, forCellWithReuseIdentifier: "moviesDetailCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movies Detail"
//        print("will appear")
    }
    init() {
        super.init(collectionViewLayout: MoviesDetailController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("cannot load collectionview")
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection in
            
            switch section {
            case 0:
                return MoviesDetailController.createMoviesDetailSection()
            default:
                return MoviesDetailController.createMoviesDetailSection()
            }
            
        }
    }
    
    
    static func createMoviesDetailSection () -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem( layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
        
//        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                     heightDimension: .estimated(1))
//
//        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: kind, alignment: .top)
//        section.boundarySupplementaryItems = [
//            header
//        ]
        
        return section
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //jumlah section pada halaman
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //jumlah item per section
        if section == 0 {
            return 1
        }else{
            return 5
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesDetailCell", for: indexPath) as! MoviesDetailCell

        return cell
    }
    
}
