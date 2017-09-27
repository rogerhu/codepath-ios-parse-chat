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

