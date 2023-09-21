import UIKit

class MoviesController: UICollectionViewController {
    
    let labelTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = UIFont(name: "Arial", size: 20)
        return headerTitle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        
        collectionView.dataSource = self
        collectionView.register(MoviesCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(MoviesHeaderFooter.self, forSupplementaryViewOfKind: "HeaderNowPlaying", withReuseIdentifier: "Header")
        collectionView.register(MoviesHeaderFooter.self, forSupplementaryViewOfKind: "HeaderPopular", withReuseIdentifier: "Header")
        collectionView.register(MoviesHeaderFooter.self, forSupplementaryViewOfKind: "HeaderTopRated", withReuseIdentifier: "Header")
        collectionView.register(MoviesHeaderFooter.self, forSupplementaryViewOfKind: "HeaderUpComing", withReuseIdentifier: "Header")
    }
    
    init() {
        super.init(collectionViewLayout: MoviesController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load collection view")
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection in
            
            switch section {
            case 0:
                return MoviesController.createMoviesSection(headerKind: "HeaderPopular")
            case 1:
                return MoviesController.createMoviesSection(headerKind: "HeaderNowPlaying")
            case 2:
                return MoviesController.createMoviesSection(headerKind: "HeaderUpComing")
            case 3:
                return MoviesController.createMoviesSection(headerKind: "HeaderTopRated")
            default:
                return MoviesController.createMoviesSection(headerKind: "Default")
            }
            
        }
    }
    
    static func createMoviesSection (headerKind kind: String) -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem( layoutSize: .init(widthDimension: .absolute(120), heightDimension: .absolute(180)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(120), heightDimension: .absolute(180)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(1))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: kind, alignment: .top)
        section.boundarySupplementaryItems = [
            header
        ]
        
        return section
    }
}

extension MoviesController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 18
        }else{
            return 5
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! MoviesHeaderFooter
        
        if kind == "HeaderNowPlaying" {
            header.header.text = "Now Playing"
            header.typeMovies = "NowPlaying"
        }else if kind == "HeaderPopular" {
            header.header.text = "Popular"
            header.typeMovies = "Popular"
        }else if kind == "HeaderTopRated" {
            header.header.text = "Top Rated"
            header.typeMovies = "TopRated"
        }else{
            header.header.text = "Up Coming"
            header.typeMovies = "UpComing"
        }
        
        return header
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MoviesCell
        
        return cell
    }
}
