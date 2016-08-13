/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Alamofire
import SwiftDate

class DataStore {
  
  static var sharedStore = DataStore()
  
  let APIBaseURL = "http://api.fixer.io"
  let APIDateFormat = DateFormat.Custom("yyyy-MM-dd")
  
  func getRates(fromDateString fromDateString: String, toDateString: String, base: String, symbols: [String], success: (rates: [Rate]) -> Void, failure: (error: NSError?) -> Void) {
    guard let fromDate = fromDateString.toDate(APIDateFormat),
      toDate = toDateString.toDate(APIDateFormat) else {
        failure(error: nil)
        return
    }
    print("Fetching \(base)/\(symbols.joinWithSeparator("/")) rates \(fromDateString) to \(toDateString)")
    let queue = TaskQueue()
    var rates = [Rate]()
    var currentDate = fromDate
    while (currentDate <= toDate) {
      let date = currentDate.toString(self.APIDateFormat)!
      queue.tasks +=~ { result, next in
        self.getRate(date: date, base: base, symbols: symbols, success: { (rate) in
          rates.append(rate)
          next(nil)
          }, failure: { (error) in
            next(nil)
        })
      }
      currentDate = currentDate + 1.days
    }
    queue.run() {
      print("Done")
      success(rates: rates)
    }
  }
  
  func getRate(date date: String, base: String, symbols: [String], success: (rate: Rate) -> Void, failure: (error: NSError?) -> Void) {
    Alamofire.request(.GET, "\(APIBaseURL)/\(date)", parameters: [
      "base": base,
      "symbols": symbols.joinWithSeparator(",")
      ]).responseJSON { (response) in
        if let error = response.result.error {
          failure(error: error)
          return
        }
        guard let json = response.result.value as? [String: AnyObject],
          date = json["date"] as? String,
          base = json["base"] as? String,
          rates = json["rates"] as? [String: NSNumber] else {
            failure(error: nil)
            return
        }
        let rate = Rate(date: date, base: base, rates: rates)
        success(rate: rate)
    }
  }
  
}
