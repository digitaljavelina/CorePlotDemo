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

import UIKit
import CorePlot

class PieChartViewController: UIViewController {
  
  @IBOutlet weak var hostView: CPTGraphHostingView!
  
  var base: Currency!
  var rate: Rate!
  var symbols: [Currency]!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // add the base currency to the symbols, so it will show on the graph
    symbols.insert(base, atIndex: 0)
  }
  
}

extension PieChartViewController: CPTPieChartDataSource, CPTPieChartDelegate {
  
  func numberOfRecordsForPlot(plot: CPTPlot) -> UInt {
    return 0
  }
  
  func numberForPlot(plot: CPTPlot, field fieldEnum: UInt, recordIndex idx: UInt) -> AnyObject? {
    return 0
  }
  
  func dataLabelForPlot(plot: CPTPlot, recordIndex idx: UInt) -> CPTLayer? {
    return nil
  }
  
  func sliceFillForPieChart(pieChart: CPTPieChart, recordIndex idx: UInt) -> CPTFill? {
    return nil
  }
  
  func legendTitleForPieChart(pieChart: CPTPieChart, recordIndex idx: UInt) -> String? {
    return nil
  }
  
}
