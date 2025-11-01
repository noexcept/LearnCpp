//
// Created by noexcept on 2025/11/1.
//
#include <variant>
#include <iostream>
#include <format>



int main() {
    std::variant<int32_t, int64_t> v = 42;
    std::cout << std::format("v = {} \n", std::get<int32_t>(v));
    std::cout << std::format("v.index() = {} \n", v.index());

    v = 1LL;
    std::cout << std::format("v.index() = {} \n", v.index());

    // 编译错误：没有 short 类型的 variant 成员，对比union 有类型检查
    // std::cout << std::format("v = {}", std::get<short>(v));

    // 运行时异常: 抛出异常 std::bad_variant_access 当前保存的是int64_t 并不是 int32_t 类型的
    try {
        std::get<int32_t>(v);
    } catch (std::bad_variant_access& e) {
        std::cerr << std::format("catch std::bad_variant_access: {}", e.what());
    }

    return 0;
}