// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import BlockCypherSwiftSdk

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("Address API Test") {

            it("generateAddress") {
                let shared = AddressAPI.shared
                let exp = self.expectation(description: "testFinished")
                shared.generateAddress(completionHandler: { (keyChain, succ) in
                    if (succ) {
                        print (keyChain!.address)
                    }
                    exp.fulfill()
                })
                self.waitForExpectations(timeout: .init(integerLiteral: 1000), handler: nil)
            }

        }
    }
}
