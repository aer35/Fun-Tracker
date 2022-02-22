//
//  FunwordsRequest.swift
//  Fun Tracker
//
//  Created by Aaron on 2/22/22.
//

import Foundation

class FunwordsRequest {
	
	struct Response: Decodable{
		let message: String
	}

	func getFunwords() async throws -> String{
		
		let url = URL.init(string: "https://fun-tracker-server-aaron.herokuapp.com/messages")!
		
		let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
		
		let funtextJSON = try JSONDecoder().decode(Response.self, from: data)
		
		return funtextJSON.message
	}
	
	
}
