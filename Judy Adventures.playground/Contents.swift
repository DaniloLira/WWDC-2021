import PlaygroundSupport
import SpriteKit


/*:
 # Judy's Adventures
 A game where an astronaut explores other planets and learn more about the space.
 
 ## The Game
 In Judy's adventure you need to help him to reach his rocket and come back home, but the aliens will not allow you to pass until you answer their questions. The aliens are friendly and just want to ensure that Judy really learned something from his time on the space.
 
 - The astronaut has a travel journal where he writes everything he knows about the aliens and his discoveries from the space.
 - You just can talk to an alien when you are close to him, so walk to the aliens.
 - To reach another planet Judy needs to go through the portals.
 
 Learn about the space and help Judy to go home!
*/

/*:
# WHO AM I?

Hello my name is Danilo Lira i am from Apple Developer Academy of Recife-PE, Brazil.

I am an Information Systems student at the Centro de Informática - Universidade Federal de Pernambuco(Cin - UFPE) and a member of Apple Developer Academy. Judy's Adventures is my first game and my first playground experience, i always liked games since i was a little kid, but never tought of developing one myself, so i decided to accept this challenge and create this game. This experience made me grow very much as a developer, designer and innovator especially because i always found the universe, other planets and stars really fascinating, but knew so few about it and that's why i started to think about this game. I wanted a game where the player could learn more about space while feeling like an astronaut and getting to know other forms of life. Using SpriteKit to give life to this ideia was a great experience and i learned so much about game design through the whole process, i'm very happy with the final result and hope you enjoy!!!
*/
/*:
 
 ### Credits
 
 The In game music is called “Frozen Village”, from PlayOnLoop.com. Licensed under Creative Commons by Attribution 4.0
 The game sound effects are from Kenney under License: (CC0 1.0 Universal)
 */

let cfURL = Bundle.main.url(forResource: "OpenSans", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)

let font = Bundle.main.url(forResource: "Kalam", withExtension: "ttf")! as CFURL
CTFontManagerRegisterFontsForURL(font, CTFontManagerScope.process, nil)

let frame = CGRect(x:0, y:0, width: 650, height: 900)
let view = SKView(frame: frame)
var game = StartScene(size: frame.size)

view.presentScene(game)
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.setLiveView(view)





