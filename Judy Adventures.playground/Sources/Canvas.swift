import SpriteKit

public final class Canvas {
    private static var privateShared : Canvas?

    class func shared() -> Canvas {
        guard let uwShared = privateShared else {
            privateShared = Canvas()
            return privateShared!
        }
        return uwShared
    }

    class func destroy() {
        privateShared = nil
    }
    
    var tiles: [[Tile?]] = []
    var rows: Int = 14
    var columns: Int = 15
    var level: Level = .first
    
    
    private init() {
        let line = Array<Tile?>(repeating: nil, count: rows)
        self.tiles = Array<[Tile?]>(repeating: line, count: columns)
    }
    
    func firstLevel() {
        GameScene.shared().ets = [
            ET(color: .yellow, x: 6, y: 8),
            ET(color: .green, x: 5, y: 6)
        ]
        
        Judy.shared().setPosition(x: 2, y: 7)
        
        self.addTile(x: 2, y: 7)
        self.addTile(x: 3, y: 7)
        self.addTile(x: 4, y: 7)
        self.addTile(x: 4, y: 8)
        self.addTile(x: 5, y: 8)
        self.addTile(x: 6, y: 8, hasET: true)
        self.addTile(x: 7, y: 8)
        self.addTile(x: 4, y: 6)
        self.addTile(x: 5, y: 6, hasET: true)
        self.addTile(x: 6, y: 6)
        self.addTile(x: 7, y: 6)
        self.addTile(x: 7, y: 7)
        self.addTile(x: 8, y: 7)
        self.addTile(x: 9, y: 7, isPortal: true)
        self.setupETSAndTiles()
    }
    
    func secondLevel() {
        self.level = .second
        self.reset()
        
        let et = ET(color: .green, x: 5, y: 6)
        et.zPosition = 2
        
        GameScene.shared().ets = [
            et,
            ET(color: .purple, x: 8, y: 6),
            ET(color: .yellow, x: 8, y: 4)
        ]
        
        Judy.shared().setPosition(x: 2, y: 5)
        
        self.addTile(x: 2, y: 5)
        self.addTile(x: 2, y: 6)
        self.addTile(x: 2, y: 7)
        self.addTile(x: 2, y: 8)
        self.addTile(x: 2, y: 9)
        
        self.addTile(x: 3, y: 9)
        self.addTile(x: 4, y: 9)
        self.addTile(x: 5, y: 9)
        
        self.addTile(x: 5, y: 8)
        self.addTile(x: 5, y: 7)
        self.addTile(x: 5, y: 6, hasET: true)
        
        
        self.addTile(x: 4, y: 6, hasET: true)
        self.addTile(x: 6, y: 6)
        
        self.addTile(x: 4, y: 5)
        self.addTile(x: 5, y: 5)
        self.addTile(x: 6, y: 5)
        
        self.addTile(x: 8, y: 6)
        self.addTile(x: 9, y: 6)
        
        self.addTile(x: 7, y: 6)
        self.addTile(x: 7, y: 4)
        self.addTile(x: 6, y: 4)
        
        self.addTile(x: 9, y: 5, isPortal: true)
        self.addTile(x: 9, y: 4)
        self.addTile(x: 8, y: 4, hasET: true)
        self.setupETSAndTiles()
    }
    
    func thirdLevel() {
        self.level = .third
        self.reset()
        
        let et = ET(color: .yellow, x: 3, y: 11)
        et.setScale(0.13)
        
        GameScene.shared().ets = [
            ET(color: .green, x: 3, y: 5),
            ET(color: .purple, x: 5, y: 7),
            ET(color: .purple, x: 7, y: 6),
            et
        ]
        
        Judy.shared().setPosition(x: 9, y: 6)
        
        self.addTile(x: 9, y: 11)
        self.addTile(x: 8, y: 11)
        self.addTile(x: 7, y: 11)
        self.addTile(x: 6, y: 11)
        self.addTile(x: 5, y: 11)
        self.addTile(x: 4, y: 11)
        self.addTile(x: 2, y: 11)
        
        self.addTile(x: 3, y: 11, hasET: true)
        self.addTile(x: 3, y: 10)
        self.addTile(x: 3, y: 9)
        self.addTile(x: 3, y: 8)
        
        self.addTile(x: 5, y: 11)
        self.addTile(x: 5, y: 10)
        self.addTile(x: 5, y: 9)
        self.addTile(x: 5, y: 8)
        
        self.addTile(x: 5, y: 7, hasET: true)
        self.addTile(x: 4, y: 7)
        self.addTile(x: 3, y: 7)
        self.addTile(x: 2, y: 7)
        self.addTile(x: 2, y: 6)
        self.addTile(x: 2, y: 5)
        
        self.addTile(x: 3, y: 5, hasET: true)
        self.addTile(x: 4, y: 5)
        self.addTile(x: 5, y: 5)
        self.addTile(x: 6, y: 5)
        self.addTile(x: 6, y: 6)
        
        self.addTile(x: 7, y: 6, hasET: true)
        self.addTile(x: 8, y: 6)
        self.addTile(x: 9, y: 6)

        self.setupETSAndTiles()
        
        Rocket()

        
        
    }
    
