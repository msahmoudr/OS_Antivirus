#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 dir malicious_dir"
    exit 1
fi

DIR=$1
MALICIOUS_DIR=$2

while [ 1 ]
do
    count=$(ls -1 $MALICIOUS_DIR | wc -l)
    if [ $count -eq 0 ]; then
        echo "No malicious files to review."
        exit 0
    fi

    echo ""
    echo "Files in $MALICIOUS_DIR:"
    i=1
    for f in $MALICIOUS_DIR/*
    do
        if [ -f $f ]; then
            echo "$i) $f"
            i=$((i+1))
        fi
    done

    echo ""
    echo -n "Pick a file by number (or 0 to quit): "
    read choice

    if [ "$choice" = "0" ]; then
        echo "Bye."
        exit 0
    fi

    i=1
    picked=""
    for f in $MALICIOUS_DIR/*
    do
        if [ -f $f ]; then
            if [ $i -eq $choice ]; then
                picked=$f
            fi
            i=$((i+1))
        fi
    done

    if [ -z "$picked" ]; then
        echo "Invalid choice."
        continue
    fi

    echo ""
    echo "What do you want to do with $picked?"
    echo "1) Restore back to $DIR (false positive)"
    echo "2) Permanently delete (genuinely malicious)"
    echo "3) Leave it and go back"
    echo -n "Enter 1, 2, or 3: "
    read action

    if [ "$action" = "1" ]; then
        mv $picked $DIR/
        echo "Restored $(basename $picked) to $DIR."

    elif [ "$action" = "2" ]; then
        rm $picked
        echo "$(basename $picked) permanently deleted."

    elif [ "$action" = "3" ]; then
        # do nothing, loop continues
        echo "Skipped."

    else
        echo "Invalid action."
    fi
done