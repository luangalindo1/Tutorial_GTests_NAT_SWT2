# Tutorial de introdução ao Google Tests
Esse é um pequeno projeto de tutorial na ferramenta Google Tests, desenvolvido para a disciplina de Noções em Automação de Testes, da Residência Tecnológica Stellantis 2024.

### Introdução ao GoogleTest

O **GoogleTest** é um framework de testes unitários desenvolvido pelo Google para a linguagem C++. Ele facilita a criação, execução e organização de testes, sendo amplamente utilizado em grandes projetos de software. Baseado no estilo de testes xUnit. O **xUnit** é uma arquitetura de testes baseada em unidades de código, amplamente utilizada para escrever e organizar testes automatizados. 

O nome "xUnit" é genérico e deriva de frameworks de teste como JUnit (para Java) e NUnit (para .NET), sendo uma convenção que descreve uma estrutura comum para a criação de testes em diferentes linguagens de programação. A ideia principal do xUnit é fornecer uma maneira padronizada de estruturar testes, onde os testes são agrupados em classes, cada teste é executado isoladamente e o framework gerencia a execução e os resultados. Ele utiliza métodos de setup e teardown para preparar o ambiente antes de cada teste e limpá-lo depois. A abordagem facilita a manutenção, a escalabilidade e a automação dos testes de software. Com isso, o GoogleTest oferece uma maneira simples e poderosa de verificar o comportamento do seu código, assegurando que ele funcione como esperado.

Testes unitários são fundamentais para garantir a qualidade e a robustez do código, e o GoogleTest proporciona diversas ferramentas para facilitar essa tarefa. Com ele, você pode escrever testes automáticos para cada parte do seu código, ajudando a detectar erros rapidamente durante o desenvolvimento.

### Por que usar o GoogleTest?

- **Facilidade de Uso**: O GoogleTest oferece uma API simples e intuitiva para escrever testes.
- **Compatibilidade Multiplataforma**: Funciona em várias plataformas, como Linux, Windows e macOS.
- **Rápido e Eficiente**: Permite rodar testes de forma rápida e com resultados claros, facilitando a integração contínua.
- **Recursos Avançados**: Oferece suporte para testes parametrizados, mocks (com a integração do GoogleMock), e diversos tipos de asserções.
- **Ampla Adoção**: Usado em grandes projetos como o Chromium, o LLVM, o OpenCV e o Protocol Buffers.

Neste tutorial, vamos abordar o básico do GoogleTest, desde a instalação até a escrita e execução de testes simples. Para quem está começando com testes em C++, o GoogleTest é uma excelente escolha para garantir que o código esteja funcionando corretamente e para evitar regressões à medida que o projeto evolui.

### Instalando o GoogleTest

A instalação do **GoogleTest** pode ser feita de maneira simples, utilizando o **Git** e o **CMake**. Abaixo estão os passos detalhados para instalar o GoogleTest em um ambiente de desenvolvimento. 

#### 1. **Pré-requisitos**

Antes de instalar o GoogleTest, é necessário garantir que algumas ferramentas estejam instaladas em seu sistema:

- **Git**: Para clonar o repositório do GoogleTest.
- **CMake**: Para construir o GoogleTest a partir do código fonte.
- **Compilador C++**: Como o **GCC** ou **Clang**, dependendo do seu sistema operacional.

Você pode verificar se essas ferramentas estão instaladas executando os seguintes comandos no terminal:

```bash
git --version
cmake --version
g++ --version   # ou clang++ --version
```

Se qualquer uma dessas ferramentas não estiver instalada, você pode instalá-las usando os pacotes de sua distribuição (em sistemas Linux) ou os instaladores apropriados (em Windows ou macOS).

#### 2. **Instalação do GoogleTest (Opcional)**

A forma mais comum de instalar o GoogleTest é clonando o repositório oficial e compilando a partir do código-fonte. Nesse tutorial, faremos isso de uma forma automatizada, mas caso deseje, há uma forma manual. Para isso, siga os passos abaixo:

1. **Clone o repositório do GoogleTest:**

   No terminal, execute o comando para clonar o repositório oficial do GoogleTest: (Lembre-se de abrir o terminal na pasta que você deseja manter o Google Test) 

   ```bash
   git clone https://github.com/google/googletest
   ```

2. **Crie uma pasta para a compilação:**

   Para evitar poluir o diretório do código-fonte, crie uma pasta de build, na mesma pasta-pai do googletest:

   ```bash
   mkdir build
   ```

#### 3. **Crie os arquivos necessários**

1. **Crie o um arquivo CMakeLists.txt**

No diretório do projeto onde que se encontra o GoogleTest, crie ou edite o arquivo `CMakeLists.txt` para configurar o projeto com o CMake. Isso é necessário porque neste caso faremos a compilação direto no repositório, não instalando o GTest de forma global no PC.

