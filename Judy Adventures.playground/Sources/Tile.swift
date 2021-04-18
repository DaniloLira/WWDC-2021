import SpriteKit

public class Tile: SKSpriteNode {
    var visited: Bool = false
    var connections: [Connection] = []
    var coordinate: (Int, Int)
    var hasET: Bool = false
    var isPortal: Bool = false
    
    init(x: Int, y: Int, hasET: Bool = false, isPortal: Bool = false) {
        self.hasET = hasET
        self.isPortal = isPortal
        var imageName = ""
        
        switch Canvas.shared().level {
        case .first:
            imageName = !isPortal ? "Piso" : "Portal"
        case .second:
            imageName = !isPortal ? "Piso 2" : "Portal 2"
        case .third:
            imageName = "Piso 3.png"
        }
        
        let texture = SKTexture(imageNamed: imageName)
        let positionX = (x * 60)
        let positionY = (y * 60)
        
        self.coordinate = (x, y)
        super.init(texture: texture, color: .black, size: texture.size())
        self.position = CGPoint(x: positionX, y: positionY)
        self.anchorPoint = CGPoint(x: 0.3, y: 0.5)
        self.scale(to: CGSize(width: 60, height: 60))
        self.isUserInteractionEnabled = true
        
        if isPortal {
            let emitter = SKEmitterNode(fileNamed: "PortalParticle")
            emitter?.position = CGPoint(x: 20, y: 55)
            //emitter?.zPosition = 1
            self.addChild(emitter!)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent? ){
            if !hasET {
                let judy = Judy.shared()
                let judyX = judy.tilePosition.0
                let judyY = judy.tilePosition.1
                
                if let path = Canvas.shared().shortestPath(source: Canvas.shared().tiles[judyX][judyY]!, destination: self) {
                    Judy.shared().move(to: path)
                }
            }
    }
}

public class Connection {
    let to: Tile
    var weight: Int = 1
    
    init(to node: Tile) {
        self.to = node
    }
}

public class Path {
    let cumulativeWeight: Int
    let node: Tile
    let previousPath: Path?
    var path: [Tile] = []
    
    public init(to node: Tile, via connection: Connection? = nil, previousPath path: Path? = nil) {
        if let previousPath = path, let viaConnection = connection {
            self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
        } else {
            self.cumulativeWeight = 0
        }
        
        self.node = node
        self.previousPath = path
    }
    
    func getPath(totalPath: [(Int,Int)]) -> [(Int, Int)]{
        var varTotalPath = totalPath
        
        if let path = self.previousPath {
            varTotalPath.insert(self.node.coordinate, at: 0)
            return path.getPath(totalPath: varTotalPath)
        }
        
        return varTotalPath
    }
}
