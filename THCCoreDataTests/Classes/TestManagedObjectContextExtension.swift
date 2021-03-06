//
//  TestManagedObjectContext.swift
//  THCCoreData
//
//  Created by Christopher weber on 06.04.15.
//  Copyright (c) 2015 Thinc. All rights reserved.
//

import UIKit
import XCTest
import CoreData
import THCCoreData

class TestManagedObjectContextExtension: CoreDataTestCase {
    
    func testFetchRequest() {
        let context = self.manager.mainContext
        let fetchRequest = context.fetchRequest(Stub)
        XCTAssertEqual(Stub.entityName(), fetchRequest.entityName!)
    }
    
    func testCreateObject() {
        let context = self.manager.mainContext
        let stub: Stub = context.createObject(Stub)
        XCTAssertNotNil(stub)
    }
    
    func testRequestSet() {
        let context = self.manager.mainContext
        let requestSet = context.requestSet(Stub)
        XCTAssertNotNil(requestSet)
    }
    
    func testPersist() {
        let context = self.manager.mainContext
        let obj = context.createObject(Stub)
        obj.name = "test"
        let expectation = self.expectationWithDescription("Called success")
        context.persist({(error) -> Void in
            XCTAssertNil(error)
            expectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(0.01, handler: nil)
        XCTAssertEqual(1, self.manager.mainContext.parentContext!.countForFetchRequest(context.fetchRequest(Stub), error: nil))
    }
}
