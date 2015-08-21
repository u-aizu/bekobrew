CMAKE_MINIMUM_REQUIRED (VERSION 2.8)
PROJECT (bekobrew)
INCLUDE (CheckFunctionExists)
SET (VENDOR ${CMAKE_SOURCE_DIR}/vendor)

# curl
FIND_LIBRARY (CURL_LIBRARY NAMES curl)

# libyaml
ADD_SUBDIRECTORY (${VENDOR}/libyaml)
INCLUDE_DIRECTORIES (${VENDOR}/libyaml/include)

# google test
ADD_SUBDIRECTORY (${VENDOR}/googletest)

# bekobrew
FILE (GLOB BEKOBREW_SOURCES src/*.c src/*/*.c)
INCLUDE_DIRECTORIES (src/)
ADD_EXECUTABLE (bekobrew ${BEKOBREW_SOURCES})
ADD_DEPENDENCIES (bekobrew yaml)
TARGET_LINK_LIBRARIES (bekobrew yaml curl)
INSTALL (TARGETS bekobrew RUNTIME DESTINATION bin/)

# testing
INCLUDE_DIRECTORIES (vendor/googletest/include)

FILE (GLOB TESTING_SOURCES ${BEKOBREW_SOURCES} test/*_test.cpp test/*/*_test.cpp)
LIST (REMOVE_ITEM TESTING_SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/src/main.c")

ADD_EXECUTABLE (run_test ${TESTING_SOURCES})
ADD_DEPENDENCIES (run_test gtest)
TARGET_LINK_LIBRARIES(run_test
  gtest
  gtest_main
  pthread
  yaml
  curl
  )
