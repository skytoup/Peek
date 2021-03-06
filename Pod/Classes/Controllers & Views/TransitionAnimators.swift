/*
  Copyright © 23/04/2016 Shaps

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
 */

import UIKit

/// Defines an animator that provides a custom fade animation for Peek's navigation controller
final class TransitionFadeAnimator: NSObject, UIViewControllerAnimatedTransitioning {
  
  fileprivate unowned let peek: Peek
  fileprivate let operation: UINavigationControllerOperation
  
  init(peek: Peek, operation: UINavigationControllerOperation) {
    self.peek = peek
    self.operation = operation
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.25
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
    let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
    
    transitionContext.containerView.addSubview(toController.view)
    toController.view.alpha = 0
    toController.navigationController?.setNavigationBarHidden(self.operation == .pop, animated: true)
    
    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
      fromController.view.alpha = 0
      toController.view.alpha = 1
    }, completion: { (finished) in
      transitionContext.completeTransition(finished)
    }) 
  }
  
}
