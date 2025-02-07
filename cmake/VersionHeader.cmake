if (GIT_EXECUTABLE)
   execute_process(
      COMMAND ${GIT_EXECUTABLE} describe --long --tags --dirty --match "v*"
      OUTPUT_VARIABLE GIT_DESCRIBE_OUTPUT
      RESULT_VARIABLE GIT_DESCRIBE_ERROR
      OUTPUT_STRIP_TRAILING_WHITESPACE
      WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
   )
   if (NOT GIT_DESCRIBE_ERROR)
      # Describe output will be in the form v<version>-<commits>-g<hash>[-dirty]
      set(IONC_FULL_VERSION ${GIT_DESCRIBE_OUTPUT})
   endif()
endif()

string(REGEX MATCH "^v([0-9]+)\\.([0-9]+)\\.([0-9]+)-[0-9]+-g([a-zA-Z0-9-]+)$" IONC_FULL_VERSION_MATCH "${IONC_FULL_VERSION}")
set(IONC_VERSION_MAJOR ${CMAKE_MATCH_1})
set(IONC_VERSION_MINOR ${CMAKE_MATCH_2})
set(IONC_VERSION_PATCH ${CMAKE_MATCH_3})
set(IONC_VERSION_HASH ${CMAKE_MATCH_4})
set(IONC_VERSION "v${IONC_VERSION_MAJOR}.${IONC_VERSION_MINOR}.${IONC_VERSION_PATCH}")

configure_file(${SRC} ${DST} @ONLY)
