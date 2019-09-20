#!/usr/bin/env bash

PLANT_JAR=/usr/local/Cellar/plantuml/1.2019.9/libexec/plantuml.jar
WORK_DIR=./

if [[ ! -f "$PLANT_JAR" ]]; then
    curl -o ${PLANT_JAR} https://nchc.dl.sourceforge.net/project/plantuml/plantuml.jar
fi

for file in `find "$WORK_DIR" -name *.png`; do
    fileName=${file##*/}
    filePreName=${fileName%.*}
    echo "@startuml" > ${WORK_DIR}${filePreName}.puml
    echo "!include https://raw.githubusercontent.com/tupadr3/plantuml-icon-font-sprites/v2.1.0/common.puml" >> ${WORK_DIR}${filePreName}.puml
    java -jar /usr/local/Cellar/plantuml/1.2019.9/libexec/plantuml.jar -encodesprite 16 "$WORK_DIR$fileName">>${WORK_DIR}${filePreName}.puml
    echo "!define $filePreName(_alias) ENTITY(rectangle,black,$filePreName,_alias,$filePreName)" >> ${WORK_DIR}${filePreName}.puml
    echo "!define $filePreName(_alias, _label) ENTITY(rectangle,black,$filePreName,_label, _alias, $filePreName)" >> ${WORK_DIR}${filePreName}.puml
    echo "!define $filePreName(_alias, _label, _shape) ENTITY(_shape,black,$filePreName,_label, _alias, $filePreName)" >> ${WORK_DIR}${filePreName}.puml
    echo "!define $filePreName(_alias, _label, _shape, _color) ENTITY(_shape,_color,$filePreName,_label, _alias, $filePreName)" >> ${WORK_DIR}${filePreName}.puml
    echo "skinparam folderBackgroundColor<<$filePreName>> White" >> ${WORK_DIR}${filePreName}.puml
    echo "@enduml">>${WORK_DIR}${filePreName}.puml
done



