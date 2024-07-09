# Add custom (non compiling) targets so non cpp files show up in QT_CREATOR IDE.
set(USE_QTCREATOR OFF CACHE BOOL
    "Set to ON if you want QtCreator to display all files in the project tree")
if(USE_QTCREATOR)
    file(GLOB_RECURSE EXTRA_FILES
        *.h *.hh *.hpp *.py
        *.cf  *.yaml *.txt *.xml
        ../start *.launch *.urdf ../CATKIN_IGNORE *.in
    )
    add_custom_target(${PROJECT_NAME}_OTHER_FILES ALL WORKING_DIRECTORY
        ${PROJECT_SOURCE_DIR} SOURCES ${EXTRA_FILES})
endif()
