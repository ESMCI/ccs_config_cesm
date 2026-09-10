string(APPEND CPPDEFS " -DSYSDARWIN")

# Single point of decision for macOS package manager prefix
if (EXISTS "/opt/homebrew")
  set(MAC_PREFIX "/opt/homebrew")
elseif (EXISTS "/opt/local")
  set(MAC_PREFIX "/opt/local")
else()
  set(MAC_PREFIX "/usr/local")
endif()
set(HOMEBREW_PREFIX "${MAC_PREFIX}")
