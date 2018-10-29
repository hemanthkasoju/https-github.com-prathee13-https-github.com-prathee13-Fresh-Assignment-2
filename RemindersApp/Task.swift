//
//  Task.swift
//  RemindersApp
//
//  Created by Pratheeksha Ravindra Naik on 2018-10-26.
//  Copyright © 2018. All rights reserved.
//

import os.log
import UIKit

class Task: NSObject, NSCoding {
    
    //Mark: Properties
    
    var title: String
    var photo: UIImage?
    var thumbnail: UIImage?
    var currentDate: String
    var dueDate: String
    var priority: String
    var notes: String
    
    struct PropertyKey {
        static let title = "title"
        static let photo = "photo"
        static let currentDate = "currentDate"
        static let dueDate = "dueDate"
        static let priority = "priority"
        static let notes = "notes"
        static let thumbnail = "thumbnail"
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("tasks")

    
    //mark: initalization
    
  
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(currentDate, forKey: PropertyKey.currentDate)
        aCoder.encode(dueDate, forKey: PropertyKey.dueDate)
        aCoder.encode(priority, forKey: PropertyKey.priority)
        aCoder.encode(notes, forKey: PropertyKey.notes)
        aCoder.encode(thumbnail, forKey: PropertyKey.thumbnail)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let Title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let Photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        // Because photo is an optional property of Meal, just use conditional cast.
        let Thumbnail = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        guard let CurrentDate = aDecoder.decodeObject(forKey: PropertyKey.currentDate) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        guard let DueDate = aDecoder.decodeObject(forKey: PropertyKey.dueDate) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let Notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let Priority = aDecoder.decodeObject(forKey: PropertyKey.priority) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(title: Title, photo: Photo, currentDate:CurrentDate, dueDate: DueDate, priority: Priority, notes: Notes, thumbnail: Thumbnail)
        
    }
    
    init?(title: String, photo: UIImage?, currentDate: String, dueDate: String, priority: String, notes: String, thumbnail:UIImage? = nil) {
        self.currentDate = currentDate
        self.dueDate = dueDate
        self.notes = notes
        self.photo = photo
        self.title = title
        self.priority = priority
        if thumbnail == nil {
            self.thumbnail = self.photo
        } else {
            self.thumbnail = thumbnail
        }
    }

    
}