    func setupETSAndTiles() {
        self.positionedTiles().map { tile in
            GameScene.shared().addChild(tile)
        }
        
        GameScene.shared().ets.map { et in
            GameScene.shared().addChild(et)
        }
    }
    
    func reset() {
        let line = Array<Tile?>(repeating: nil, count: rows)
        self.tiles = Array<[Tile?]>(repeating: line, count: columns)
    }
    
    func positionedTiles() -> [SKSpriteNode]{
        var tilesArray: [SKSpriteNode] = []
        for row in tiles {
            for tile in row {
                if let safeTile = tile {
                    tilesArray.append(safeTile)
                }
            }
        }
        return tilesArray
    }
    
    func addTile(x: Int, y: Int, hasET: Bool = false, isPortal: Bool = false) {
        let tile = Tile(x: x, y: y, hasET: hasET, isPortal: isPortal)
        self.tiles[x][y] = tile

        if x > 0 && self.tiles[x-1][y] != nil{
            tile.connections.append(Connection(to: self.tiles[x-1][y]!))
            self.tiles[x-1][y]!.connections.append(Connection(to: tile))
        }
        if x < columns && self.tiles[x+1][y] != nil {
            tile.connections.append(Connection(to: self.tiles[x+1][y]!))
            self.tiles[x+1][y]!.connections.append(Connection(to: tile))
        }
        if y > 0 && self.tiles[x][y-1] != nil {
            tile.connections.append(Connection(to: self.tiles[x][y-1]!))
            self.tiles[x][y-1]!.connections.append(Connection(to: tile))
        }
        if y < rows && self.tiles[x][y+1] != nil {
            tile.connections.append(Connection(to: self.tiles[x][y+1]!))
            self.tiles[x][y+1]!.connections.append(Connection(to: tile))
        }
    }
    func shortestPath(source: Tile, destination: Tile) -> [CGPoint]? {
        var frontier: [Path] = [] {
            didSet { frontier.sort {
                return $0.cumulativeWeight < $1.cumulativeWeight
            } } }
        var visitedNodes: [Tile] = []
        frontier.append(Path(to: source))
        
        while !frontier.isEmpty {
            var firstAlienlessFrontier: Path? = nil
            
            while firstAlienlessFrontier == nil && !frontier.isEmpty {
                if !frontier.isEmpty {
                    let frontierNode = frontier.removeFirst()
                    firstAlienlessFrontier = !frontierNode.node.hasET ? frontierNode : nil
                }
                
            }
            
            guard let cheapestPathInFrontier = firstAlienlessFrontier else {continue}
            guard !cheapestPathInFrontier.node.visited else { continue }
            
            if cheapestPathInFrontier.node === destination {
                for node in visitedNodes{ node.visited = false }
                let nodesPath = cheapestPathInFrontier.getPath(totalPath: [])
                
                return nodesPath.map { CGPoint(x: (60 * $0.0), y: (60 * $0.1))}
            }
            
            cheapestPathInFrontier.node.visited = true
            visitedNodes.append(cheapestPathInFrontier.node)
            for connection in cheapestPathInFrontier.node.connections where !connection.to.visited {
                frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
            }
        }
        for node in visitedNodes{
            node.visited = false
        }
        
        return nil
    }
}

enum Level {
    case first
    case second
    case third
}
