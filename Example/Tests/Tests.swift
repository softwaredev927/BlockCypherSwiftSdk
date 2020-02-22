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
                shared.generateAddressEndpoint(params: [:]){ (keyChain, succ) in
                    XCTAssert(succ == 201)
                    XCTAssert(keyChain != nil)
                    exp.fulfill()
                }
                self.waitForExpectations(timeout: .init(integerLiteral: 1000), handler: nil)
            }

            it("addressBalance") {
                let shared = AddressAPI.shared
                shared.setLiveMode(live: false)
                let exp = self.expectation(description: "testFinished")
                shared.addressBalanceEndpoint(address: "mfaaDseeUpezpo4Dkgjysf4TcfjBr5Vy2V", params: [:]){ (res, succ) in
                    XCTAssert(succ == 200)
                    XCTAssert(res != nil)
                    exp.fulfill()
                }
                self.waitForExpectations(timeout: .init(integerLiteral: 1000), handler: nil)
            }
            
            it("address") {
                let shared = AddressAPI.shared
                shared.setLiveMode(live: false)
                let exp = self.expectation(description: "testFinished")
                shared.addressEndpoint(address: "mfaaDseeUpezpo4Dkgjysf4TcfjBr5Vy2V", params: ["unspentOnly": "true"]){ (res, succ) in
                    XCTAssert(succ == 200)
                    XCTAssert(res != nil)
                    exp.fulfill()
                }
                self.waitForExpectations(timeout: .init(integerLiteral: 1000), handler: nil)
            }
        }
        
        describe("Transaction API Test") {
            
            it("newTransaction") {
                let exp = self.expectation(description: "testFinished")
                self.continueAfterFailure = false
                
                let addrAPI = AddressAPI.shared
                addrAPI.generateAddressEndpoint(params: [:]){ (keyChain, succ) in
                    if succ != 201 || keyChain == nil {
                        XCTFail()
                        exp.fulfill()
                        return
                    }
                    
                    let transactionAPI = TransactionAPI.shared
                    transactionAPI.setLiveMode(live: false)
                    
                    var tx = TX()
                    var txInput = TXInput()
                    txInput.addresses = ["mfaaDseeUpezpo4Dkgjysf4TcfjBr5Vy2V"]
                    tx.inputs = [txInput]
                    
                    var txOutput = TXOutput()
                    txOutput.addresses = [keyChain!.address]
                    txOutput.value = 10000
                    tx.outputs = [txOutput]
                    
                    transactionAPI.createNewTransactionEndpoint(tx: tx, flags: [:], completionHandler: { (txSkeleton, succ) in
                        guard var txSkeleton = txSkeleton else {
                            XCTFail()
                            exp.fulfill()
                            return
                        }
                        XCTAssert(txSkeleton.tosign.count > 0)
                        
                        let tosign = txSkeleton.tosign
                        var sigs: [String] = []
                        for sign in tosign {
                            sigs.append(sign)
                        }
                        txSkeleton.signatures = sigs
                        
                        transactionAPI.sendTransactionEndpoint(txSkeleton: txSkeleton, completionHandler: { (txSkeleton, succ) in
                            if succ != 201 {
                                XCTFail()
                            }
                            exp.fulfill()
                        })
                        
                        exp.fulfill()
                    })
                }
                
                
                
                self.waitForExpectations(timeout: .init(integerLiteral: 10000), handler: nil)
            }
        }
    
    }
    
}
