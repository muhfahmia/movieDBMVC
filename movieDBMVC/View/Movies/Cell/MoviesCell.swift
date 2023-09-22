//
//  MoviesCell.swift
//  movieDBMVVM
//
//  Created by Muhammad Fahmi on 19/09/23.
//

import UIKit

class MoviesCell: UICollectionViewCell {
    
    var moviesImage: UIImageView = {
        let mi = UIImageView()
//        mi.image = UIImage(named: "movieImage.jpeg")
        mi.contentMode = .scaleToFill
        return mi
    }()
    
    fileprivate let moviesImageLoading: UIActivityIndicatorView = {
       let mil = UIActivityIndicatorView()
        return mil
    }()
    
    var moviesTitle: UILabel = {
        let ml = UILabel()
        ml.text = "Unknown Title Unknown Title Unknown Title Unknown Title Unknown Title"
        ml.translatesAutoresizingMaskIntoConstraints = false
        ml.textColor = .black
        ml.font = UIFont(name: "Arial", size: 12)
        ml.numberOfLines = 2
        return ml
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 0.3
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.moviesDetail(_:)))
//        self.addGestureRecognizer(tap)
        
        addSubview(moviesImage)
        addSubview(moviesTitle)
//        addSubview(moviesImageLoading)
//        
//        moviesImageLoading.center(inView: moviesImage)
//        
//        moviesImageLoading.startAnimating()
        
        moviesImage.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        moviesTitle.anchor(top: moviesImage.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, height: 30)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func moviesDetail( _ sender: UITapGestureRecognizer? = nil) {
        print("tap tap: moviesDetail")
    }
    
}
