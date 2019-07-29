//
//  DetailBeerInteractorTests.swift
//  BeerListTests
//
//  Created by Lucas  N Santana on 27/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//
@testable import BeerList
import XCTest

class DetailBeerInteractorTests: XCTestCase {
    
    var sut : DetailBeerInteractor!
    
    override func setUp() {
        super.setUp()
        setupInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func setupInteractor(){
        sut = DetailBeerInteractor()
        sut.beer = Seeds.BeerMock.buzz
    }
    
    
    class PresenterSpy: DetailBeerPresentationLogic {
        
        var presentBeerCalled = false
        
        func presentBeer(response: DetailBeer.Show.Response) {
            presentBeerCalled = true
        }
        
    }
    
    func testShowBeerShouldPresenterToDetailBeer() {
        // Given
        let presenterSpy = PresenterSpy()
        sut.presenter = presenterSpy
        
        // When
        sut.showBeer()
        
        // Then
        XCTAssert(presenterSpy.presentBeerCalled, "showBeer() should ask presenter To Detail Beer")
    }
    
    
}
