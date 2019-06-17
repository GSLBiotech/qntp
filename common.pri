#-------------------------------------------
#Always build debug or release build, not both
CONFIG(debug_and_release)        CONFIG -= debug_and_release
CONFIG(debug_and_release_target) CONFIG -= debug_and_release_target

#-------------------------------------------
#Optimize a bit
CONFIG(release) {
  QMAKE_CFLAGS += -O2
  QMAKE_CXXFLAGS += -O2
}

#Use C++ 2010, aka C++ 0x -> wait for Qt4.8 compiled with MSVC2010
#QMAKE_CXXFLAGS += -std=c++0xu

#Add a preprocessor define so we can tell if
#we're compiling an application that should not QtGui
!contains(QT, gui) {
  DEFINES += NO_GUI
}
else {
  QT += widgets
}
#-------------------------------------------
#Quiet compiler warnings a bit
win32-msvc* {
  CONFIG += embed_manifest_exe
  DEFINES += _CRT_SECURE_NO_WARNINGS
  DEFINES += _CRT_SECURE_NO_DEPRECATE
  DEFINES += _CRT_NONSTDC_NO_DEPRECATE
  
  #Stupid MSVC includes min and max macros that royally
  #screw up any code that provides min/max functions
  #this turns this off
  DEFINES += NOMINMAX
}
#-------------------------------------------
#Avoid polluting the source and proejcts directories.
OBJECTS_DIR = tmp/$$BUILD_TYPE/$${TARGET}
MOC_DIR     = tmp/$$BUILD_TYPE/$${TARGET}
RCC_DIR     = tmp/$$BUILD_TYPE/$${TARGET}
UI_DIR      = tmp/$$BUILD_TYPE/$${TARGET}
