//
//  DetailBeerViewControllerTests.swift
//  BeerListTests
//
//  Created by Lucas  N Santana on 29/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//

@testable import BeerList
import XCTest
import UIKit

class DetailBeerViewControllerTests: XCTestCase {

    var sut : DetailBeerViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        setupViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupViewController() {
        window = UIWindow()
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailBeerViewController") as? DetailBeerViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    
    class BusinessLogicSpy: DetailBeerBusinessLogic {
        
        var showBeerCalled = false
        
        func showBeer() {
            showBeerCalled = true
        }
        
    }
    
    func testShouldShowBeerWhenViewDidLoad() {
        // Given
        loadView()
        let businessLogicSpy = BusinessLogicSpy()
        sut.interactor = businessLogicSpy
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(businessLogicSpy.showBeerCalled, "Should show beer right after the view load")
    }
    
    func testShouldDisplayBeerWithBeerSelected() {
        
        // Given
        loadView()
        let nameSpy = UILabel()
        sut.nameLbl = nameSpy
        let tagLineSpy = UILabel()
        sut.taglineLbl = tagLineSpy
        let abvSpy = UILabel()
        sut.abvLbl = abvSpy
        let ibuSpy = UILabel()
        sut.ibuLbl = ibuSpy
        let descSpy = UILabel()
        sut.descriptionLbl = descSpy
        
        // When
        let viewModel = DetailBeer.Show.ViewModel(beerDetailed: Seeds.BeerMock.buzzDetailed)
        sut.displayBeer(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(nameSpy.text,viewModel.beerDetailed.name, "Displaying selected beer should set text on this label")
        XCTAssertEqual(tagLineSpy.text,viewModel.beerDetailed.tagline, "Displaying selected beer should set text on this label")
        XCTAssertEqual(abvSpy.text,viewModel.beerDetailed.abv, "Displaying selected beer should set text on this label")
        XCTAssertEqual(ibuSpy.text,viewModel.beerDetailed.ibu, "Displaying selected beer should set text on this label")
        XCTAssertEqual(descSpy.text,viewModel.beerDetailed.description, "Displaying selected beer should set text on this label")
    }
    
}
