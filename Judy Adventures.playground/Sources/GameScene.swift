import SpriteKit
import GameplayKit

public class GameScene: SKScene{
    private static var privateShared : GameScene?

    class func shared() -> GameScene {
        guard let sharedInstance = privateShared else {
            privateShared = GameScene()
            return privateShared!
        }
        return sharedInstance
    }

    class func destroy() {
        JudysBook.destroy()
        Graybackground.destroy()
        Judy.destroy()
        Popup.destroy()
        Canvas.destroy()
        Questions.destroy()
        privateShared = nil
    }
    
    let canvas = Canvas.shared()
    let book = JudysBook.shared()
    var ets: [ET] = []
    let background = SKSpriteNode(imageNamed: "background.png")
    
    override public init() {
        let frame = CGRect(x:0, y:0, width: 650, height: 900)
        super.init(size: frame.size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMove(to view: SKView) {
        self.setupBackground()
        self.addChild(background)
        
        self.canvas.firstLevel()
       
        
        self.addChild(Judy.shared())
        
        self.setupJudysBook()
        self.addChild(Graybackground.shared())
        self.addChild(book)
        self.addChild(Popup.shared())
        
        let backgroundSound = SKAudioNode(fileNamed: "InGameBackground.wav")
        self.addChild(backgroundSound)
        backgroundSound.run(SKAction.play())
    }
    
    func removeET(et: ET) {
        et.removeFromParent()
        self.canvas.tiles[et.tilePosition.0][et.tilePosition.1]!.hasET = false
        self.ets.removeAll(where: { listET in
            listET.tilePosition == et.tilePosition
        })
    }
    
    
    func nextLevel(){
        for tile in canvas.positionedTiles() {
            tile.removeFromParent()
        }
        
        for et in ets {
            et.removeFromParent()
        }
        
        if canvas.level == .first {
            canvas.secondLevel()
        } else if canvas.level == .second{
            canvas.thirdLevel()
        } else if canvas.level == .third {
            
        }
    }
    
    func winGame(){
        GameScene.destroy()
        let sceneMoveTo = GameWinScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        let transition = SKTransition.moveIn(with: .down, duration: 0.3)
        view?.presentScene(sceneMoveTo ,transition: transition)
    }
    
    func setupJudysBook() {
        var judysBook = SKButtonNode(image: .init(imageNamed: "cadernos/Caderno Pequeno.png"), label: .init(text: ""), action: {
            self.book.isHidden = false
            Graybackground.shared().isHidden = false
        })
        
        judysBook.image!.position = CGPoint(x: 36, y: 36)
        judysBook.image!.anchorPoint = CGPoint(x: 0, y: 0)
        judysBook.image!.scale(to: CGSize(width: 150, height: 182.92))
        
        self.addChild(judysBook)
    }
    func setupBackground(){
        background.scale(to: CGSize(width: 650, height: 900))
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
    }
    
    func backToStart() {
        let sceneMoveTo = StartScene(size: self.size)
        sceneMoveTo.scaleMode = self.scaleMode
        let transition = SKTransition.moveIn(with: .down, duration: 0.3)
        view?.presentScene(sceneMoveTo ,transition: transition)
    }
}
