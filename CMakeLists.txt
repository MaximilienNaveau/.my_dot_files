# Add custom (non compiling) targets so launch scripts and python files
# show up in QT Creator's project view.
file(GLOB_RECURSE EXTRA_FILES
    *.h *.hh *.hpp *.cf *.yaml *.txt *.xml start CATKIN_IGNORE)
add_custom_target(${PROJECT_NAME}_OTHER_FILES ALL WORKING_DIRECTORY
    ${PROJECT_SOURCE_DIR} SOURCES ${EXTRA_FILES})