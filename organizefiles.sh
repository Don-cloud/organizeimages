
#read exif information of jpg files in current directory
# and make a folder for date created, move the file into that directory
# helps you organize your image files

    for f in *.JPG ;
    do
        w=`exiv2 $f| grep -i "image timestamp" `
        yy=`echo $w | awk -F':' '{print $2}'`
        mm=`echo $w | awk -F':' '{print $3}'`
        dd=`echo $w | awk -F':' '{print $5}' |awk -F' ' '{print $1}' | awk -F' ' '{print $1}'`

        dir=`echo $yy\_$mm\_$dd`
        #echo $dir
        len=`echo $dir|wc -c`
        if [ $len -eq "11" ]
        then
            if [ -d $dir ]
            then
                echo "directory found $dir"
                mv $f $dir
            else
                echo "creating directory $dir"
               `mkdir $dir`
               mv $f $dir
            fi
        else
           echo "no metadata found for file=$f"
        fi

    done
