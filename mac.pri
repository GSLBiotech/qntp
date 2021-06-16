# defined in env.cmd
QMAKE_MACOSX_DEPLOYMENT_TARGET = $$(MAC_DEPLOYMENT_TARGET)

CONFIG(release) {
  #Turn off exception handling
  QMAKE_CFLAGS   *= -fno-exceptions
  QMAKE_CXXFLAGS *= -fno-exceptions

  #Try and remove all dead code
  QMAKE_CFLAGS   *= -gfull
  QMAKE_CXXFLAGS *= -gfull
  LIBS           *= -dead_strip
}

#Turn off Address Space Layout Randomization (ASLR) for debug builds.
CONFIG(debug) {
  QMAKE_LFLAGS *= -Wl,-no_pie
}

#Force compiler on Mac to warn if any files end without
#a newline character this always causes a warning on Windows.
QMAKE_CFLAGS   *= -Wnewline-eof
QMAKE_CXXFLAGS *= -Wnewline-eof

#The following flags are useful to quiet a slew of warnings that
#can't easily be resolved at this time (mainly in 3rd party code).

#The Minizip code has code like if((level == 2)) which triggers a warnings
QMAKE_CFLAGS_WARN_ON   *= -Wno-parentheses-equality

#We often set enum values to -1 as an error code. This triggers some warnings
QMAKE_CFLAGS_WARN_ON   *= -Wno-tautological-constant-out-of-range-compare
QMAKE_CXXFLAGS_WARN_ON *= -Wno-tautological-constant-out-of-range-compare

QMAKE_CFLAGS   *= -fvisibility-inlines-hidden
QMAKE_CXXFLAGS *= -fvisibility-inlines-hidden

CONFIG+=sdk_no_version_check

QT += macextras

