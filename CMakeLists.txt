cmake_minimum_required(VERSION 3.4)

find_package(Qt6 REQUIRED COMPONENTS Core Network)
include_directories(${Qt6Network_INCLUDE_DIRS})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

set(QNTP_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/qntp)
include_directories(${QNTP_SOURCE_DIR})

list(APPEND SOURCES
    ${QNTP_SOURCE_DIR}/NtpClient.cpp
    ${QNTP_SOURCE_DIR}/NtpReply.cpp
)

list(APPEND HEADERS 
    ${QNTP_SOURCE_DIR}/NtpClient.h
    ${QNTP_SOURCE_DIR}/config.h
    ${QNTP_SOURCE_DIR}/NtpPacket.h
    ${QNTP_SOURCE_DIR}/QNtp.h
    ${QNTP_SOURCE_DIR}/NtpReply.h
    ${QNTP_SOURCE_DIR}/NtpReply_p.h
    ${QNTP_SOURCE_DIR}/NtpTimestamp.h
)

add_library(qntp ${SOURCES})

set_target_properties(qntp PROPERTIES
    FRAMEWORK TRUE
    FRAMEWORK_VERSION 1
    MACOSX_FRAMEWORK_IDENTIFIER com.dotmatics.qntp
    MACOSX_FRAMEWORK_INFO_PLIST ${CMAKE_CURRENT_SOURCE_DIR}/Info.plist
    SOVERSION 1.0.0
)

set_property(TARGET qntp PROPERTY AUTOMOC ON)

target_link_libraries(qntp PRIVATE
  Qt::Core
  Qt::Network
)