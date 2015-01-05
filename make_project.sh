#!/bin/bash
# USAGE: ./make_project.sh <projectName> <bundle_id>
# Must be run from the directory containing CodeaTemplate
# Needs a lot of work - including Icons, setting bundle id, installing codea project, etc

if [ "x$1" = "x" ] ; then
    echo "usage: make_project <project_name>"
    exit
fi

PROJPATH="$1"
PROJ=`basename "$1"`
PROJ=${PROJ//[[:space:]]/}

if [ "$PROJ" = "CodeaTemplate" ] ; then
    echo "cant make the template from the template"
    exit
fi

if [ -x "$PROJ" ] ; then
    echo "cant overwrite existing project '$PROJPATH'"
    exit
fi

cp -r CodeaTemplate "${PROJPATH}"
sed -i.bak "s/___PROJECTNAME___/${PROJ}/g" "${PROJPATH}/CodeaTemplate.xcodeproj/project.pbxproj"
sed -i.bak "s/CodeaTemplate/${PROJ}/g"     "${PROJPATH}/CodeaTemplate.xcodeproj/project.pbxproj"
rm "${PROJPATH}/CodeaTemplate.xcodeproj/project.pbxproj.bak"

sed -i.bak "s/___PROJECTNAME___/${PROJ}/g" "${PROJPATH}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/CodeaTemplate.xcscheme"
sed -i.bak "s/CodeaTemplate/${PROJ}/g" "${PROJPATH}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/CodeaTemplate.xcscheme"
rm "${PROJPATH}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/CodeaTemplate.xcscheme.bak"

sed -i.bak "s/Project.codea/${PROJ}.codea/g" "${PROJPATH}/CodeaTemplate/CodifyAppDelegate.m"
rm "${PROJPATH}/CodeaTemplate/CodifyAppDelegate.m.bak"

mv "${PROJPATH}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/CodeaTemplate.xcscheme" "${PROJPATH}/CodeaTemplate.xcodeproj/xcshareddata/xcschemes/${PROJ}.xcscheme"
mv "${PROJPATH}/CodeaTemplate.xcodeproj" "${PROJPATH}/${PROJ}.xcodeproj"
mv "${PROJPATH}/CodeaTemplate.codea" "${PROJPATH}/${PROJ}.codea"
mv "${PROJPATH}/CodeaTemplate" "${PROJPATH}/${PROJ}"

#Copy Resources over
#cp $ICON_FILE "${PROJPATH}/Icon.png"

echo "created xcode project in ${PROJPATH}/${PROJ}.xcodeproj"
