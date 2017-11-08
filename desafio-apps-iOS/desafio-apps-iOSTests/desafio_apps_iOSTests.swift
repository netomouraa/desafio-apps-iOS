//
//  desafio_apps_iOSTests.swift
//  desafio-apps-iOSTests
//
//  Created by Neto Moura on 30/10/2017.
//  Copyright © 2017 Neto Moura. All rights reserved.
//

import XCTest
@testable import desafio_apps_iOS

class desafio_apps_iOSTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    var mainViewController: CapaViewController!
    let urlAPI = URL(string: "https://raw.githubusercontent.com/Infoglobo/desafio-apps/master/capa.json")
    
    override func setUp() {
        super.setUp()
        
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
        mainViewController = UIStoryboard(name: "CapaViewController", bundle: nil).instantiateViewController(withIdentifier: "capaVC") as! CapaViewController
        mainViewController.preload()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        self.measure {
            self.mainViewController.resquestAPI()
        }
    }
    
    func testValidCallToAPIGetsHTTPStatusCode200() {
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: urlAPI!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCallToAPICompletes() {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: urlAPI!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    
}
