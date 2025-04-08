//
//  Service.swift
//  Image IA
//
//  Created by Kleyson Tavares on 07/02/25.
//

import Foundation

struct OpenAIImageResponse: Codable {
    struct ImageData: Codable {
        let url: String
    }
    let data: [ImageData]
}

class ServiceDall_e {
    
    func generateImage(prompt: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/images/generations")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(Secrets.openAIAPIKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "prompt": prompt,
            "n": 1,
            "size": "1024x1024"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro na requisição:", error?.localizedDescription ?? "Erro desconhecido")
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(OpenAIImageResponse.self, from: data)
                completion(result.data.first?.url)
            } catch {
                print("Erro ao decodificar resposta:", error.localizedDescription)
                completion(nil)
            }
        }
        
        task.resume()
    }
}
