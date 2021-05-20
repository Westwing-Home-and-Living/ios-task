import XCTest

class CampaignBrowserUITests: XCTestCase {

    var application: XCUIApplication!
    let imageOriginX: CGFloat = 0
    let imageRatio: CGFloat = 4 / 3

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    func testCampaignImages() {
        let firstImage = application.images.element(boundBy: 0)
        XCTAssert(firstImage.exists, "There should be an image in the campaign")
        let imageSize = firstImage.frame.size
        // using UIScreen is not a valid way of getting the device screen size in testing
        let screenSize = application.windows.element(boundBy: 0).frame.size
        XCTAssert(firstImage.frame.origin.x == imageOriginX, "Images should start at the beginning of the screen")
        XCTAssert(imageSize.width == screenSize.width, "Images should take all available width")
        XCTAssert((imageSize.height * imageRatio).rounded() == imageSize.width, "Images proportion should be 4:3")
    }

}
