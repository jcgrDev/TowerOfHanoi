//
//  FirebaseHanoiService.swift
//  TowerOfHanoi
//
//  Created by Juan Carlos Guzman Rosales on 27/08/25.
//

import Foundation
import FirebaseFunctions

struct CloudSolutionResponse {
    let solution: HanoiSolution
}

enum FirebaseServiceError: LocalizedError {
    case invalidResponse
    case networkError(Error)
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

class FirebaseHanoiService: ObservableObject {
    private let functions = Functions.functions()
    @Published var isConnectd = false
    @Published var lastError: Error?
    
    func getSolution(numberOfDisks: Int) async throws -> CloudSolutionResponse {
        let callable = functions.httpsCallable("getTowerOfHanoiSolution")
        let parameters = ["numberOfDisks": numberOfDisks]
        
        do {
            let result = try await callable.call(parameters)
            let data = result.data as? [String: Any] ?? [:]
            
            guard let success = data["success"] as? Bool, success,
                  let solutionData = data["solution"] as? [String: Any] else {
                throw FirebaseServiceError.invalidResponse
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: solutionData)
            let solution = try JSONDecoder().decode(HanoiSolution.self, from: jsonData)
            
            return CloudSolutionResponse(solution: solution)
        } catch {
            self.lastError = error
            throw FirebaseServiceError.networkError(error)
        }
    }
}
