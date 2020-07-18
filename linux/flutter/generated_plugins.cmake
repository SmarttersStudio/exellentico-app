list(APPEND FLUTTER_PLUGIN_LIST
  path_provider_linux
  shared_preferences_linux
  url_launcher_linux
)

foreach(plugin ${FLUTTER_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${plugin}/linux plugins/${plugin})
  target_link_libraries(${BINARY_NAME} PRIVATE ${plugin}_plugin)
endforeach(plugin)
