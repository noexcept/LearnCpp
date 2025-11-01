# 添加C++特性demo的函数
# 用法: add_cpp_demo(demo_name [SOURCE_FILES])
function(add_cpp_demo DEMO_NAME)
    # 解析参数
    set(options OPTIONAL)
    set(oneValueArgs "")
    set(multiValueArgs SOURCES)
    cmake_parse_arguments(DEMO "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
    
    # 如果没有指定源文件，尝试自动查找
    if(NOT DEMO_SOURCES)
        file(GLOB_RECURSE DEMO_SOURCES 
            "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
            "${CMAKE_CURRENT_SOURCE_DIR}/*.cc"
            "${CMAKE_CURRENT_SOURCE_DIR}/*.cxx"
        )
    endif()
    
    # 如果仍然没有找到源文件，创建一个默认的
    if(NOT DEMO_SOURCES)
        set(DEMO_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/${DEMO_NAME}/main.cpp")
    endif()
    
    # 创建可执行文件
    add_executable(${DEMO_NAME} ${DEMO_SOURCES})
    
    # 设置目标属性
    target_compile_features(${DEMO_NAME} PRIVATE cxx_std_20)
    
    # 添加到测试组（可选）
    if(BUILD_TESTING)
        add_test(NAME ${DEMO_NAME} COMMAND ${DEMO_NAME})
    endif()
    
    # 安装规则（可选）
    install(TARGETS ${DEMO_NAME} DESTINATION bin)
endfunction()

# 批量添加demo目录的函数
# 用法: add_all_demos()
function(add_all_demos)
    file(GLOB SUBDIRS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} "${CMAKE_CURRENT_SOURCE_DIR}/*")
    foreach(DIR ${SUBDIRS})
        if(IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/${DIR}")
            # 排除cmake目录和其他非demo目录
            if(NOT DIR STREQUAL "cmake" AND NOT DIR STREQUAL "build" AND NOT DIR STREQUAL ".git")
                # 检查子目录中是否存在CMakeLists.txt文件
                if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${DIR}/CMakeLists.txt")
                    add_subdirectory(${DIR})
                    message(STATUS "Added demo directory: ${DIR}")
                else()
                    message(STATUS "Skipping directory ${DIR} (no CMakeLists.txt found)")
                endif()
            endif()
        endif()
    endforeach()
endfunction()