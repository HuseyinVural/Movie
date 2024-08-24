import XCTest
@testable import ToolKit

final class DependencyContainerTests: XCTestCase {
    var sut: DependencyContainerProtocol!

    override func setUp() {
        super.setUp()
        sut = DependencyContainer()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testRegisterAndResolve_ShouldReturnCorrectInstance() {
        // Arrange
        let mockService = MockService()

        // Act
        sut.register(MockServiceProtocol.self, instance: mockService)
        let resolvedService: MockServiceProtocol = sut.resolve(MockServiceProtocol.self)

        // Assert
        XCTAssertEqual(resolvedService.doSomething(), "MockService did something")
    }

    func testRegister_ShouldOverwritePreviousRegistration() {
        // Arrange
        let mockService = MockService()
        let anotherMockService = AnotherMockService()

        // Act
        sut.register(MockServiceProtocol.self, instance: mockService)
        sut.register(MockServiceProtocol.self, instance: anotherMockService)
        let resolvedService: MockServiceProtocol = sut.resolve(MockServiceProtocol.self)

        // Assert
        XCTAssertEqual(resolvedService.doSomething(), "AnotherMockService did something")
    }
}
