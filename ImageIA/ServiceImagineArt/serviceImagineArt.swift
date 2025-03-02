//
//  serviceImagineArt.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 07/02/25.
//

import UIKit
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class ServiceImagineArt {
    var semaphore = DispatchSemaphore (value: 0)
    var body = ""
    var error: Error? = nil
    var seed = String(Int.random(in: 1...10))
    let boundary = "Boundary-\(UUID().uuidString)"

    func generateImage(prompt: String, style: String, aspectRatio: String, completion: @escaping (Data?) -> Void) {
        let parameters = [
            [
                "key": "prompt",
                "value": prompt,
                "type": "text"
            ],
            [
                "key": "style",
                "value": style,
                "type": "text"
            ],
            [
                "key": "aspect_ratio",
                "value": aspectRatio,
                "type": "text"
            ],
            [
                "key": "seed",
                "value": seed,
                "type": "text"
            ]] as [[String : Any]]
        
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"]!
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                if param["contentType"] != nil {
                    body += "\r\nContent-Type: \(param["contentType"] as! String)"
                }
                let paramType = param["type"] as! String
                if paramType == "text" {
                    let paramValue = param["value"] as! String
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let paramSrc = param["src"] as! String
                    do {
                        let fileData = try NSData(contentsOfFile:paramSrc, options:[]) as Data
                        let fileContent = String(data: fileData, encoding: .utf8)!
                        body += "; filename=\"\(paramSrc)\"\r\n"
                        + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
                    } catch {
                        print("erro")
                    }
                }
            }
        }
        
        
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://api.vyro.ai/v2/image/generations")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer \(Secrets.ImagineIAAPIKey)", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                self.semaphore.signal()
                return
            }
            self.semaphore.signal()
            
            do {
                    completion(data)
            } catch {
                print("Erro ao decodificar resposta:", error.localizedDescription)
                completion(nil)
            }
        }
        
        task.resume()
        semaphore.wait()
    }
}
