//
//  FeedImagePresenterTests.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 04/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import XCTest
import Feed

struct FeedImageViewModel<Image> {
    
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}

protocol FeedImageView {
    associatedtype Image
    func display(_ model: FeedImageViewModel<Image>)
}

class FeedImagePresenter<View: FeedImageView, Image> where View.Image == Image {
    private let view: View
    
    init(view: View) {
        self.view = view
    }
    
    func didStartLoadingImageData(for model: FeedImage) {
        view.display(FeedImageViewModel(description: model.description, location: model.location, image: nil, isLoading: true, shouldRetry: false))
    }
}

class FeedImagePresenterTests: XCTestCase {
    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()
        XCTAssertTrue(view.messages.isEmpty, "Expect no view messages")
    }
    
    func test_didStartLoadingImageData_imageLoadingWithDescriptionAndLocation() {
        let (sut, view) = makeSUT()
        let viewModel = FeedImageViewModel<UIImage>(description: "some description", location: "some location", image: nil, isLoading: true, shouldRetry: false)
        sut.didStartLoadingImageData(for: FeedImage(id: UUID(), description: viewModel.description, location: viewModel.location, url: anyURL()))
        XCTAssertEqual(view.messages, [.display(viewModel)], "Expected loadin")
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedImagePresenter<ViewSpy, UIImage>, ViewSpy) {
        
        let view = ViewSpy()
        let sut = FeedImagePresenter(view: view)
        
        trackForMemoryLeaks(view)
        trackForMemoryLeaks(sut)
        
        return (sut, view)
    }
    
    private class ViewSpy: FeedImageView {
        
        typealias Image = UIImage
        
        enum Message: Equatable {
            static func == (lhs: FeedImagePresenterTests.ViewSpy.Message, rhs: FeedImagePresenterTests.ViewSpy.Message) -> Bool {
                switch (lhs, rhs) {
                case let (display(lhsm), display(rhsm)):
                    if lhsm.description == rhsm.description &&
                        lhsm.location == rhsm.location &&
                        lhsm.image == rhsm.image &&
                    lhsm.isLoading == rhsm.isLoading &&
                        lhsm.shouldRetry == rhsm.shouldRetry {
                         return true
                    } else {
                        return false
                    }
                }
            }
            
            case display(FeedImageViewModel<UIImage>)
        }
        
        private(set) var messages: [Message] = []
        
        func display(_ model: FeedImageViewModel<UIImage>) {
            messages.append(.display(FeedImageViewModel(description: model.description,
                                                        location: model.location,
                                                        image: model.image,
                                                        isLoading: model.isLoading,
                                                        shouldRetry: model.shouldRetry)))
        }
    }
}
