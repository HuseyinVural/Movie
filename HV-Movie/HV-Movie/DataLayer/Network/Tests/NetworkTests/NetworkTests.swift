import XCTest
@testable import Network
@testable import NetworkInterface

final class NetworkTests: XCTestCase {
    private var provider: NetworkProvider!
    private var urlSession: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        provider = NetworkProvider(session: urlSession)
    }
    
    override func tearDownWithError() throws {
        provider = nil
        urlSession = nil
        try super.tearDownWithError()
    }
    
    
    func testRequest_SuccessfulResponse_DecodesDataCorrectly() async throws {
        // Arrange
        let expectedResponse = StubRequest.Response(id: 1, title: "Title", snakeCaseField: "Value")
        let mockData = """
        {
            "id": 1,
            "title": "Title",
            "snake_case_field": "Value"
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockData)
        }
        
        let task = StubRequest()

        // Act
        let actualResponse = try await provider.request(task)
        
        // Assert
        XCTAssertEqual(actualResponse.id, expectedResponse.id)
        XCTAssertEqual(actualResponse.title, expectedResponse.title)
        XCTAssertEqual(actualResponse.snakeCaseField, expectedResponse.snakeCaseField)
    }
    
    func testRequest_ErrorResponse_ThrowsError() async throws {
        // Arrange
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 500, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }
        
        let task = StubRequest()
        
        // Act & Assert
        do {
            _ = try await provider.request(task)
            XCTFail("Expected error to be thrown, but no error was thrown.")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
    
    func testRequest_CorrectlyMergesAndEncodesParameters() async throws {
        // Arrange
        let expectedParameters = [
            "param1": "value1",
            "param2": "value2",
            "default_param": "default_value"
        ]
        
        let mockData = """
        {
            "id": 1,
            "title": "Title",
            "snake_case_field": "Value"
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw URLError(.badURL)
            }
            // Assert - Check if the URL contains the expected parameters
            self.assertURLContainsParameters(url, expectedParameters: expectedParameters)
            
            // Mock a successful response to complete the request
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockData)
        }
        
        let task = StubRequest(
            parameters: ["param1": "value1", "param2": "value2"],
            defaultParameters: ["default_param": "default_value"]
        )
        
        // Act - Perform the request
        _ = try await provider.request(task)
    }
    
    private func assertURLContainsParameters(_ url: URL, expectedParameters: [String: String], file: StaticString = #file, line: UInt = #line) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            XCTFail("Failed to parse URL components or query items.", file: file, line: line)
            return
        }

        var actualParameters = [String: String]()
        for item in queryItems {
            actualParameters[item.name] = item.value
        }

        XCTAssertEqual(actualParameters, expectedParameters, "The URL parameters not match.", file: file, line: line)
    }

}
