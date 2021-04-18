import SpriteKit
import AVFoundation

public final class Judy: SKSpriteNode {
    private static var privateShared : Judy?

    class func shared() -> Judy {
        guard let uwShared = privateShared else {
            privateShared = Judy(direction: "direita")
            return privateShared!
        }
        return uwShared
    }

    class func destroy() {
        privateShared = nil
    }

    var upTextures: [SKTexture] = []
    var downTextures: [SKTexture] = []
    var rightTextures: [SKTexture] = []
    var leftTextures: [SKTexture] = []
    var tilePosition: (Int, Int) = (0, 0)
    
    private init(direction: String) {
        let texture = SKTexture(imageNamed: "judy/direita/4.png")
        super.init(texture: texture, color: .black, size: texture.size())
        self.setupPosition()
        self.setupSprites()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition(to point: CGPoint) {
        let tiles = (Int(point.x) / 60, Int(point.y) / 60)
        self.tilePosition = tiles
        self.position = point
    }
    
    func setPosition(x: Int, y: Int) {
        self.tilePosition = (x,y)
        self.position = CGPoint(x: x * 60, y: y * 60)
    }
    
    func move(to points: [CGPoint]) {
        self.moveOne(points: points, position: self.position)
    }
    
    private func moveOne(points: [CGPoint], position: CGPoint) {
        var variablePoints = points
        
        if !variablePoints.isEmpty {
            let point = variablePoints.removeFirst()
            let direction = getDirection(point, position)
            let moveAction = SKAction.move(to: point, duration: 0.5)
            let animation = SKAction.animate(with: direction, timePerFrame: 0.125, resize: false, restore: true)
            let sound = SKAction.playSoundFileNamed("footstep.wav", waitForCompletion: false)
            
            GameScene.shared().run(sound, withKey: "walkingSound")
            self.run(SKAction.repeatForever(animation), withKey: "walking")
            
            self.run(moveAction, completion:  {
                self.removeAction(forKey: "walking")
                self.setPosition(to: point)
                self.texture = direction[3]
                self.moveOne(points: variablePoints, position: point)
            })
        }
        
        if Canvas.shared().tiles[self.tilePosition.0][self.tilePosition.1]!.isPortal {
            GameScene.shared().run(SKAction.playSoundFileNamed("forcefield.wav", waitForCompletion: false))
            GameScene.shared().nextLevel()
        }
        
    }
    
    private func getDirection(_ pointB: CGPoint, _ pointA: CGPoint) -> [SKTexture]{
        if pointB.y > pointA.y {
            return self.upTextures
            
        } else if pointB.y < pointA.y {
            return self.downTextures
            
        } else if pointB.x < pointA.x {
            return self.leftTextures
            
        } else if pointB.x > pointA.x {
            return self.rightTextures
        }
        
        return self.downTextures
    }
    
    private func setupPosition() {
        self.scale(to: CGSize(width: 70, height: 129))
        self.position = CGPoint(x: 5, y: 540)
        self.anchorPoint = CGPoint(x: 0.5, y: 0)
    }
    
    private func setupSprites() {
        for state in 1...6 {
            self.rightTextures.append(SKTexture(imageNamed: "judy/direita/\(state).png"))
            self.upTextures.append(SKTexture(imageNamed: "judy/cima/\(state).png"))
            self.leftTextures.append(SKTexture(imageNamed: "judy/esquerda/\(state).png"))
            self.downTextures.append(SKTexture(imageNamed: "judy/baixo/\(state).png"))
        }
    }
}