Aqui está um exemplo simples de um arquivo `CMakeLists.txt` para um projeto que usa o GoogleTest, que foi usado neste tutorial: (O arquivo estará no repositório também)

```cmake
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

```
Esse arquivo automatiza a instalação do GTest no repositório.

2. **Escreva a suíte a ser testada test.cpp**

Agora o GoogleTest está quase configurado e pronto para escrever testes, vamos explorar como fazer isso de maneira eficaz. O GoogleTest oferece uma ampla gama de macros de asserção que facilitam a verificação de resultados e ajudam a estruturar os testes de forma eficiente. 

No GoogleTest, cada teste é uma função que é definida dentro de um grupo de testes. Um grupo de testes é um conjunto de casos de teste relacionados, e a principal estrutura de código é a macro `TEST`. Agora, crie um arquivo C++ de teste, como no exemplo abaixo, e salve-o com o nome `test.cpp`:

```cpp
#include <gtest/gtest.h>

TEST(CalcTest, TestEqual) {
    EXPECT_EQ(1 + 1, 2);  // Teste simples
}

TEST(CalcTest, TestDifferent) {
    EXPECT_NE(1 + 1, 3);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);  // Inicializa o GoogleTest
    return RUN_ALL_TESTS();  // Executa os testes
}
```
Neste exemplo, temos os testes `TestEqual` e `TestDifferent`, que pertencem ao grupo de testes chamado `CalcTest`.

- **`TEST(CalcTest, TestEqual)`**: Define um caso de teste. O primeiro parâmetro (`CalcTest`) é o nome do grupo de testes, e o segundo parâmetro (`TestEqual`) é o nome do teste em si.
- **`EXPECT_EQ(2 + 2, 4)`**: A asserção que verifica se a soma de 2 + 2 é igual a 4. O GoogleTest possui várias macros de asserção que permitem comparar valores e validar diferentes condições, com algumas delas sendo mostradas mais adiante.
- **`TEST(CalcTest, TestDifferent)`**: Define outro caso de teste.
- **`EXPECT_NE(1 + 1, 3)`**: A asserção verifica se 1 + 1 é diferente de 3. Este teste também deve passar, porque a condição é verdadeira.
- A função `main()` inicializa o framework de testes chamando `::testing::InitGoogleTest`. Isso prepara o GoogleTest para rodar os testes definidos.
- A macro `RUN_ALL_TESTS()` roda todos os testes definidos com `TEST`. Ele coleta todos os testes registrados e executa um por um, mostrando os resultados no terminal.

3. **Compile o GoogleTest com o CMake:**

   No diretório onde se encontram as pastas  `googletest` e `build`, execute o CMake para configurar e compilar o GoogleTest:

   ```bash
   cd build
   cmake ..
   cmake --build .
   ```

   O comando `cmake` irá compilar o código e gerar o arquivo binário necessário (`MyTest`) para utilizar o GoogleTest. Uma obervação importante é que o caminho até as pastas do projeto não deve ser longo, dado que há um limite de 250 caracteres que irá causar um erro de compilação.

### 3. **Executando os Testes**

Após compilar o teste, você pode executá-lo diretamente no terminal. Se tudo estiver configurado corretamente, ao executar:

```bash
./build/Mytest
```

Você verá uma saída como esta (indicando que o teste passou):

```
[==========] Running 2 tests from 1 test suite.
[----------] Global test environment set-up.
[----------] 2 tests from CalcTest
[ RUN      ] CalcTest.TestEqual
[       OK ] CalcTest.TestEqual (0 ms)
[ RUN      ] CalcTest.TestDifferent
[       OK ] CalcTest.TestDifferent (0 ms)
[----------] 2 tests from CalcTest (1 ms total)

[----------] Global test environment tear-down
[==========] 2 tests from 1 test suite ran. (4 ms total)
[  PASSED  ] 2 tests.
```

### 4. Uso de Macros

#### 4.1. Macros de Asserção

O GoogleTest fornece uma série de **macros de asserção** que ajudam a verificar se o código está funcionando conforme o esperado. Algumas das macros mais comuns incluem:

- **`EXPECT_EQ(val1, val2)`**: Já apresentada, verifica se `val1` é igual a `val2`. Se a condição falhar, o teste falha, mas o GoogleTest continuará executando outros testes.
  
  ```cpp
  EXPECT_EQ(2 + 2, 4);  // Passa
  EXPECT_EQ(2 + 2, 5);  // Falha
  ```

- **`EXPECT_NE(val1, val2)`**: Conforme já visto, verifica se `val1` é diferente de `val2`.
  
  ```cpp
  EXPECT_NE(2 + 2, 5);  // Passa
  EXPECT_NE(2 + 2, 4);  // Falha
  ```

