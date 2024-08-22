//
//  PostResponseDataModel.swift
//  CombineApiCallSwift
//
//  Created by Kishore B on 8/19/24.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
