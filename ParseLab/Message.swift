//
//  Message.swift
//  ParseLab
//
//  Created by Roger Hu on 9/26/17.
//  Copyright © 2017 Roger Hu. All rights reserved.
//

import Parse
import UIKit

class Message: PFObject, PFSubclassing {
    @NSManaged var text: String?
    @NSManaged var displayName: String?

    @NSManaged var fireProof: Bool
    @NSManaged var rupees: Int

    class func parseClassName() -> String {
        return "Message"
    }
}

class Post: PFObject, PFSubclassing {
    @NSManaged var media : PFFile
    @NSManaged var author: PFUser
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int

    class func parseClassName() -> String {
        return "Post"
    }
}
