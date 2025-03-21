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