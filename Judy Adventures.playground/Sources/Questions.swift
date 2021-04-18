import Foundation


public final class Questions {
    var list: [Question] = [
        Question("Judy, do you remember the name of the biggest planet of the Solar System?", alt_one: "Jupiter", alt_two: "Saturn", alt_three: "Uranus", correct: .alternative_one, answeredRightText: "Jupiter is the biggest planet, but the other two are not that small, Saturn is the second largest followed directly by Uranus", answeredWrongText: "", color: .purple),
        
        Question("Judy, do you remember which is the coldest place in the universe?", alt_one: "The boomerang nebula", alt_two: "The moon", alt_three: "Virgo", correct: .alternative_one, answeredRightText: "That's right, the Boomerang Nebula is a protoplanetary nebula that has temperatures that reaches −272.15 ° C", answeredWrongText: "", color: .purple),
        
        Question("You know that the earth is very far from the sun, otherwise it would be very hot there, but do you know which planet is closest to the sun?", alt_one: "Venus", alt_two: "Mars", alt_three: "Mercury", correct: .alternative_three, answeredRightText: "Even though Mercury is the closest planet, it is not the hottest, because of its atmosphere Venus is even hotter", answeredWrongText: "", color: .purple),
        
        Question("Do you remember those beautiful rings around Saturn? They are awesome, amazing thing to see, do you know what they are made of?", alt_one: "Gases and rocks", alt_two: "Ice and rocks", alt_three: "Little moons", correct: .alternative_two, answeredRightText: "The seven rings are really made, mostly, of ice and rocks and they are named by letters of the alphabet", answeredWrongText: "", color: .purple),
        
        Question("Judy do you know, which of these planets in the solar system can have diamond showers? Imagine seeing it up close", alt_one: "Venus, Mars, Saturn", alt_two: "Jupiter, Saturn, Uranus", alt_three: "Mars, Uranus and Neptune.", correct: .alternative_two, answeredRightText: "These rains are due to the pressure exerted on the carbon atoms on the planets, which turn into clouds and rains of diamonds.", answeredWrongText: "", color: .purple),

        Question("Judy, do you remember what was the first living thing to orbit the earth? I remember it like it was today", alt_one: "Laika", alt_two: "Iuri Gagarin", alt_three: "Virgil Grissom", correct: .alternative_one, answeredRightText: "You got it right Judy, really Laika was the first living being, Iuri Gagarin was the first human being and right after that we had Virgil Grissom", answeredWrongText: "", color: .green),
                
        Question("When people think of astronauts, they usually remember men, but there are great woman astronauts. Do you know who was the first woman to go to the space?", alt_one: "Sally Ride", alt_two: "Judith Resnik", alt_three: "Valentina Tereshkova", correct: .alternative_three, answeredRightText: "Valentina was the first woman to go into space and the only one to fly alone and Sally was the first American to go", answeredWrongText: "", color: .green),
        
        Question("Judy, you have already visited the international space station, but do you know which of these countries are involved in its construction?", alt_one: "US, CA, RU", alt_two: "BR, DE, FR", alt_three: "CN, GT, CA", correct: .alternative_one, answeredRightText: "The ISS was intended to be a laboratory, observatory and factory while providing transportation for future missions to space", answeredWrongText: "", color: .green),
        
        Question("Speaking of space missions, do you know what was the mission that first took a man to the moon?", alt_one: "Apollo 11", alt_two: "Vostok 1", alt_three: "Voyager 1", correct: .alternative_one, answeredRightText: "\"A small step for man, a giant leap for humanity \" On July 20, 1969, Apollo 11 landed and Neil Armstrong was the first man to step on the Moon.", answeredWrongText: "", color: .green),
        
        Question("Judy, we know that human beings loves to explore space, but it ends up generating a lot of trash, do you know what is Space debris?", alt_one: "All the above", alt_two: "Mission-related debris", alt_three: "Derelict spacecrafts", correct: .alternative_one, answeredRightText: "Space debris is any piece of machinery left by humans in the space. It can refer to big objects such as dead satellites that had failed", answeredWrongText: "", color: .yellow),
        
        Question("Judy, do you know what is the damage that space debris could cause to satellites?", alt_one: "None, all debris fall on earth", alt_two: "Operating interference", alt_three: "Collision with the debris", correct: .alternative_three, answeredRightText: "Space debris can actually hit a satellite and because of its speed can cause an explosion", answeredWrongText: "", color: .yellow),
        
        Question("A Solar storm is a disturbance of the Earth's magnetosphere caused by a solar wind shock wave. Do you know the consequences of it to earth?", alt_one: "Short circuits", alt_two: "Fires in forests", alt_three: "Lightning and storms", correct: .alternative_one, answeredRightText: "The intensities of storms, from weak to very strong, can cause electrical damage, especially in high latitudes, where their effects are concentrated.", answeredWrongText: "", color: .yellow),
        
        Question("The Ozone shield is a region of Earth's stratosphere that makes the planet livable for human beings. You know what is it's function? ", alt_one: "Absorb Sun's radiation", alt_two: "Keep the planet warm", alt_three: "Keep Earth's O2 levels high", correct: .alternative_one, answeredRightText: "The Ozone shield really protects the earth of radiation!", answeredWrongText: "", color: .yellow),
    ]
    
    private static var privateShared : Questions?

    class func shared() -> Questions {
        guard let sharedInstance = privateShared else {
            privateShared = Questions()
            return privateShared!
        }
        return sharedInstance
    }

    class func destroy() {
        privateShared = nil
    }
    
    func getRandomQuestion(color: ETColor) -> Question{
        let questionList = list
        var coloredQuestion = questionList.filter { question in
            return question.color == color
        }
        
        let randomIndex = coloredQuestion.indices.randomElement()!
        
        self.list = self.list.filter { question in
            question.questionText != coloredQuestion[randomIndex].questionText
        }
        
        return coloredQuestion.remove(at: randomIndex)
    }
    
    private init() {}
}
