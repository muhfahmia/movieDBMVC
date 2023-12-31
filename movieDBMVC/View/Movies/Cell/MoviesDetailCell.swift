//
//  MoviesDetailCell.swift
//  movieDBMVC
//
//  Created by Muhammad Fahmi on 21/09/23.
//

import UIKit

class MoviesDetailCell: UICollectionViewCell {
    
    var moviesImage: UIImageView = {
        let mi = UIImageView()
        mi.image = UIImage(named: "movieDetailImage.jpeg")
        mi.contentMode = .scaleToFill
        return mi
    }()
    
    var moviesTitle: UILabel = {
        let ml = UILabel()
        ml.translatesAutoresizingMaskIntoConstraints = false
        ml.textColor = .black
        ml.font = UIFont(name: "Arial", size: 24)
        ml.numberOfLines = 0
        return ml
    }()
    
    var moviesTitleDesc: UILabel = {
        let ml = UILabel()
        ml.translatesAutoresizingMaskIntoConstraints = false
        ml.textColor = .black
        ml.font = UIFont(name: "Arial", size: 20)
        ml.numberOfLines = 0
        return ml
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(moviesImage)
        addSubview(moviesTitle)
        addSubview(moviesTitleDesc)
        moviesImage.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 250)
        moviesTitle.anchor(top: moviesImage.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        moviesTitleDesc.anchor(top: moviesTitle.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingRight: 15)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
