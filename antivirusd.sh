!/bin/bash



DIR=$1
MALICIOUS_DIR=$2
INTERVAL=$3

if [ ! -f directory-info.last ]; then
    
    for file in $DIR/*
    do
        if [ -f $file ]; then
            name=$(basename $file)

            
            ext=""
            oldIFS=$IFS
            IFS='.'
            for part in $name
            do
                ext=$part
            done
            IFS=$oldIFS

            bad=0

            
            if [ "$ext" = "exe" ]; then bad=1; fi
            if [ "$ext" = "bat" ]; then bad=1; fi
            if [ "$ext" = "vbs" ]; then bad=1; fi
            if [ "$ext" = "scr" ]; then bad=1; fi
            if [ "$ext" = "ps1" ]; then bad=1; fi

            
            if [ $bad -eq 0 ]; then
                if grep -qi "virus" $file; then bad=1; fi
                if grep -qi "trojan" $file; then bad=1; fi
                if grep -qi "malware" $file; then bad=1; fi
                if grep -qi "worm" $file; then bad=1; fi
                if grep -qi "ransomware" $file; then bad=1; fi
            fi

            
            if [ $bad -eq 1 ]; then
                echo "$file is malicious and it is DELETED"
                cp $file $MALICIOUS_DIR/
                rm $file
            fi
        fi
    done

    ls -l $DIR > directory-info.last
fi

# Main loop
while [ 1 ]
do
    sleep $INTERVAL

    ls -l $DIR > directory-info.new

    same=0
    if cmp -s directory-info.last directory-info.new; then
        same=1
    fi

    if [ $same -eq 0 ]; then
    
        for file in $DIR/*
        do
            if [ -f $file ]; then
                name=$(basename $file)

                ext=""
                oldIFS=$IFS
                IFS='.'
                for part in $name
                do
                    ext=$part
                done
                IFS=$oldIFS

                bad=0

                if [ "$ext" = "exe" ]; then bad=1; fi
                if [ "$ext" = "bat" ]; then bad=1; fi
                if [ "$ext" = "vbs" ]; then bad=1; fi
                if [ "$ext" = "scr" ]; then bad=1; fi
                if [ "$ext" = "ps1" ]; then bad=1; fi

                if [ $bad -eq 0 ]; then
                    if grep -qi "virus" $file; then bad=1; fi
                    if grep -qi "trojan" $file; then bad=1; fi
                    if grep -qi "malware" $file; then bad=1; fi
                    if grep -qi "worm" $file; then bad=1; fi
                    if grep -qi "ransomware" $file; then bad=1; fi
                fi

                if [ $bad -eq 1 ]; then
                    echo "$file is malicious and it is DELETED"
                    cp $file $MALICIOUS_DIR/
                    rm $file
                fi
            fi
        done

        cp directory-info.new directory-info.last
    fi
done