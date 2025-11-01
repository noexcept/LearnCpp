cmake_minimum_required(VERSION 3.10)

project(LearnCpp VERSION 1.0.0 LANGUAGES CXX)

# 包含自定义CMake函数
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(AddCppDemo)

# 设置C++标准
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# 设置C标准
set(CMAKE_STANDARD 20)
set(CMAKE_STANDARD_REQUIRED ON)
set(CMAKE_EXTENSIONS OFF)

# 设置编译选项
if(MSVC)
    add_compile_options(/W4 /permissive-)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()

add_all_demos()