- **`EXPECT_LT(val1, val2)`**: Verifica se `val1` é menor que `val2`.

  ```cpp
  EXPECT_LT(2, 3);  // Passa
  EXPECT_LT(4, 3);  // Falha
  ```

- **`EXPECT_GT(val1, val2)`**: Verifica se `val1` é maior que `val2`.

  ```cpp
  EXPECT_GT(4, 3);  // Passa
  EXPECT_GT(2, 3);  // Falha
  ```

- **`EXPECT_TRUE(condition)`**: Verifica se a condição é verdadeira.

  ```cpp
  EXPECT_TRUE(2 + 2 == 4);  // Passa
  EXPECT_TRUE(2 + 2 == 5);  // Falha
  ```

- **`EXPECT_FALSE(condition)`**: Verifica se a condição é falsa.

  ```cpp
  EXPECT_FALSE(2 + 2 == 5);  // Passa
  EXPECT_FALSE(2 + 2 == 4);  // Falha
  ```

- **`ASSERT_*` vs `EXPECT_*`**: A principal diferença entre `ASSERT_*` e `EXPECT_*` é que o `ASSERT_*` interrompe o teste imediatamente se a condição falhar, enquanto `EXPECT_*` permite que outros testes no mesmo caso de teste sejam executados, mesmo que a condição falhe. Use `ASSERT_*` quando a falha do teste tornar impossível continuar a execução daquele teste específico.

#### 4.2. Testando Exceções

GoogleTest também permite que você escreva testes para verificar exceções. Para isso, use a macro `EXPECT_THROW`, que verifica se uma exceção específica é lançada.

```cpp
TEST(ExceptionTest, DivideByZero) {
    EXPECT_THROW(divide(1, 0), std::runtime_error);  // Verifica se divide lança exceção para uma função de divisão
}
```

### 5. **Uso de Filtros**

Além disso, o filtro `--gtest_filter=NomeDoTeste` é uma maneira de **selecionar quais testes** você deseja executar quando estiver usando o GoogleTest. Ele permite que você execute apenas um subconjunto específico de testes dentro de um conjunto maior de testes, sem precisar executar todos eles. Essa funcionalidade é útil quando você tem um grande número de testes e quer rodar apenas um conjunto ou um teste específico para depuração ou validação.

-  Comando para rodar testes específicos:
       ```bash
       ./seu_teste --gtest_filter=NomeDoGrupo.NomeDoTeste
       ```
   Onde:
   - **`NomeDoGrupo`**: É o nome do grupo de testes que você definiu com a macro `TEST()`. Um grupo de testes é uma forma de organizar testes relacionados.
   - **`NomeDoTeste`**: É o nome do caso de teste específico dentro do grupo.


   **Executando todos os testes de um grupo específico**:
      - Se você quiser rodar **todos os testes dentro do grupo `CalcTest`**, você pode usar o filtro com o nome do grupo, mas omitindo o nome do teste:

      ```bash
      ./seu_teste --gtest_filter=CalcTest.*
      ```

      - Isso executará **todos os testes no grupo `CalcTest`** (no caso, `TestEqual` e `TestDifferent`).

   **Executando múltiplos testes**:
      Você também pode executar **vários testes específicos** ou **grupos de testes** separando-os com dois pontos (`:`). Por exemplo:

      ```bash
      ./seu_teste --gtest_filter=CalcTest.TestEqual:CalcTest.TestDifferent
      ```

      Isso executará os testes **`CalcTest.TestEqual`** e **`CalcTest.TestDifferent`**.

   **Usando curingas**:
      O filtro também suporta curingas. O caractere `*` pode ser usado para corresponder a qualquer parte do nome. Por exemplo:

      - **Executando todos os testes de todos os grupos que contêm "Calc" no nome do grupo**:
      ```bash
      ./seu_teste --gtest_filter=*Calc*
      ```

      - **Executando todos os testes que **comecem** "Test" em qualquer grupo**:
      ```bash
      ./seu_teste --gtest_filter=Test*
      ```

      - **Executando todos os testes que **termine** com "TestEqual" em qualquer grupo**:
      ```bash
      ./seu_teste --gtest_filter=*TestEqual
      ```

      - **Negando um teste com `-`**:
      Você também pode usar o filtro com o sinal de menos (`-`) para **excluir** testes específicos. Por exemplo:

      ```bash
      ./seu_teste --gtest_filter=-CalcTest.TestDifferent
      ```

      Isso **executará todos os testes**, exceto o `CalcTest.TestDifferent`.

### 6. **Conclusão**

O **GoogleTest** é uma ferramenta poderosa para garantir que o seu código C++ esteja funcionando corretamente por meio de testes automatizados. No tutorial, abordamos a instalação, configuração e escrita dos testes, mas o GoogleTest vai muito além disso, oferecendo muitas outras funcionalidades que podem ser exploradas conforme você avança no uso da ferramenta.

