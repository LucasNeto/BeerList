//
//  ListBeerInteractorTests.swift
//  BeerListTests
//
//  Created by Lucas  N Santana on 27/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//

@testable import BeerList
import XCTest

class ListBeerInteractorTests: XCTestCase {
    
    var sut : ListBeerInteractor!

    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func setupInteractor(){
        sut = ListBeerInteractor()
    }
    
    
    class PresenterSpy: ListBeerPresentationLogic {
        
        var presentListBeersCalled = false
        var presentDetailBeerCalled = false
        
        func presentListBeers(response: ListBeer.FetchBeer.Response) {
            presentListBeersCalled = true
        }
        
        func presentDetailBeer() {
            presentDetailBeerCalled = true
        }
        
        
    }
    class WorkerSpy: ListBeerWorker {
        
        var requestBeersCalled = false
        var list = Seeds.BeerMock.list
        
        override func requestBeers(completion: @escaping
            (ListBeer.FetchBeer.Response?) -> Void) {
            requestBeersCalled = true
            completion(ListBeer.FetchBeer.Response(listBeer: list))
        }
    }
    

    func testFetchBeersShouldAskWorkerToFetchBeersAndPresenterList() {
        // Given
        let presenterSpy = PresenterSpy()
        sut.presenter = presenterSpy
        let workerSpy = WorkerSpy()
        sut.worker = workerSpy
        
        // When
        sut.requestBeers()
        
        // Then
        XCTAssert(workerSpy.requestBeersCalled, "requestBeers() should ask Worker to fetch Beers")
        XCTAssert(presenterSpy.presentListBeersCalled, "requestBeers() should ask presenter to present list")
    }
    

}
