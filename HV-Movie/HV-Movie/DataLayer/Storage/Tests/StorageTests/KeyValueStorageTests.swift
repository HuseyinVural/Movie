import XCTest
@testable import Storage
@testable import StorageInterface

class KeyValueStorageTests: XCTestCase {
    private var storage: KeyValueStorage!
    private var mockDefaults: MockUserDefaults!
    private let key = "testKey"
    private let value = "testValue"
    
    override func setUp() {
        super.setUp()
        mockDefaults = MockUserDefaults()
        storage = KeyValueStorage(defaults: mockDefaults)
    }
    
    override func tearDown() {
        storage = nil
        mockDefaults = nil
        super.tearDown()
    }
    
    func testSaveString_WhenCalled_SavesStringToUserDefaults() {
        // Act
        storage.save(value, forKey: key)
        
        // Assert
        XCTAssertEqual(mockDefaults.storage[key] as? String, value)
    }
    
    func testLoadString_WhenCalled_ReturnsStoredStringFromUserDefaults() {
        // Arrange
        mockDefaults.storage[key] = value
        
        // Act
        let loadedValue: String? = storage.load(forKey: key)
        
        // Assert
        XCTAssertEqual(loadedValue, value)
    }
    
    func testSaveData_WhenCalled_SavesDataToUserDefaults() {
        // Arrange
        let value = value.data(using: .utf8)!
        
        // Act
        storage.save(value, forKey: key)
        
        // Assert
        XCTAssertEqual(mockDefaults.storage[key] as? Data, value)
    }
    
    func testLoadData_WhenCalled_ReturnsStoredDataFromUserDefaults() {
        // Arrange
        let value = value.data(using: .utf8)!
        mockDefaults.storage[key] = value
        
        // Act
        let loadedValue: Data? = storage.load(forKey: key)
        
        // Assert
        XCTAssertEqual(loadedValue, value)
    }
    
    func testSaveAndLoadCodableObject_WhenCalled_SavesAndLoadsObjectCorrectly() {
        // Arrange
        struct TestObject: Codable, Equatable {
            let name: String
            let age: Int
        }
        
        let value = TestObject(name: "John", age: 30)
        
        // Act
        storage.save(value, forKey: key)
        let loadedValue: TestObject? = storage.load(forKey: key)
        
        // Assert
        XCTAssertEqual(loadedValue, value)
    }
    
    func testSaveDictionary_WhenCalled_SavesDictionaryToUserDefaults() {
        // Arrange
        let value: [String: Bool] = ["key1": true, "key2": false]
        
        // Act
        storage.save(value, forKey: key)
        
        // Assert
        if let data = mockDefaults.storage[key] as? Data {
            let decodedValue = try? JSONDecoder().decode([String: Bool].self, from: data)
            XCTAssertEqual(decodedValue, value)
        } else {
            XCTFail("Data was not stored correctly.")
        }
    }

    func testLoadDictionary_WhenCalled_ReturnsStoredDictionaryFromUserDefaults() {
        // Arrange
        let value: [String: Bool] = ["key1": true, "key2": false]
        if let data = try? JSONEncoder().encode(value) {
            mockDefaults.storage[key] = data
        }
        
        // Act
        let loadedValue: [String: Bool]? = storage.load(forKey: key)
        
        // Assert
        XCTAssertEqual(loadedValue, value)
    }
}


class MockUserDefaults: UserDefaults {
    var storage: [String: Any] = [:]
    
    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value
    }
    
    override func string(forKey defaultName: String) -> String? {
        return storage[defaultName] as? String
    }
    
    override func data(forKey defaultName: String) -> Data? {
        return storage[defaultName] as? Data
    }
    
    override func removeObject(forKey defaultName: String) {
        storage.removeValue(forKey: defaultName)
    }
}

