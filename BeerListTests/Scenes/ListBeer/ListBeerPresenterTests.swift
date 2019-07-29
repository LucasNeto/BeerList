//
//  ListBeerPresenterTests.swift
//  BeerListTests
//
//  Created by Lucas  N Santana on 29/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//

@testable import BeerList
import XCTest

class ListBeerPresenterTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: ListBeerPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPresenter() {
        sut = ListBeerPresenter()
    }
    
    class ListBeerDisplayLogicSpy : ListBeerDisplayLogic {
        
        var viewModel : ListBeer.FetchBeer.ViewModel?
        
        var displayListBeersCalled = false
        var displayDetailBeerCalled = false
        
        func displayListBeers(viewModel: ListBeer.FetchBeer.ViewModel) {
            displayListBeersCalled = true
            self.viewModel = viewModel
        }
        
        func displayDetailBeer() {
            displayDetailBeerCalled = true
        }
    }
    
    func testPresentFetchedOrdersShouldFormatFetchedOrdersForDisplay() {
        // Given
        let displayLogicSpy = ListBeerDisplayLogicSpy()
        sut.viewController = displayLogicSpy
        
        // When
        let list = [Seeds.BeerMock.buzz]
        let response = ListBeer.FetchBeer.Response(listBeer: list)
        sut.presentListBeers(response: response)
        
        // Then
        let displayedBeers = displayLogicSpy.viewModel!.listBeer
        for displayedBeer in displayedBeers {
            XCTAssertEqual(displayedBeer.abv, "abv: 4.5%", "Presenting requested beers should properly format abv")
            XCTAssertEqual(displayedBeer.imageUrl, "https://images.punkapi.com/v2/keg.png", "Presenting requested beers should properly format")
            XCTAssertEqual(displayedBeer.name, "Buzz", "Presenting requested beers should properly format name")
        }
        XCTAssert(displayLogicSpy.displayListBeersCalled, "Presenting requested beers should call display list")
    }
    
    func testPresentDetailBeer(){
        // Given
        let displayLogicSpy = ListBeerDisplayLogicSpy()
        sut.viewController = displayLogicSpy
        
        // When
        sut.presentDetailBeer()
        
        // Then
        XCTAssert(displayLogicSpy.displayDetailBeerCalled, "Presenting Detail beer should call display detail beer")
    }
}
