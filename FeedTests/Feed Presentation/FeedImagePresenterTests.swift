//
//  FeedImagePresenterTests.swift
//  FeedTests
//
//  Created by Valentin Kalchev (Zuant) on 04/01/21.
//  Copyright © 2021 Valentin Kalchev. All rights reserved.
//

import XCTest
import Feed

class FeedImagePresenterTests: XCTestCase {
    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()
        XCTAssertTrue(view.messages.isEmpty, "Expect no view messages")
    }
    
    func test_didStartLoadingImageData_imageLoadingWithDescriptionAndLocation() {
        let (sut, view) = makeSUT()
        let location = "some location"
        let description = "some description"
        let image = makeImage(description: description, location: location, url: anyURL())
        sut.didStartLoadingImageData(for: image)
        XCTAssertEqual(view.messages, [.display(FeedImageViewModel<UIImage>(
                                                    description: "some description",
                                                    location: "some location",
                                                    image: nil,
                                                    isLoading: true,
                                                    shouldRetry: false))])
    }
    
    func test_didFinishLoadingImageData_withValidData() {
        let (sut, view) = makeSUT()
        
        let image = UIImage.make(withColor: .red)
        let viewModel = FeedImageViewModel<UIImage>(description: "some description", location: "some location", image: image, isLoading: false, shouldRetry: false)
        
        let feedImage = makeImage(description: viewModel.description, location: viewModel.location, url: anyURL())
        
        sut.didFinishLoadingImageData(with: image.pngData()!, for: feedImage)
        XCTAssertEqual(view.messages, [.display(viewModel)])
    }
    
    func test_didFinishLoadingImageData_retryOnInvalidData() {
        let (sut, view) = makeSUT()
        
        let invalidImageData = "some data".data(using: .utf8)!
        let location = "some location"
        let description = "some description"
        
        let feedImage = makeImage(description: description,
                                  location: location,
                                  url: anyURL())
        
        sut.didFinishLoadingImageData(with: invalidImageData, for: feedImage)
        XCTAssertEqual(view.messages, [.display(FeedImageViewModel<UIImage>(
                                                    description: description,
                                                    location: location,
                                                    image: nil,
                                                    isLoading: false,
                                                    shouldRetry: true))])
    }
    
    func test_didFinishLoadingImageData_errorOnInvalidData() {
        let (sut, view) = makeSUT()
        let location = "some location"
        let description = "some description"
        
        let feedImage = makeImage(description: description, location: location, url: anyURL())
        sut.didFinishLoadingImageData(with: anyNSError(), for: feedImage)
        XCTAssertEqual(view.messages, [.display(FeedImageViewModel<UIImage>(
                                                    description: description,
                                                    location: location,
                                                    image: nil,
                                                    isLoading: false,
                                                    shouldRetry: true))])
    }
    
    private func makeImage(description: String? = nil, location: String? = nil, url: URL = URL(string: "http://any-url.com")!) -> FeedImage {
        return FeedImage(id: UUID(), description: description, location: location, url: url)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedImagePresenter<ViewSpy, UIImage>, ViewSpy) {
        
        let view = ViewSpy()
        let sut = FeedImagePresenter(view: view, imageTransformer: UIImage.init)
        
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
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
                        lhsm.image?.pngData() == rhsm.image?.pngData() &&
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

extension UIImage {
    static func make(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

