//
//  NetworkError.swift
//  BaseBall
//
//  Created by HOONHA CHOI on 2021/05/03.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case invalidStatusCode(Int)
    case emptyData
    case failParsing
    
    var message: String {
        switch self {
        case .invalidURL:
            return "올바르지 않은 URL입니다"
        case .invalidRequest:
            return "올바르지 않은 요청입니다"
        case .invalidResponse:
            return "올바르지 않은 응답입니다"
        case .invalidStatusCode(let code):
            return "올바르지 않은 응답 코드입니다 \(code)"
        case .emptyData:
            return "올바르지 않은 데이터입니다"
        case .failParsing:
            return "올바르지 않은 데이터모델입니다"
        }
    }
}
