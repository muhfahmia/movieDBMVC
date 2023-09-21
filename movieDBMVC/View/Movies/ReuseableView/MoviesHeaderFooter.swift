//
//  MoviesHeaderFooter.swift
//  movieDBMVVM
//
//  Created by Muhammad Fahmi on 20/09/23.
//

import UIKit

class MoviesHeaderFooter: UICollectionReusableView {
    
    var typeMovies = ""
    
    var header: UILabel = {
        let headerTitle = UILabel()
        headerTitle.text = "Now Playing"
        headerTitle.font = UIFont(name: "Arial", size: 20)
        return headerTitle
    }()
    
    var seeAll: UILabel = {
        let see = UILabel()
        see.text = "Lihat Semua"
        see.font = UIFont(name: "Arial", size: 14)
        return see
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.seeTap(_:)))
        self.addGestureRecognizer(tap)
        
        self.addSubview(header)
        self.addSubview(seeAll)
        header.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor)
        seeAll.anchor(left: header.rightAnchor, right: rightAnchor, paddingRight: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func seeTap( _ sender: UITapGestureRecognizer? = nil) {
        print("tap tap: \(self.typeMovies)")
    }
    
}
