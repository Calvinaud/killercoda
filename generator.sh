#!/bin/bash
URL="https://raw.githubusercontent.com/kubernetes/website/main/content/en/docs/tasks/configure-pod-container/configure-projected-volume-storage.md"

##TODO add clean note embedded in a line  (or better find to show note)

cleaner(){
    CLEAN=$1

      # Remove tooltip
    if [[ "$CLEAN" == *"glossary_tooltip"* ]]; then
        if  [[ "${CLEAN}" == *"text="* ]]; then
            CLEAN="${CLEAN//{{< glossary_tooltip text=\"}"
            CLEAN="${CLEAN//\" term_id=\"*\" >\}\}}"
        else
            CLEAN="${CLEAN//{{< glossary_tooltip term_id=\"}"
            CLEAN="${CLEAN//\" >\}\}}" 
        fi
    fi

    # Add kubernetes url to path to doc
    if [[ "$CLEAN" == *"](/docs"* ]]; then
        CLEAN="${CLEAN//](\/docs/](https:\/\/kubernetes.io\/docs}"
    fi

    CLEAN=${CLEAN//{{< note >}} }

    echo "$CLEAN"
}

NAME_WITH_EXT=${URL##*/}
NAME=${NAME_WITH_EXT%%.*}
URL_PATH=${URL%/*}

mkdir $NAME
cd $NAME
wget $URL

mapfile -t file_data < "$NAME_WITH_EXT"



# First line always start of the table
cursor=1
DESCRIPTION=""
echo "{" > index.json

#Extract title and description from metadata table
while [[ "${file_data[$cursor]}" != "---" ]]; do

    LINE=${file_data[$cursor]}
    ((cursor++))

    # Extract title
    if [[ "$LINE" == *"title:"* ]]; then
        TITLE=${LINE#title: }
        echo "    \"title\": \"${TITLE}\"," >> index.json
    fi 

    # Extract description
    if [[ "$LINE" == *"description:"* ]]; then
        # The description is not in the same line as "description"        
        while [[ "${file_data[$cursor]}" == "  "* ]]; do
            DESCRIPTION+="${file_data[$cursor]} "
            ((cursor++))
        done
    fi
done

echo "    \"description\": \"${DESCRIPTION}\",
    \"details\": {
      \"intro\": {
        \"text\": \"intro.md\"
      },
      \"steps\": [" >> index.json


# Ignore all until overview
while [[ "${file_data[$cursor]}" != "<!-- overview -->" ]]; do
    ((cursor++))
done

# The intro start 2 line avec overview
((cursor++))
((cursor++))

# Extract intro
while [[ "${file_data[$cursor]}" != "" || "${file_data[(($cursor+1))]}" != "" ]]; do
    cleaner "${file_data[$cursor]}" >> intro.md
    ((cursor++))
done


# Ignore all until steps
while [[ "${file_data[$cursor]}" != "<!-- steps -->" ]]; do
    ((cursor++))
done

STEP_NUMBER=0

# To start the big while loop at the first step
while [[ "${file_data[$cursor]}" != "##"* ]]; do
    ((cursor++))
done

# Extract steps:
while [[ "${file_data[$cursor]}" != '## {{% heading "whatsnext" %}}' ]]; do
 
    case "${file_data[$cursor]}" in
    "## "*)
        ((STEP_NUMBER++))
        # Write in index.json
        if [[ "$STEP_NUMBER" != "1" ]]; then
            echo "," >> index.json
        fi 
        echo -n "        {
          \"title\": \"${file_data[$cursor]#\#\# }\",
          \"text\": \"step${STEP_NUMBER}.md\"
        }"  >> index.json
        
        # Skip the line after the step section
        ((cursor++))
        ;;

    *"\`\`\`"*)
        
        if [[ "${file_data[$cursor]}" == *"shell"* || "${file_data[(($cursor+1))]}" == *"kubectl"*  ]]; then
            echo "\`\`\`" >> "step${STEP_NUMBER}.md"
            ((cursor++))
            while [[ "${file_data[$cursor]}" != *"\`\`\`" ]]; do
                LINE=${file_data[$cursor]}

                if [[ "$LINE" == *"https://k8s.io/examples"* ]]; then
                    TO_DELETE_INT=${LINE#*-f }
                    URL_TO_DELETE=${TO_DELETE_INT%% *}
                    TO_DELETE=${URL_TO_DELETE%/*}
                    LINE=${LINE//$TO_DELETE/.}
                fi

                echo "${LINE}" >> "step${STEP_NUMBER}.md"
                ((cursor++))
            done

            echo "\`\`\`{{exec}}" >> "step${STEP_NUMBER}.md"
        else
            cleaner "${file_data[$cursor]}" >> "step${STEP_NUMBER}.md"
        fi
        ;;

    *"note >}}"*)
        #Delete note since it's not supported
    ;;

    "{{< codenew"*)
        echo "\`\`\`" >> "step${STEP_NUMBER}.md"
        FILE_WITH_EXTRA=${file_data[$cursor]##*file=\"}
        FILE=${FILE_WITH_EXTRA%\"*}
        FILENAME=${FILE##*/}
        (echo -n "echo '" && curl -L https://k8s.io/examples/${FILE}) >> "step${STEP_NUMBER}.md"
        echo "' > ${FILENAME}" >> "step${STEP_NUMBER}.md"
        echo "\`\`\`{{exec}}" >> "step${STEP_NUMBER}.md"
        #  https://k8s.io/examples
        ;;

    *)
        cleaner "${file_data[$cursor]}" >> "step${STEP_NUMBER}.md"
        ;;
    esac  
    ((cursor++))
done

echo "
      ]
    },
    \"backend\": {
      \"imageid\": \"kubernetes-kubeadm-1node\"
    }
  }" >> index.json
