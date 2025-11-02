//
// Created by noexcept on 2025/11/2.
//
export module math;

export int add(int a, int b) { return a + b; }

export class Calculator {
public:
    int multiply(int a, int b) { return a * b; }
};

export namespace internal {
    int subtract(int a, int b) { return a - b; }
}