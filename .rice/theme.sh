location=~/.rice
options=$(ls $location | grep -v .sh)

select theme in $options; do
    for directory in $(ls -a $location/$theme); do
        if [[ $directory == "." || $directory == ".." ]]; then
            continue
        fi

        cp -v -r $location/$theme/$directory ~/
    done
    
    ~/.fehbg &
    i3-msg restart
    
    exit
done
