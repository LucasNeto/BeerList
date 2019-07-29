//
//  DetailBeerPresenterTests.swift
//  BeerListTests
//
//  Created by Lucas  N Santana on 29/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//
@testable import BeerList
import XCTest

class DetailBeerPresenterTests: XCTestCase {
    
    var sut: DetailBeerPresenter!
    
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
        sut = DetailBeerPresenter()
    }
    
    class DetailBeerDisplayLogicSpy : DetailBeerDisplayLogic {
        
        var displayBeerCalled = false
        var viewModel : DetailBeer.Show.ViewModel?
        
        func displayBeer(viewModel: DetailBeer.Show.ViewModel) {
            displayBeerCalled = true
            self.viewModel = viewModel
            
        }
        
    }
    
    func testPresentBeer(){
        // Given
        let displayLogicSpy = DetailBeerDisplayLogicSpy()
        sut.viewController = displayLogicSpy
        
        // When
        let response = DetailBeer.Show.Response(beer: Seeds.BeerMock.buzz)
        sut.presentBeer(response: response)
        
        // Then
        let beerDetailed = displayLogicSpy.viewModel?.beerDetailed
        XCTAssert(displayLogicSpy.displayBeerCalled, "Presenting Detail beer should call display detail beer")
        XCTAssertEqual(beerDetailed?.name, "Buzz", "Presenting detail beer should properly format name")
        XCTAssertEqual(beerDetailed?.tagline, "A Real Bitter Experience.", "Presenting detail beer should properly format tagline")
        XCTAssertEqual(beerDetailed?.description, "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once.", "Presenting detail beer should properly format description")
        XCTAssertEqual(beerDetailed?.abv, "4.5%", "Presenting detail beer should properly format abv")
        XCTAssertEqual(beerDetailed?.ibu, "60.0/100", "Presenting detail beer should properly format ibu")
    }
    
    func testPresentBeerNil(){
        // Given
        let displayLogicSpy = DetailBeerDisplayLogicSpy()
        sut.viewController = displayLogicSpy
        
        // When
        let response = DetailBeer.Show.Response(beer: nil)
        sut.presentBeer(response: response)
        
        // Then
        let beerDetailed = displayLogicSpy.viewModel?.beerDetailed
        XCTAssert(displayLogicSpy.displayBeerCalled, "Presenting Detail beer should call display detail beer")
        XCTAssertEqual(beerDetailed?.name, "Nome não encontrado", "Presenting detail beer should properly format name")
        XCTAssertEqual(beerDetailed?.tagline, "Cerveja sem slogan.", "Presenting detail beer should properly format tagline")
        XCTAssertEqual(beerDetailed?.description, "Cerveja sem descrição", "Presenting detail beer should properly format description")
        XCTAssertEqual(beerDetailed?.abv, "abv não encontrado", "Presenting detail beer should properly format abv")
        XCTAssertEqual(beerDetailed?.ibu, "ibu não encontrado", "Presenting detail beer should properly format ibu")
    }
}
