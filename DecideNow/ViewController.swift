

import UIKit
import MDCSwipeToChoose
import AlamofireImage

class ViewController: UIViewController, MDCSwipeToChooseDelegate {
    
    var items: [Item]!
    var currentItem: Item!
    var frontCardView: MDCSwipeToChooseView!
    var backCardView: MDCSwipeToChooseView!
    var index = 0
    var timer: Timer!
    var countdown: UIView!
    var timeLabel: UILabel!
    var count = 10
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        self.view.backgroundColor = Const.MAIN_BACKGROUND_COLOR
        self.view.addSubview(UIView.makeHeader())
        
        self.setMyFrontCardView(frontCardView: createSwipeView(item: self.items[0]))
        self.view.addSubview(self.frontCardView)
        
        self.backCardView = createSwipeView(item: self.items[1])
        self.view.insertSubview(self.backCardView, belowSubview: self.frontCardView)
        
        self.currentItem = items[self.index]
        self.index = 1
        
        constructNopeButton()
        constructLikedButton()
        
        timeInit()
        
    }
    
    func timeInit(){
        countdown = UIView.makeCountDownView(frame: CGRect(x: Const.SCREEN_WIDTH - 60, y: 72, width: 50, height: 50))
        self.view.addSubview(countdown)
        self.view.bringSubview(toFront: countdown)
        
        timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        timeLabel.text = "\(self.count)"
        timeLabel.font = UIFont.systemFont(ofSize: 35)
        timeLabel.sizeToFit()
        timeLabel.textColor = UIColor.white
        timeLabel.backgroundColor = UIColor.clear
        timeLabel.layer.position = countdown.center
        self.view.addSubview(timeLabel)
    }

    func updateTime(_ timer: Timer){
        self.count -= 1
        if self.count == 0{
            self.nopeFrontCardView()
            self.count = 10
            countdown.removeFromSuperview()
            timeLabel.removeFromSuperview()
            self.timeInit()
        }else{
            timeLabel.text = "\(self.count)"
            timeLabel.font = UIFont.systemFont(ofSize: CGFloat(60 - CGFloat(self.count) * 2.5))
            timeLabel.sizeToFit()
            countdown.frame.size.width += 5
            countdown.frame.size.height += 5
            countdown.layer.cornerRadius += 2.5
            countdown.frame.origin.x -= 5
            countdown.frame.origin.y += 2.5
            timeLabel.layer.position = countdown.center
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        self.timer.fire()
        if Const.app.flag == true{
            self.nopeFrontCardView()
            Const.app.flag = false
            self.count = 10
            countdown.removeFromSuperview()
            timeLabel.removeFromSuperview()
            self.timeInit()
        }
    }
    
    func suportedInterfaceOrientations() -> UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    func view(_ view: UIView, wasChosenWith wasChosenWithDirection: MDCSwipeDirection) -> Void{
        
        if(wasChosenWithDirection == MDCSwipeDirection.left){
            self.count = 10
            countdown.removeFromSuperview()
            timeLabel.removeFromSuperview()
            self.timeInit()
        }
        else{
            self.likeFrontCardView()
        }
        if(self.backCardView != nil){
            self.setMyFrontCardView(frontCardView: self.backCardView)
            self.currentItem = items[self.index]
        }
        self.backCardView = createSwipeView(item: self.items[self.index + 1])
        self.index += 1
        
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
    
    func createSwipeView(item: Item) -> MDCSwipeToChooseView {
        let options = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.likedText = "BUY"
        options.likedColor = UIColor.green
        options.nopeText = "NEXT"
        options.nopeColor = UIColor.lightGray
        
        let swipeView = MDCSwipeToChooseView(
            frame: CGRect(
                x: Const.SCREEN_WIDTH * 0.05,
                y: 90,
                width: Const.SCREEN_WIDTH * 0.9,
                height: Const.SCREEN_HEIGHT - 200
            ),
            options: options
        )
        
        swipeView?.backgroundColor = UIColor.rgba(r: 248, g: 248, b: 248, a: 1.0)
        
        swipeView?.imageView.af_setImage(withURL: URL(string: item.image_url)!)
        swipeView?.imageView.frame = CGRect(x: 0, y: 0, width: (swipeView?.frame.width)!, height: (swipeView?.frame.width)!)
        
        let p: Int = item.price
        let pp: Int = item.pre_price
        let name:String = item.name
        
        let title = UILabel()
        title.frame = CGRect(x: 30, y: (swipeView?.imageView.frame.maxY)! + 5, width: 250, height: 40)
        title.text = name
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: 18)
        swipeView?.addSubview(title)
        
        
        let price = UILabel()
        price.frame = CGRect(x: 30, y: title.frame.maxY + 5, width: 150, height: 30)
        price.text = "$\(p)"
        price.textColor = UIColor.red
        price.font = UIFont.systemFont(ofSize: 18)
        price.textAlignment = NSTextAlignment.left
        price.sizeToFit()
        swipeView?.addSubview(price)
        
        let pre = UILabel()
        pre.frame = CGRect(x: price.frame.maxX + 10, y: price.frame.origin.y, width: 150, height: 30)
        pre.text = "$\(pp)"
        pre.textColor = UIColor.gray
        pre.font = UIFont.systemFont(ofSize: 14)
        pre.textAlignment = NSTextAlignment.left
        pre.sizeToFit()
        pre.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
        pre.layer.position = CGPoint(x: price.frame.maxX + 10, y: price.center.y)
        swipeView?.addSubview(pre)
        
        
        let detail = UIButton()
        detail.frame = CGRect(x: Const.SCREEN_WIDTH * 0.45 - 50, y: (swipeView?.frame.height)! - 40, width: 100, height: 30)
        detail.backgroundColor = UIColor.cyan
        detail.setTitle("Detail", for: .normal)
        detail.setTitleColor(UIColor.white, for: .normal)
        detail.addTarget(self, action: #selector(self.goDetail), for: .touchUpInside)
        swipeView?.addSubview(detail)
        
        return swipeView!
    }
    
    func constructNopeButton() -> Void{
        let frame = CGRect(x: 20, y: self.frontCardView.frame.maxY + 40, width: 100, height: 30)
        let button = UIButton.nextButton(frame: frame)
        button.addTarget(self, action: #selector(self.nopeFrontCardView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
    func constructLikedButton() -> Void{
        let frame = CGRect(x: Const.SCREEN_WIDTH - 20 - 100, y: self.frontCardView.frame.maxY + 40, width: 100, height: 30)
        let button = UIButton.buyButton(frame: frame)
        button.addTarget(self, action: #selector(self.likeFrontCardView), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
    }
    
    func goDetail(){
        timer.invalidate()
        let detail = DetailViewController()
        detail.currentItem = self.currentItem
        self.present(detail, animated: true, completion: nil)
    }
    
    func nopeFrontCardView() -> Void{
        self.frontCardView.mdc_swipe(MDCSwipeDirection.left)
        self.count = 10
        countdown.removeFromSuperview()
        timeLabel.removeFromSuperview()
        self.timeInit()
    }
    
    func likeFrontCardView() -> Void{
//        self.frontCardView.mdc_swipe(MDCSwipeDirection.right)
        timer.invalidate()
        let buy = PurchaceViewController()
        buy.fromTop = true
        self.present(buy, animated: true, completion: nil)
    }
}
