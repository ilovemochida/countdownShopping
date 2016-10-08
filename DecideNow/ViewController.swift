

import UIKit
import MDCSwipeToChoose
import AlamofireImage

class ViewController: UIViewController, MDCSwipeToChooseDelegate {
    
    var people:[Item] = []
    var currentPerson: Item!
    var frontCardView: MDCSwipeToChooseView!
    var backCardView: MDCSwipeToChooseView!
    
    var photoURL = [
        "http://up.gc-img.net/post_img_web/2013/03/a3a43755438b42d881929eefc7161191_0.jpeg",
        "http://pic.prepics-cdn.com/pib1298076039/5731792_218x291.gif",
        "http://omosoku.com/wp-content/uploads/misawa-225x300.gif"
    ]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.view.backgroundColor = Const.MAIN_BACKGROUND_COLOR
        self.view.addSubview(UIView.makeHeader())
        
        self.setMyFrontCardView(frontCardView: createSwipeView(url: photoURL[0]))
        self.view.addSubview(self.frontCardView)
        
        self.backCardView = createSwipeView(url: photoURL[1])
        self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
        
        constructNopeButton()
        constructLikedButton()
    }
    func suportedInterfaceOrientations() -> UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    func view(_ view: UIView, wasChosenWith wasChosenWithDirection: MDCSwipeDirection) -> Void{
        
        if(wasChosenWithDirection == MDCSwipeDirection.left){
        }
        else{
        }
        if(self.backCardView != nil){
            self.setMyFrontCardView(frontCardView: self.backCardView)
        }
        self.backCardView = createSwipeView(url: photoURL[2])
        
        if(backCardView != nil){
            self.backCardView.alpha = 0.0
            self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                self.backCardView.alpha = 1.0
                },completion:nil)
        }
    }
    
    func setMyFrontCardView(frontCardView: MDCSwipeToChooseView) -> Void{
        self.frontCardView = frontCardView
    }
    
    func createSwipeView(url: String) -> MDCSwipeToChooseView {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "BUY"
        options.likedColor = UIColor.green
        options.nopeText = "NEXT"
        options.nopeColor = UIColor.lightGray
        
        let swipeView = MDCSwipeToChooseView(
            frame: CGRect(
                x: 0,
                y: 82,
                width: self.view.bounds.size.width,
                height: self.view.bounds.size.height - 150
            ),
            options: options
        )
        
        swipeView?.backgroundColor = UIColor.rgba(r: 248, g: 248, b: 248, a: 1.0)
        
        swipeView?.imageView.af_setImage(withURL: URL(string: url)!)
        swipeView?.imageView.frame = CGRect(x: 0, y: 0, width: (swipeView?.frame.width)!, height: (swipeView?.frame.width)!)
        
        let price = UILabel()
        price.frame = CGRect(x: 30, y: (swipeView?.imageView.frame.maxY)! + 18, width: 150, height: 30)
        price.text = "10,000yen <- (15,000yen) "
        price.textColor = UIColor.red
        price.textAlignment = NSTextAlignment.left
        price.sizeToFit()
        swipeView?.addSubview(price)
        
        let detail = UIButton()
        detail.frame = CGRect(x: Const.SCREEN_WIDTH / 2 - 50, y: (swipeView?.frame.height)! - 40, width: 100, height: 30)
        detail.backgroundColor = UIColor.cyan
        detail.setTitle("Detail", for: .normal)
        detail.setTitleColor(UIColor.white, for: .normal)
        detail.addTarget(self, action: #selector(self.goDetail), for: .touchUpInside)
        swipeView?.addSubview(detail)
        
        return swipeView!
    }
    
    func constructNopeButton() -> Void{
        let frame = CGRect(x: 20, y: self.frontCardView.frame.maxY + 20, width: 100, height: 30)
        let button = UIButton.nextButton(frame: frame)
        button.addTarget(self, action: #selector(self.nopeFrontCardView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
    func constructLikedButton() -> Void{
        let frame = CGRect(x: Const.SCREEN_WIDTH - 20 - 100, y: self.frontCardView.frame.maxY + 20, width: 100, height: 30)
        let button = UIButton.buyButton(frame: frame)
        button.addTarget(self, action: #selector(self.likeFrontCardView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
    }
    
    func goDetail(){
        let detail = DetailViewController()
        self.present(detail, animated: true, completion: nil)
    }
    
    func nopeFrontCardView() -> Void{
        self.frontCardView.mdc_swipe(MDCSwipeDirection.left)
    }
    
    func likeFrontCardView() -> Void{
        self.frontCardView.mdc_swipe(MDCSwipeDirection.right)
    }
}
