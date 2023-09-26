//
//  MoviesDetailController.swift
//  movieDBMVC
//
//  Created by Muhammad Fahmi on 21/09/23.
//

import UIKit
import Dispatch

class MoviesDetailController: UICollectionViewController {
    private var movie: MoviesDetailResponse?
    var movieID: Int?
    var dispatch = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        
        collectionView.dataSource = self
        collectionView.register(MoviesDetailCell.self, forCellWithReuseIdentifier: "moviesDetailCell")
        
        dispatch.enter()
        NetworkService.sharedService.getDetailMovies(detailID: String(movieID!), result: {
            result in
            switch result {
            case .success(let data):
                self.movie = data
            case .failure(let error):
                print(error)
            }
            self.dispatch.leave()
        })
        
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
        dispatch.notify(queue: .main) {
            NetworkService.sharedService.getImageFromSDWeb(withUrl: self.movie!.imageUrl, imageView: cell.moviesImage)
            cell.moviesTitle.text = self.movie?.title
            cell.moviesTitleDesc.text = self.movie?.description
        }
        return cell
    }
}
