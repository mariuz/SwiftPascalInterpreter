//
//  AST.swift
//  SwiftPascalInterpreter
//
//  Created by Igor Kulman on 07/12/2017.
//  Copyright © 2017 Igor Kulman. All rights reserved.
//

import Foundation

public enum BinaryOperationType {
    case plus
    case minus
    case mult
    case floatDiv
    case integerDiv
}

public enum UnaryOperationType {
    case plus
    case minus
}

public enum Number: AST {
    case integer(Int)
    case real(Double)
}
/*
public indirect enum AST {
    case number(Number)
    case unaryOperation(operation: UnaryOperation, child: AST)
    case binaryOperation(left: AST, operation: BinaryOperation, right: AST)
    case compound(children: [AST])
    case assignment(left: AST, right: AST)
    case variable(String)
    case noOp
    case block(declarations: [AST], compound: AST)
    case variableDeclaration(name: AST, type: AST)
    case type(Type)
    case program(name: String, block: AST)
    case procedure(name: String, params: [AST], block: AST)
    case param(name: String, type: AST)
    case call(procedureName: String, params: [AST])
}*/

public protocol AST {

}

public protocol Declaration: AST {

}

class UnaryOperation: AST {
    let operation: UnaryOperationType
    let operand: AST

    init(operation: UnaryOperationType, operand: AST) {
        self.operation = operation
        self.operand = operand
    }
}

class BinaryOperation: AST {
    let left: AST
    let operation: BinaryOperationType
    let right: AST

    init(left: AST, operation: BinaryOperationType, right: AST) {
        self.left = left
        self.operation = operation
        self.right = right
    }
}

class Compound: AST {
    let children: [AST]

    init(children: [AST]) {
        self.children = children
    }
}

class Assignment: AST {
    let left: Variable
    let right: AST

    init(left: Variable, right: AST) {
        self.left = left
        self.right = right
    }
}

class Variable: AST {
    let name: String

    init(name: String) {
        self.name = name
    }
}

class NoOp: AST {
}

class Block: AST {
    let declarations: [Declaration]
    let compound: Compound

    init(declarations: [Declaration], compound: Compound) {
        self.declarations = declarations
        self.compound = compound
    }
}

class VariableType: AST {
    let type: Type

    init(type: Type) {
        self.type = type
    }
}

class VariableDeclaration: Declaration {
    let name: String
    let type: VariableType

    init(name: String, type: VariableType) {
        self.name = name
        self.type = type
    }
}

class Program: AST {
    let name: String
    let block: Block

    init(name: String, block: Block) {
        self.name = name
        self.block = block
    }
}

class Procedure: Declaration {
    let name: String
    let params: [Param]
    let block: Block

    init(name: String, params: [Param], block: Block) {
        self.name = name
        self.block = block
        self.params = params
    }
}

class Param: AST {
    let name: String
    let type: VariableType

    init(name: String, type: VariableType) {
        self.name = name
        self.type = type
    }
}

class ProcedureCall: AST {
    let name: String
    let actualParameters: [Number]

    init(name: String, actualParameters: [Number]) {
        self.name = name
        self.actualParameters = actualParameters
    }
}
