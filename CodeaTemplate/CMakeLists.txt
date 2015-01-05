
cmake_minimum_required (VERSION 2.8)
project (codea_project C)

find_package ( Qt5 REQUIRED COMPONENTS Core Widgets Gui )

set (___PROJECTNAME____UIS
  mainwindow.ui
  )

set (___PROJECTNAME____RCS
  ___PROJECTNAME___.qrc
  )

set (___PROJECTNAME____MOC_HDRS
  mainwindow.hpp
  )

set (___PROJECTNAME____SOURCES
  main.cpp 
  mainwindow.cpp 
  )

include_directories ("${PROJECT_SOURCE_DIR}/src/")

include_directories (${Qt5_INCLUDE_DIRS})

# this command will generate rules that will run rcc on all files from SAMPLE_RCS
# in result SAMPLE_RC_SRCS variable will contain paths to files produced by rcc
qt5_add_resources (SAMPLE_RC_SRCS ${___PROJECTNAME_____RCS})

# this will run uic on .ui files:
qt5_wrap_ui (SAMPLE_UI_HDRS ${___PROJECTNAME_____UIS})

# and finally this will run moc:
qt5_wrap_cpp (SAMPLE_MOC_SRCS ${___PROJECTNAME_____MOC_HDRS})

add_executable ( ___PROJECTNAME___ MACOSX_BUNDLE
  ${___PROJECTNAME____SOURCES}
  ${SAMPLE_MOC_SRCS}
  ${SAMPLE_RC_SRCS}
  ${SAMPLE_UI_HDRS} )

# last thing we have to do is to tell CMake what libraries our executable needs,
# luckily FIND_PACKAGE prepared QT_LIBRARIES variable for us:
target_link_libraries (___PROJECTNAME___ ${QT_LIBRARIES} ${QWT_LIBRARIES} )
