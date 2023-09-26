import UIKit
import Dispatch
import SDWebImage

class MoviesController: UICollectionViewController {
    
    let labelTitle: UILabel = {
        let headerTitle = UILabel()
        headerTitle.font = UIFont(name: "Arial", size: 20)
        return headerTitle
    }()
    
    let alert = UIAlertController(
        title: "Title",
        message: "Message",
        preferredStyle: .actionSheet
    )
    
    
    let moviesNavTitle = "Movies"
    
    private var moviesP: [MoviesObject] = []
    private var moviesNP: [MoviesObject] = []
    private var moviesUC: [MoviesObject] = []
    private var moviesTR: [MoviesObject] = []
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = moviesNavTitle
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MoviesCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(MoviesHeaderFooter.self, forSupplementaryViewOfKind: "HeaderNowPlaying", withReuseIdentifier: "Header")
        collectionView.register(MoviesHeaderFooter.self, forSupplementaryViewOfKind: "HeaderPopular", withReuseIdentifier: "Header")
        collectionView.register(MoviesHeaderFooter.self, forSupplementaryViewOfKind: "HeaderTopRated", withReuseIdentifier: "Header")
        collectionView.register(MoviesHeaderFooter.self, forSupplementaryViewOfKind: "HeaderUpComing", withReuseIdentifier: "Header")
        
        self.getSourceData()
        
    }
    
    
    init() {
        super.init(collectionViewLayout: MoviesController.createLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("Cannot load collection view")
    }
    
    private func getSourceData() {
        dispatchGroup.enter()
        NetworkService.sharedService.getMovies(typeMovies: Endpoints.movieDB.moviesNowPlaying.url, result: {
            result in
            switch result {
            case .success(let data):
                self.moviesNP = data
            case .failure(let error):
                print(error)
            }
            self.dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        NetworkService.sharedService.getMovies(typeMovies: Endpoints.movieDB.moviesPopular.url ,result: {
            result in
            switch result {
            case .success(let data):
                self.moviesP = data
            case .failure(let error):
                print(error)
            }
            self.dispatchGroup.leave()
        })
//
        dispatchGroup.enter()
        NetworkService.sharedService.getMovies(typeMovies: Endpoints.movieDB.moviesUpComing.url ,result: {
            result in
            switch result {
            case .success(let data):
                self.moviesUC = data
            case .failure(let error):
                print(error)
            }
            self.dispatchGroup.leave()
        })

        dispatchGroup.enter()
        NetworkService.sharedService.getMovies(typeMovies: Endpoints.movieDB.moviesTopRated.url ,result: {
            result in
            switch result {
            case .success(let data):
                self.moviesTR = data
            case .failure(let error):
                print(error)
            }
            self.dispatchGroup.leave()
        })
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


//DATA SOURCE
extension MoviesController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
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
       
        let indexSection = indexPath.section
        let indexRow = indexPath.row
        
        dispatchGroup.notify(queue: .main) {
            if indexSection == 0 {
                let movies = self.moviesP[indexRow]
                cell.moviesTitle.text = movies.title
                cell.moviesImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                NetworkService.sharedService.getImageFromSDWeb(withUrl: movies.imageUrl, imageView: cell.moviesImage)
            }else if indexSection == 1 {
                let movies = self.moviesNP[indexRow]
                cell.moviesTitle.text = movies.title
                cell.moviesImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                NetworkService.sharedService.getImageFromSDWeb(withUrl: movies.imageUrl, imageView: cell.moviesImage)
            }else if indexSection == 2 {
                let movies = self.moviesUC[indexRow]
                cell.moviesTitle.text = movies.title
                cell.moviesImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                NetworkService.sharedService.getImageFromSDWeb(withUrl: movies.imageUrl, imageView: cell.moviesImage)
            }else if indexSection == 3 {
                let movies = self.moviesTR[indexRow]
                cell.moviesTitle.text = movies.title
                cell.moviesImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                NetworkService.sharedService.getImageFromSDWeb(withUrl: movies.imageUrl, imageView: cell.moviesImage)
            }
        }
        
        return cell
    }
}

//DELEGATE
extension MoviesController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moviesDetailController = MoviesDetailController()
        moviesDetailController.hidesBottomBarWhenPushed = true
        let indexSection = indexPath.section
        
        if indexSection == 0 {
            moviesDetailController.movieID = self.moviesP[indexPath.row].id
        }else if indexSection == 1 {
            moviesDetailController.movieID = self.moviesNP[indexPath.row].id
        }else if indexSection == 2 {
            moviesDetailController.movieID = self.moviesUC[indexPath.row].id
        }else {
            moviesDetailController.movieID = self.moviesTR[indexPath.row].id
        }
        
        navigationController?.pushViewController(moviesDetailController, animated: true)
    }
}
