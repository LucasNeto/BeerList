//
//  ListBeerViewControllerTests.swift
//  BeerListTests
//
//  Created by Lucas  N Santana on 27/07/19.
//  Copyright © 2019 Lucas  N Santana. All rights reserved.
//


@testable import BeerList
import XCTest
import UIKit


class ListBeerViewControllerTests: XCTestCase {
    
    var sut : ListBeerViewController!
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
        var registerCalled = false
        
        init() {
            super.init(frame: CGRect.zero,collectionViewLayout: UICollectionViewLayout.init())
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func reloadData() {
            reloadDataCalled = true
        }
        
        override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
            registerCalled = true
            super.register(nib, forCellWithReuseIdentifier: identifier)
        }
        
    }
    class IndicatorSpy : UIActivityIndicatorView{
        
        var startAnimatingCalled = false
        var stopAnimatingCalled = false
        
        init() {
            super.init(frame: CGRect.zero)
        }
        
        required init(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func startAnimating() {
            startAnimatingCalled = true
        }
        override func stopAnimating() {
            stopAnimatingCalled = true
        }
    }
    
    func testShouldRequestBeersWhenViewDidLoad() {
        // Given
        loadView()
        let businessLogicSpy = BusinessLogicSpy()
        sut.interactor = businessLogicSpy
        let indicatorSpy =  IndicatorSpy()
        sut.activityIndicator = indicatorSpy
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssert(indicatorSpy.startAnimatingCalled, "Should start animating loading right after the view load")
        XCTAssert(businessLogicSpy.requestBeersCalled, "Should request beers right after the view load")
    }
    
    func testShouldSetupViewWhenViewDidLoad() {
        // Given
        loadView()
        let indicatorSpy = UIActivityIndicatorView()
        sut.activityIndicator = indicatorSpy
        let collectionViewSpy = CollectionViewSpy()
        sut.collectionView = collectionViewSpy
        let buttonSpy =  UIButton()
        sut.tryAgainBtn = buttonSpy

        // When
        sut.viewDidLoad()

        // Then
        XCTAssert(indicatorSpy.hidesWhenStopped, "Should setup activity indicator to hide when stopped")
        XCTAssert(collectionViewSpy.registerCalled, "Should register cell on collection view")
        XCTAssert(buttonSpy.layer.cornerRadius == 10, "Should set corner radius on button try again")
    }
    
    
    func testShouldDisplayListBeersWithArrayMoreThanOne() {
        
        // Given
        loadView()
        let collectionViewSpy = CollectionViewSpy()
        sut.collectionView = collectionViewSpy
        let indicatorSpy =  IndicatorSpy()
        sut.activityIndicator = indicatorSpy
        let buttonSpy =  UIButton()
        sut.tryAgainBtn = buttonSpy
        
        
        // When
        let viewModel = ListBeer.FetchBeer.ViewModel(listBeer: Seeds.BeerMock.listResumed)
        sut.displayListBeers(viewModel: viewModel)
        
        // Then
        XCTAssert(collectionViewSpy.reloadDataCalled, "Displaying requested beers should reload the collection view")
        XCTAssert(indicatorSpy.stopAnimatingCalled, "Displaying requested beers should stop activity indicator")
        XCTAssert(buttonSpy.isHidden, "Displaying requested beers should hidden button to try again")
    }
    
    func testShouldDisplayListBeersWithArrayEmpty() {
        
        // Given
        loadView()
        let collectionViewSpy = CollectionViewSpy()
        sut.collectionView = collectionViewSpy
        let indicatorSpy =  IndicatorSpy()
        sut.activityIndicator = indicatorSpy
        let buttonSpy =  UIButton()
        sut.tryAgainBtn = buttonSpy
        
        
        // When
        let viewModel = ListBeer.FetchBeer.ViewModel(listBeer: [])
        sut.displayListBeers(viewModel: viewModel)
        
        // Then
        XCTAssert(collectionViewSpy.reloadDataCalled, "Displaying requested beers should reload the collection view")
        XCTAssert(indicatorSpy.stopAnimatingCalled, "Displaying requested beers should stop activity indicator")
        XCTAssert(!buttonSpy.isHidden, "Displaying requested beers should show button to try again")
    }
    
    func testNumberOfRowsInSectionShouldEqualNumberOfBeerToDisplay() {
        // Given
        loadView()
        let collectionViewSpy = CollectionViewSpy()
        sut.collectionView = collectionViewSpy
        let testDisplayedBeers = Seeds.BeerMock.listResumed
        sut.displayedBeers = testDisplayedBeers
        
        // When
        let numberOfRows = sut.collectionView(collectionViewSpy, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayedBeers.count, "The number of collection view rows should equal the number of beers to display")
    }
    
    
    func testShouldConfigureCollectionViewCellToDisplayBeer() {
        // Given
        loadView()
        let collectionViewSpy = CollectionViewSpy()
        sut.collectionView = collectionViewSpy
        let testDisplayedBeers = Seeds.BeerMock.listResumed
        sut.displayedBeers = testDisplayedBeers
        
        sut.viewDidLoad()
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.collectionView(collectionViewSpy, cellForItemAt: indexPath) as! BeerCollectionViewCell
        
        // Then
        XCTAssert(!cell.isHidden, "Displaying requested beers should reload the collection view")
        XCTAssertEqual(cell.titleLabel?.text, Seeds.BeerMock.listResumed[0].name, "A properly configured collection view cell should display the beer name")
        XCTAssertEqual(cell.abvLabel?.text, Seeds.BeerMock.listResumed[0].abv, "A properly configured collection view cell should display the beer abv")
    }
    
    
    func testShouldSellectBeerOnCollectionViewAndCallInteractor() {
        // Given
        loadView()
        let collectionViewSpy = CollectionViewSpy()
        sut.collectionView = collectionViewSpy
        let businessLogicSpy = BusinessLogicSpy()
        sut.interactor = businessLogicSpy
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        sut.collectionView(collectionViewSpy, didSelectItemAt: indexPath)
        
        // Then
        XCTAssert(businessLogicSpy.beerSelectTapCalled, "Should ask interector after select some index path")
    }
    
}
