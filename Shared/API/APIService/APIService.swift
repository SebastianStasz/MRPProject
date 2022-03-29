//
//  APIService.swift
//  MRPProject
//

import Combine
import Foundation

enum APIError: Error {
    case message(MessageError)
    case other(Error)
    case status(Int)
    case unknown

    var description: String {
        switch self {
        case .message(let messageError):
            return messageError.message
        case .other(let error):
            return error.localizedDescription
        case .status(let status):
            return "Status: \(status.description)"
        case .unknown:
            return "Unknown error"
        }
    }
}

struct MessageError: Decodable {
    let message: String
}

final class APIService {
    static let shared = APIService()

    private let configuration: APIConfigurationProtocol

    init(configuration: APIConfigurationProtocol = APIConfiguration()) {
        self.configuration = configuration
    }
    
    func performRequest<Model: Decodable>(_ request: APIRequest, type: RequestType) -> AnyPublisher<Model, APIError> {
        let request = request.getURLRequest(for: type, configuration: configuration)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { [weak self] in
                guard let self = self else { throw APIError.unknown }
                return try self.handleResponse($0.response, withData: $0.data)
            }
            .mapError { error in
                guard let error = error as? APIError else { return APIError.other(error) }
                return error
            }
            .eraseToAnyPublisher()
    }

    private func handleResponse<Model: Decodable>(_ response: URLResponse, withData data: Data) throws -> Model {
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.unknown }
        switch httpResponse.statusCode {
        case 200:
            do {
                return try decode(data)
            } catch let error {
                throw APIError.other(error)
            }
        case 400:
            guard let messageError: MessageError = try? decode(data) else { throw APIError.unknown }
            throw APIError.message(messageError)
        default:
            throw APIError.status(httpResponse.statusCode)
        }
    }

    private func decode<Model: Decodable>(_ data: Data) throws -> Model {
        return try configuration.decoder.decode(Model.self, from: data)
    }
}
