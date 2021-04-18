import SpriteKit

public final class JudysBook: SKSpriteNode {
    private static var privateShared : JudysBook?

    class func shared() -> JudysBook {
        guard let uwShared = privateShared else {
            privateShared = JudysBook()
            return privateShared!
        }
        return uwShared
    }

    class func destroy() {
        privateShared = nil
    }
    
    
    var discoverysTag = SKButtonNode()
    var aliensTag = SKButtonNode()
    let aliensAnotation = SKSpriteNode(imageNamed: "cadernos/Pagina alien.png")
    var discoverys: [Discover] = []
    
    var isPageAliens: Bool = true
    
    private init() {
        let texture = SKTexture(imageNamed: "cadernos/Caderno aberto.png")
        super.init(texture: texture, color: .black, size: texture.size())
        
        discoverys.map { discover in
            self.addChild(discover)
        }
        
        self.discoverysTag = SKButtonNode(image: .init(imageNamed: "Descobertas.png"), label: .init(text: ""), action: { self.touchDiscoveryTag() })
        self.aliensTag = SKButtonNode(image: .init(imageNamed: "Alienigena.png"), label: .init(text: ""), action: { self.touchAlienTag() })
        
        
        self.setupStyles()
        self.setupTags()
        self.setupAnnotations()
        self.setupDiscoverys()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openBook() {
        self.isPageAliens = true
        self.touchDiscoveryTag()
        Graybackground.shared().isHidden = false
        self.isHidden = false
    }
    
    func addDiscover(etColor: ETColor, text: String) {
        let discover = Discover(cardColor: etColor, text: text)
        self.discoverys.append(discover)
        self.addChild(discover)
        self.setupDiscoverys()
    }
    
    func touchAlienTag() { //Criar uma página de descobertas e esconde-la ao ines de iterar sobre as descobertae
        if !isPageAliens {
            let currentTagX = aliensTag.position.x
            let currentTagZ = aliensTag.zPosition
            aliensTag.position.x = discoverysTag.position.x
            aliensTag.zPosition = discoverysTag.zPosition
            discoverysTag.position.x = currentTagX
            discoverysTag.zPosition = currentTagZ
            self.isPageAliens = true
            for discover in discoverys {
                discover.isHidden = true
            }
            aliensAnotation.isHidden = false
        }
        
    }
    
    func touchDiscoveryTag() {
        if isPageAliens {
            let currentTagX = discoverysTag.position.x
            let currentTagZ = discoverysTag.zPosition
            discoverysTag.position.x = aliensTag.position.x
            discoverysTag.zPosition = aliensTag.zPosition
            aliensTag.position.x = currentTagX
            aliensTag.zPosition = currentTagZ
            

            self.isPageAliens = false
            for discover in discoverys {
                discover.isHidden = false
            }
            aliensAnotation.isHidden = true
        }
        
    }
    
    private func setupTags() {
        self.addChild(discoverysTag)
        self.addChild(aliensTag)
        
        discoverysTag.setScale(0.45)
        discoverysTag.position = CGPoint(x: 1020, y: 950)
        discoverysTag.zPosition = 1
        
        aliensTag.setScale(0.45)
        aliensTag.position = CGPoint(x: 1010, y: 1150)
        aliensTag.zPosition = 2
    }
    
    private func setupDiscoverys() {
        var line = 0
        
        for item in 0..<discoverys.count {
            discoverys[item].isHidden = true
            discoverys[item].position = CGPoint(x: 140 + (!item.isMultiple(of: 2) ? 400 : 0), y: (1000 - line * 400))
            discoverys[item].anchorPoint = CGPoint(x: 0, y: 0)
            discoverys[item].setScale(0.4)
            
            if (item % 2 == 1) { line += 1 }
        }
    }
    
    private func setupAnnotations() {
        self.addChild(aliensAnotation)
        
        aliensAnotation.setScale(0.85)
        aliensAnotation.anchorPoint = CGPoint(x: 0, y: 0)
        aliensAnotation.position = CGPoint(x: 100, y: 40)
    }
    
    private func setupStyles() {
        self.isHidden = true
        self.scale(to: CGSize(width: 519.34, height: 692))
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 70, y: 100)
        self.zPosition = 2
    }
}
