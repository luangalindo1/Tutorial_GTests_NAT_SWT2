if(EXISTS "/home/luanfabiomg/Dropbox/Projetos/Residência Tecnológica/Tutorial_GTests_NAT_SWT2/build/MyTest[1]_tests.cmake")
  include("/home/luanfabiomg/Dropbox/Projetos/Residência Tecnológica/Tutorial_GTests_NAT_SWT2/build/MyTest[1]_tests.cmake")
else()
  add_test(MyTest_NOT_BUILT MyTest_NOT_BUILT)
endif()