#### 1. **Escrever e Organizar Testes**
   - Criar testes claros e bem organizados é crucial para garantir a manutenção e escalabilidade de um código robusto. O GoogleTest facilita isso com a criação de **grupos de testes**, que ajudam a organizar funções de teste relacionadas.
   - A **estrutura do código** é simples e clara, e ao usar as macros fornecidas (`TEST`, `ASSERT_*`, `EXPECT_*`), o GoogleTest permite que você escreva testes legíveis que ajudam a identificar rapidamente falhas no código.

#### 2. **Macros de Asserção**
   - O GoogleTest oferece um conjunto muito útil de **macros de asserção**, como `EXPECT_EQ`, `EXPECT_TRUE`, `ASSERT_EQ`, `ASSERT_TRUE`, entre outras. Elas ajudam a verificar se os valores estão corretos, se as condições esperadas são atendidas e se exceções são lançadas corretamente.
   - Além disso, entender a diferença entre **`EXPECT_*`** e **`ASSERT_*`** pode ajudar a estruturar os testes de maneira mais eficiente:
     - **`EXPECT_*`** permite que outros testes no mesmo caso de teste continuem sendo executados, mesmo se falharem.
     - **`ASSERT_*`** interrompe imediatamente o teste caso a asserção falhe. Isso é útil quando a falha torna o restante do teste inválido ou desnecessário.

#### 3. **Testes Parametrizados**
   - Esse tutorial não mencionou, mas com **testes parametrizados**, o GoogleTest oferece uma maneira de executar o mesmo teste com vários conjuntos de dados, sem a necessidade de duplicar o código.
   - Isso é extremamente útil para garantir que seu código funcione corretamente com uma variedade de entradas diferentes e para aumentar a cobertura de testes.

#### 4. **Filtragem e Execução de Testes**
   - O GoogleTest tem uma poderosa funcionalidade de **filtro de execução de testes**, permitindo que você execute apenas um subconjunto de testes, o que é especialmente útil durante a depuração.
   - Usando a opção `--gtest_filter`, você pode rodar apenas o teste ou grupo de testes específicos, o que ajuda a economizar tempo e focar apenas nas partes do código que precisam ser verificadas.

#### 5. **Boas Práticas ao Escrever Testes**
   - **Clareza**: Certifique-se de que o nome dos testes seja claro e descreva o que está sendo verificado. Evite nomes genéricos como `Test1` ou `Test2`.
   - **Organização**: Organize seus testes em grupos lógicos. Isso facilita a manutenção e compreensão do seu código de testes.
   - **Simulação e Mocking**: Se necessário, use **mocks** (com o **GoogleMock**) para simular dependências externas ou comportamentos complexos em seus testes. O GoogleTest é totalmente compatível com o GoogleMock, que oferece ferramentas poderosas para criar objetos simulados e controlar o comportamento de componentes durante o teste.

#### 6. **Integração Contínua**
   - O GoogleTest pode ser facilmente integrado a sistemas de **Integração Contínua (CI)**, como Jenkins, GitHub Actions ou GitLab CI. A execução automatizada dos testes a cada alteração no código ajuda a identificar problemas rapidamente, garantindo que a base de código permaneça saudável e sem erros.
   - Você pode configurar o seu sistema CI para executar o GoogleTest automaticamente e gerar relatórios com os resultados dos testes, facilitando o acompanhamento da qualidade do código.

#### 7. **Avançando com o GoogleTest**
   - À medida que seu projeto cresce, você pode explorar mais funcionalidades avançadas do GoogleTest, como **testes de exceções** com a macro `EXPECT_THROW`, ou **testes com falhas esperadas** usando a macro `ASSERT_FATAL_FAILURE`.
   - Além disso, é possível personalizar o comportamento do GoogleTest através de **eventos de configuração** e manipulação dos **resultados dos testes**.
   - O GoogleTest é altamente configurável e oferece suporte para integração com **frameworks de perfil e cobertura de código**, o que é essencial para garantir que você está cobrindo todas as partes do seu código com testes.
   - **Explore mais recursos** da biblioteca para escrever testes mais avançados e eficazes. Consulte a [documentação oficial do GoogleTest](https://google.github.io/googletest/) para aprender mais sobre as funcionalidades avançadas e técnicas de teste.

### Em Resumo:

O GoogleTest é uma excelente ferramenta para testar seu código C++ de maneira robusta e eficiente. Ele permite que você escreva testes simples e poderosos, organizando-os de forma clara e permitindo que você execute apenas os testes que deseja. Ao usar as funcionalidades avançadas, como testes parametrizados, mocks, e o filtro de execução de testes, você pode adaptar o GoogleTest para atender às necessidades do seu projeto à medida que ele cresce. A automação e a integração contínua também são um grande benefício para manter a qualidade do código a longo prazo.