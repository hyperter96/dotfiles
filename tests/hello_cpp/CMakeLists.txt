# TODO 1: Set the minimum required version of CMake to be 3.10
cmake_minimum_required(VERSION 3.10)
# TODO 2: Create a project named hello_cpp
project(Tutorial LANGUAGES CXX VERSION 1.0)
# TODO 7: Set the project version number as 1.0 in the above project command

# TODO 6: Set the variable CMAKE_CXX_STANDARD to 11
#         and the variable CMAKE_CXX_STANDARD_REQUIRED to True
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
# TODO 8: Use configure_file to configure and copy TutorialConfig.h.in to
#         TutorialConfig.h
configure_file(circle.h circle.h)
# TODO 3: Add an executable called Tutorial to the project
# Hint: Be sure to specify the source file as tutorial.cxx
add_executable(hello_world ./circle.cpp ./main.cpp)
# TODO 9: Use target_include_directories to include ${PROJECT_BINARY_DIR}

target_include_directories(hello_world PUBLIC
  "${PROJECT_BINARY_DIR}"
)
