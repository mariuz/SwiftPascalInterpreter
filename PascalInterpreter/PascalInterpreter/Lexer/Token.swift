//
//  Token.swift
//  SwiftPascalInterpreter
//
//  Created by Igor Kulman on 06/12/2017.
//  Copyright © 2017 Igor Kulman. All rights reserved.
//

import Foundation

public enum Operation {
    case plus
    case minus
    case mult
    case integerDiv
    case floatDiv
}

public enum Parenthesis {
    case left
    case right
}

public enum Constant {
    case integer(Int)
    case real(Double)
}

public enum Type {
    case integer
    case real
}

public enum Token {
    case operation(Operation)
    case eof
    case parenthesis(Parenthesis)
    case begin
    case end
    case id(String)
    case dot
    case assign
    case semi
    case program
    case varDef
    case colon
    case coma
    case type(Type)
    case constant(Constant)
}