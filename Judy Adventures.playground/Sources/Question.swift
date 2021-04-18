import Foundation

public class Question {
    var questionText: String
    var alternative_one: String
    var alternative_two: String
    var alternative_three: String
    var answeredRightText: String
    var answeredWrongText: String
    var color: ETColor
    private var correct_answer: Answer
    
    init(_ question: String, alt_one alternative_one: String, alt_two alternative_two: String, alt_three alternative_three: String, correct: Answer, answeredRightText: String, answeredWrongText: String, color: ETColor) {
        self.questionText = question
        self.alternative_one = alternative_one
        self.alternative_two = alternative_two
        self.alternative_three = alternative_three
        self.correct_answer = correct
        self.answeredWrongText = answeredWrongText
        self.answeredRightText = answeredRightText
        self.color = color
    }
    
    func guess(answer: Answer) -> Bool{
        answer == correct_answer ? true : false
    }
}


enum Answer {
    case alternative_one
    case alternative_two
    case alternative_three
}
