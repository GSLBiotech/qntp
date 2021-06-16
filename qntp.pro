# debug or release. defined in buildQntp
BUILD_TYPE = $$(GSL_BUILD_TYPE)

TEMPLATE = lib
TARGET   = qntp
QT      -= gui
QT      += network

win32* {
  CONFIG  += dll
}

mac {
  #build a framework, not a dylib
  CONFIG += lib_bundle

  QMAKE_FRAMEWORK_BUNDLE_NAME = qntp
  QMAKE_FRAMEWORK_VERSION     = 1

  #Use install_name_tool so application that links against the framework finds it within the bundle.
  QMAKE_POST_LINK = install_name_tool -id @rpath/qntp.framework/Versions/$${QMAKE_FRAMEWORK_VERSION}/qntp $$BUILD_TYPE/qntp.framework/qntp 
}

CONFIG += $$BUILD_TYPE
mac:include( mac.pri )

include( common.pri )

INCLUDEPATH += \
  include \

CONFIG(debug, debug|release) {
  DESTDIR         = debug
  OBJECTS_DIR     = debug
}

CONFIG(release, debug|release) {
  DESTDIR         = release
  OBJECTS_DIR     = release
}

DEFINES += QNTP_BUILDING

HEADERS += \
  src/qntp/NtpClient.h \
  src/qntp/config.h \
  src/qntp/NtpPacket.h \
  src/qntp/QNtp.h \
  src/qntp/NtpReply.h \
  src/qntp/NtpReply_p.h \
  src/qntp/NtpTimestamp.h \

SOURCES += \
  src/qntp/NtpClient.cpp \
  src/qntp/NtpReply.cpp \
