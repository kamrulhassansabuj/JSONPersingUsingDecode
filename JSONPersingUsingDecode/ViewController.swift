//
//  ViewController.swift
//  JSONPersingUsingDecode
//
//  Created by Md. Kamrul Hassan Sabuj on 21/10/18.
//  Copyright © 2018 Md. Kamrul Hassan Sabuj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Course: Decodable {
        let id : Int
        let name : String
        let link : String
        let imageURL : String
        
        
        init(json: [String: Any]) {
            id = json["id"] as? Int ?? 0
            name = json["name"] as? String ?? ""
            link = json["link"] as? String ?? ""
            imageURL = json["imageURL"] as? String ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let jsonURLString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        
        guard let url = URL(string: jsonURLString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, url, error) in
            // check error
            // check response status 200 ok
            guard let data = data else {return}
            
//            let dataAsString = String.init(data: data, encoding: .utf8)
//
//            print(dataAsString )
            do {
                //Swift 4 or later
                let course = try JSONDecoder().decode(Course.self, from: data)
                print(course.name)
                //Swift 2/3
//                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else {return}
//
//                let course = Course(json: json)
//                print(course.name)
            }catch{
                print("Error in Decoding : \(error)")
            }
            
        }.resume()
//        let myCourse = Course(id: 1, name: "My Name", link: "Some Link", imageURL: "Some URL")
    }


}

