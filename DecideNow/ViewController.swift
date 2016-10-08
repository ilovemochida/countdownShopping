

import UIKit
import MDCSwipeToChoose
import AlamofireImage

class ViewController: UIViewController, MDCSwipeToChooseDelegate  {

    var swipeCount = 0
    var photoURL = [
        "http://up.gc-img.net/post_img_web/2013/03/a3a43755438b42d881929eefc7161191_0.jpeg",
        "http://pic.prepics-cdn.com/pib1298076039/5731792_218x291.gif",
        "http://omosoku.com/wp-content/uploads/misawa-225x300.gif"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeView1 = createSwipeView(url: photoURL[0])
        self.view.addSubview(swipeView1)
        
        let swipeView2 = createSwipeView(url: photoURL[1])
        self.view.insertSubview(swipeView2, belowSubview: swipeView1)
        
        let swipeView3 = createSwipeView(url: photoURL[2])
        self.view.insertSubview(swipeView3, belowSubview: swipeView2)
        
    }
    
    func createSwipeView(url: String) -> UIView {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "BUY"
        options.likedColor = UIColor.green
        options.nopeText = "NEXT"
        options.nopeColor = UIColor.lightGray
        
        let swipeView = MDCSwipeToChooseView(
            frame: CGRect(
                x: 0,
                y: 100,
                width: self.view.bounds.size.width,
                height: self.view.bounds.size.height - 300
            ),
            options: options
        )
        
        swipeView?.imageView.af_setImage(withURL: URL(string: url)!)
        
        return swipeView!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

