//
//  HNService.swift
//  HackerNews
//
//  Created by Vohra, Nikant on 29/03/15.
//  Copyright (c) 2015 Vohra, Nikant. All rights reserved.
//
import Alamofire

struct HNService {
    
    private static let baseURL = "https://hacker-news.firebaseio.com"
    
    
    enum ResourcePath: CustomStringConvertible {
        case User(name: String)
        case ItemId(itemId: Int)

        
        var description: String {
            switch self {
            case .User(let name): return "/v0/user/\(name).json"
            case .ItemId(let id): return "/v0/item/\(id).json"
            
            }
        }
        
    }
    
    static func getItemWithId(itemID : Int, response: (JSON) -> ()) {
        
        let urlString = baseURL + ResourcePath.ItemId(itemId: itemID).description
        
        request(.GET, urlString).responseJSON { (resp) -> Void in
            switch resp.result
            {
            case .Success(let data):
                let json = JSON(data: (data ?? []) as! NSData)
                response(json)
                
            case .Failure(let error):
                print("哈哈哈哈  + \(error)")
            }
            
            
        }

    
//        request(.GET, urlString, parameters: nil).responseJSON { (_, _, data, _) -> Void in
//            let stories = JSON(data ?? [])
//            response(stories)
//        }

    }
    
    static func getUser(name:String, response: (JSON) -> ()) {
        let urlString = baseURL + ResourcePath.User(name: name).description
        
        request(.GET, urlString).responseJSON { (resp) -> Void in
            switch resp.result
            {
            case .Success(let data):
                let json = JSON(data: (data ?? []) as! NSData)
                response(json)
                
            case .Failure(let error):
                print("哈哈哈哈  + \(error)")
            }
            
        }
        
//        request(.GET, urlString).responseJSON { (_, _, data, _) -> Void in
//            let user = JSON(data ?? [])
//            response(user)
//        }
        
        
        
        
    }
    
    
}