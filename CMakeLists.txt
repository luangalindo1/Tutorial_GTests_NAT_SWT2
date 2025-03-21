cmake_minimum_required(VERSION 3.14)

project(MyGoogleTestProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Baixar e incluir o GoogleTest usando FetchContent
include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG release-1.11.0  # Ou qualquer versão estável
)
FetchContent_MakeAvailable(googletest)

# Adicionar o executável de teste
add_executable(MyTest test.cpp)

# Linkar com o GoogleTest
target_link_libraries(MyTest gtest gtest_main)

# Habilitar os testes
enable_testing()

# Descobrir e executar os testes
include(GoogleTest)
gtest_discover_tests(MyTest)
