//
//  _ACaseStudyTests.swift
//  7ACaseStudyTests
//
//  Created by Baris U. Cukur on 12.02.2025.
//

import XCTest
@testable import CaseStudy7A

final class UserRepositoryTests: XCTestCase {
    
    var userRepository: UserRepository!
    
    override func setUp() {
        super.setUp()
        userRepository = UserRepository()
    }
    
    override func tearDown() {
        userRepository = nil
        super.tearDown()
    }
    
    // test the actual networking layer of the app
    func testFetchUsersRealSuccess() {
        
        let expectation = XCTestExpectation(description: "Fetch users (real) successful")
        
        userRepository.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 10, "Expected 10 users, but got \(users.count)")
            case .failure(let failure):
                XCTFail("Got unexpected number of users: \(failure.localizedDescription)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    // test if mock class works as expected, as the next
    // test will require the use of this class to make dummy users
    func testFetchUsersMockSuccess() {
        
        let expectation = XCTestExpectation(description: "Fetch users (mock) successful")
        
        let mockRepo = MockUserRepository()
        mockRepo.shouldSimulateFailure = false
        
        mockRepo.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 0, "Expected 0 mock user, got \(users.count)")
            case .failure(let error):
                XCTFail("Unexpected error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    // this tests if the table view displays all the users
    // by comparing the result of the fetch function of the
    // (mock) user repo to the actual tableview on the view
    func testTableViewEntryCount() {
        
        let expectation = XCTestExpectation(description: "TableView shows all of the users")
        var users: [User] = []
        
        for i in 0...10 {
            users.append(
                User(name: "User \(i)",
                     email: "user\(i)@example.com",
                     phone: "\(i)--\(i)--\(i)",
                     website: "user\(i).com")
            )
        }
        
        let userRepo = MockUserRepository()
        userRepo.hardcodedUsers = users
        
        let mockViewModel = UserListVM(userRepository: userRepo)

        let userListVC = UserListVC(viewModel: mockViewModel)

        _ = userListVC.view
        
        userRepo.fetchUsers { _ in
            DispatchQueue.main.async {
                XCTAssertEqual(userListVC.tableView.numberOfRows(inSection: 0), users.count, "Expected \(users.count) rows, but found \(userListVC.tableView.numberOfRows(inSection: 0))")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
