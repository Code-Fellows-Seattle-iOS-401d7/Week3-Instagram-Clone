//
//  Post.swift
//  PicFeed
//
//  Created by Filiz Kurban on 10/25/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit


class Post {
    let image: UIImage

    init(image: UIImage = UIImage()) {
        self.image = image
    }
}

extension Post {
    class func identifier() -> String {
        return String(describing: self)
    }
}

