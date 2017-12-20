//
//  AnalyzerTests.swift
//  SwiftPascalInterpreterTests
//
//  Created by Igor Kulman on 06/12/2017.
//  Copyright © 2017 Igor Kulman. All rights reserved.
//

import Foundation
import Foundation
@testable import PascalInterpreter
import XCTest

class InterpreterTests: XCTestCase {
    func testSimpleProgram() {
        let program =
            """
            PROGRAM Part10AST;
            VAR
                a: INTEGER;
            BEGIN
                a := 2
            END.
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(integerState == ["a": 2])
        XCTAssert(realState == [:])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }

    func testMoreComplexProgram() {
        let program =
            """
            PROGRAM Part10AST;
            VAR
                 a, number, b, c, x: INTEGER;
            BEGIN
                BEGIN
                    number := 2;
                    a := number;
                    b := 10 * a + 10 * number DIV 4;
                    c := a - - b
                END;
                x := 11;
            END.
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(integerState == ["b": 25, "number": 2, "a": 2, "x": 11, "c": 27])
        XCTAssert(realState == [:])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }

    func testProgramWithDeclarations() {
        let program =
            """
            PROGRAM Part10AST;
            VAR
                a, b : INTEGER;
                y    : REAL;

            BEGIN {Part10AST}
                a := 2;
                b := 10 * a + 10 * a DIV 4;
                y := 20 / 7 + 3.14;
            END.  {Part10AST}
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(integerState == ["b": 25, "a": 2])
        XCTAssert(realState == ["y": 5.9971428571428573])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }

    func testProgramWithProcedureCallAndNoParameters() {
        let program =
            """
            program Main;
            var x, y: real;

            procedure Alpha();
            var a: integer;
            begin
            a := 2;
            x := y + a;
            end;

            begin { Main }
            y := 5;
            Alpha();
            end.  { Main }
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(integerState == [:])
        XCTAssert(realState == ["x": 7, "y": 5])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }

    func testProgramWithProcedureCallAndParameters() {
        let program =
            """
            program Main;
            var x, y: real;

            procedure Alpha(a: Integer);
            begin
            x := y + a;
            end;

            begin { Main }
            y := 3;
            Alpha(2);
            end.  { Main }
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(integerState == [:])
        XCTAssert(realState == ["x": 5, "y": 3])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }

    func testProgramWithRecursiveFunction() {
        let program =
            """
            program Main;
            var result: integer;

            function Factorial(number: Integer): Integer;
            begin
            if number > 1 then
                Factorial := number * Factorial(number-1)
            else
                Factorial := 1
            end;

            begin { Main }
            result := Factorial(6);
            end.  { Main }
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(realState == [:])
        XCTAssert(integerState == ["result": 720])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }

    func testProgramWithRecursiveAndBuiltInFunctions() {
        let program =
            """
            program Main;
            var result: integer;

            function Factorial(number: Integer): Integer;
            begin
            if number > 1 then
                Factorial := number * Factorial(number-1)
            else
                Factorial := 1
            end;

            begin { Main }
            result := Factorial(6);
            writeln(result);
            end.  { Main }
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(realState == [:])
        XCTAssert(integerState == ["result": 720])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }

    func testProgramWithRecursiveFunctionsAndParameterTheSameName() {
        let program =
            """
            program Main;
            var number, result: integer;

            function Factorial(number: Integer): Integer;
            begin
            if number > 1 then
                Factorial := number * Factorial(number-1)
            else
                Factorial := 1
            end;

            begin { Main }
            number := 6;
            result := Factorial(number);
            end.  { Main }
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(realState == [:])
        XCTAssert(integerState == ["result": 720, "number": 6])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }

    func testProgramWithRepeatUntil() {
        let program =
            """
            program Main;
            var x: integer;

            begin
            x:=0;
            repeat
                x:=x+1;
            until x = 6;
            writeln(x);
            end.  { Main }
            """

        let interpeter = Interpreter(program)
        interpeter.interpret()
        let (integerState, realState, boolState, stringState) = interpeter.getState()
        XCTAssert(realState == [:])
        XCTAssert(integerState == ["x": 6])
        XCTAssert(boolState == [:])
        XCTAssert(stringState == [:])
    }
}
