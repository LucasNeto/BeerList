//
//  ListBeerViewControllerTests.swift
//  BeerListTests
//
//  Created by Lucas  N Santana on 27/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//


@testable import BeerList
import XCTest


class ListBeerViewControllerTests: XCTestCase {
    
    var sut : ListBeerViewController!
    var window: UIWindow!
    
    override func setUp() {
        super.setUp()
        setupListOrdersViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupListOrdersViewController() {
        window = UIWindow()
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "ListBeerViewController") as? ListBeerViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    class BusinessLogicSpy: ListBeerBusinessLogic {
        
        var requestBeersCalled = false
        var beerSelectTapCalled = false
        
        var displayedBeers: [ListBeer.FetchBeer.ViewModel.BeerResumed] = []
        
        func requestBeers() {
            requestBeersCalled = true
        }
        
        func beerSelectTap(request: ListBeer.Select.Request) {
            beerSelectTapCalled = true
        }
    }
    
    class CollectionViewSpy : UICollectionView {
        
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    class IndicatorSpy : UIActivityIndicatorView{
        
        var startAnimatingCalled = false
        var stopAnimatingCalled = false
        
        override func startAnimating() {
            startAnimatingCalled = true
        }
        override func stopAnimating() {
            stopAnimatingCalled = true
        }
    }
    
    func testShouldRequestBeersWhenViewDidLoad() {
        // Given
        let businessLogicSpy = BusinessLogicSpy()
        sut.interactor = businessLogicSpy
        loadView()
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(businessLogicSpy.requestBeersCalled, "Should request beers right after the view load")
    }
    
}
