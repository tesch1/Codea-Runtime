#!/bin/bash
# USAGE: ./make_project.sh <projectName> <bundle_id>
# Must be run from the directory containing CodeaTemplate
# Needs a lot of work - including Icons, setting bundle id, installing codea project, etc

if [ "x$1" = "x" ] ; then
    echo "usage: make_project <project_name>"
    exit
fi

if [ "$1" = "CodeaTemplate" ] ; then
    echo "cant make the template from the template"
    exit
fi

PROJ="${1//[[:space:]]/}"

cp -r CodeaTemplate "${PROJ}"
sed -i .bak "s/___PROJECTNAME___/${PROJ}/g" "${PROJ}/CodeaTemplate.xcodeproj/project.pbxproj"
sed -i .bak "s/CodeaTemplate/${PROJ}/g" "${PROJ}/CodeaTemplate.xcodeproj/project.pbxproj"
rm "${PROJ}/CodeaTemplate.xcodeproj/project.pbxproj.bak"

sed -i .bak "s/___PROJECTNAME___/${PROJ}/g" "${PROJ}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/CodeaTemplate.xcscheme"
sed -i .bak "s/CodeaTemplate/${PROJ}/g" "${PROJ}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/CodeaTemplate.xcscheme"
rm "${PROJ}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/CodeaTemplate.xcscheme.bak"

sed -i .bak "s/Project.codea/${PROJ}.codea/g" "${PROJ}/CodeaTemplate/CodifyAppDelegate.m"
rm "${PROJ}/CodeaTemplate/CodifyAppDelegate.m.bak"

mv "${PROJ}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/CodeaTemplate.xcscheme" "${PROJ}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/${PROJ}.xcscheme"
mv "${PROJ}/CodeaTemplate.xcodeproj" "${PROJ}/${PROJ}.xcodeproj"
mv "${PROJ}/CodeaTemplate.codea" "${PROJ}/${PROJ}.codea"
mv "${PROJ}/CodeaTemplate" "${PROJ}/${PROJ}"

#Copy Resources over
#cp $ICON_FILE "${PROJ}/Icon.png"

echo "created xcode project in ./${PROJ}/${PROJ}.xcodeproj"
