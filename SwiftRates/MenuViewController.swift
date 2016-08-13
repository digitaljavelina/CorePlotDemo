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

class MenuViewController: UIViewController {
  
  @IBOutlet weak var symbol1Button: UIButton!
  @IBOutlet weak var symbol1Label: UILabel!
  @IBOutlet weak var symbol2Button: UIButton!
  @IBOutlet weak var symbol2Label: UILabel!
  @IBOutlet weak var symbol3Button: UIButton!
  @IBOutlet weak var symbol3Label: UILabel!
  
  var currency1: Currency! {
    didSet {
      symbol1Button.setImage(currency1.image, forState: .Normal)
      symbol1Label.text = currency1.name
    }
  }
  
  var currency2: Currency! {
    didSet {
      symbol2Button.setImage(currency2.image, forState: .Normal)
      symbol2Label.text = currency2.name
    }
  }
  
  var currency3: Currency! {
    didSet {
      symbol3Button.setImage(currency3.image, forState: .Normal)
      symbol3Label.text = currency3.name
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    currency1 = Currency.currency(named: "USD")!
    currency2 = Currency.currency(named: "GBP")!
    currency3 = Currency.currency(named: "EUR")!
  }
  
}

// MARK: Actions

extension MenuViewController {
  
  @IBAction func symbol1Tapped(sender: UIButton) {
    hideView(sender) {
      self.currency1 = self.nextCurrency(currency: self.currency1)
      self.showView(sender, completion: {
        
      })
    }
  }
  
  @IBAction func symbol2Tapped(sender: UIButton) {
    hideView(sender) {
      self.currency2 = self.nextCurrency(currency: self.currency2)
      self.showView(sender, completion: {
        
      })
    }
  }
  
  @IBAction func symbol3Tapped(sender: UIButton) {
    hideView(sender) {
      self.currency3 = self.nextCurrency(currency: self.currency3)
      self.showView(sender, completion: {
        
      })
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let vc = segue.destinationViewController as? HostViewController {
      vc.base = currency1
      vc.symbols = [currency2, currency3]
    }
  }
  
}

// MARK: Helpers

extension MenuViewController {
  
  func nextCurrency(currency currency: Currency) -> Currency {
    let index = Currency.currencies.indexOf(currency)!
    let nextIndex = (index + 1) % Currency.currencies.count
    let currency = Currency.currencies[nextIndex]
    if currency == currency1 || currency == currency2 || currency == currency3 {
      return nextCurrency(currency: currency)
    } else {
      return currency
    }
  }
  
}

// MARK: Animations

extension MenuViewController {
  
  func hideView(view: UIView, completion: () -> Void) {
    UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions(), animations: {
      UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.4, animations: {
        view.transform = CGAffineTransformMakeScale(1.1, 1.1)
      })
      UIView.addKeyframeWithRelativeStartTime(0.4, relativeDuration: 0.6, animations: {
        view.transform = CGAffineTransformMakeScale(0.001, 0.0001)
      })
    }) { (finished) in
      completion()
    }
  }
  
  func showView(view: UIView, completion: () -> Void) {
    UIView.animateKeyframesWithDuration(0.3, delay: 0.0, options: UIViewKeyframeAnimationOptions(), animations: {
      UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.6, animations: {
        view.transform = CGAffineTransformMakeScale(1.1, 1.1)
      })
      UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.4, animations: {
        view.transform = CGAffineTransformIdentity
      })
    }) { (finished) in
      completion()
    }
  }
  
}
