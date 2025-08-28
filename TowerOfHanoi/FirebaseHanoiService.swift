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
    @Published var isConnectd = false
    @Published var lastError: Error?
    @Published var hasBeenTested = false
    private let functions = Functions.functions()
    
    
    func getSolution(numberOfDisks: Int) async throws -> CloudSolutionResponse {
        let callable = functions.httpsCallable("getTowerOfHanoiSolution")
        let parameters = ["numberOfDisks": numberOfDisks]
        
        do {
            let result = try await callable.call(parameters)
            
            // Debug: Print the raw response
            print("🔍 Raw Firebase response: \(result.data)")
            let data = result.data as? [String: Any] ?? [:]
            print("🔍 Parsed data: \(data)")
            
            guard let success = data["success"] as? Bool, success,
                  let solutionData = data["solution"] as? [String: Any] else {
                
                await MainActor.run {
                    self.isConnectd = false
                    self.hasBeenTested = true
                }
                throw FirebaseServiceError.invalidResponse
            }
            
            let jsonData = try JSONSerialization.data(withJSONObject: solutionData)
            let solution = try JSONDecoder().decode(HanoiSolution.self, from: jsonData)
            
            await MainActor.run {
                self.isConnectd = true
                self.lastError = nil
                self.hasBeenTested = true
            }
            return CloudSolutionResponse(solution: solution)
        } catch {
            await MainActor.run {
                self.isConnectd = false
                self.hasBeenTested = true
                self.lastError = error
            }
            throw FirebaseServiceError.networkError(error)
        }
    }
    
    func testConnection() async {
        do {
            let callable = functions.httpsCallable("getTowerOfHanoiSolution")
            let _ = try await callable.call(["numberOfDisks": 1])
            
            await MainActor.run {
                self.isConnectd = true
                self.hasBeenTested = true
            }
        } catch {
            await MainActor.run {
                self.isConnectd = false
                self.hasBeenTested = true
                self.lastError = error
            }
        }
    }
}
