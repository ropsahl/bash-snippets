#!/bin/bash
root=/cygdrive/C/Users/Felles/Pictures/
#/cygdrive/d/bilder

echo Finner alle bilder i katalogen $1
rm _files
find "$1" -type f >_files
echo `cat _files|wc -l` filer funnet

#echo Regner ut checksum
#rm -f _imageFiles
#i=0
#while read f ; do
#   let i=i+1
#   echo -en "\r$i"
#   if [[ "$f" =~ (.*(JPG|jpg|mov|MOV|png|PNG|gif|GIF)$) ]] ; then
#      md5sum "$f" | sed 's# \*/# /#' >> _imageFiles
#   fi
#done < _files
#echo
#echo `cat _imageFiles|wc -l` bilder funnet

#echo Sorterer
#sort _imageFiles > _files.sorted

#echo Sjekker for duplikat
#rm -f _files.nodup
#p=""
#pf=""
#i=0
#while read chk f ; do
#  let i=i+1
#  echo -en "\r$i"
#  if [ "$chk" == "$p" ] ; then
#    echo
#    echo Duplikat:
#    echo $pf
#    echo $f
#  else
#    echo "$f" >> _files.nodup
#  fi
#  p=$chk
#  pf=$f
#done < _files.sorted

mnd=( null jan feb mar apr may jun jul aug sep oct nov des )

while read f ; do
  p=$f
  exif -d -m "$p" > _exif
  if [ $? -eq 0 ] ; then
    d=`grep 'Date and Time' _exif |head -1`
    d=${d:(-20)}
    y=${d:1:4}
    m=${d:6:2}
  else
    d=`stat -c %w  $f `
    y=${d:0:4}
    m=${d:5:2}
  fi
  if [ $m -lt 10 ] ;then
     m=${m:1}
  fi
  f=`basename $f`
echo $m
  mkdir -p $root/$y/${mnd[$m]}
  if [[ "$p" == "$root/$y/${mnd[$m]}/$f" ]] ; then
    echo -n .
  else
    echo
    echo mv $p $root/$y/${mnd[$m]}/$f
    mv "$p" "$root/$y/${mnd[$m]}/$f"
  fi
done < _files
#done < _files.nodup

--
Mvh-Runar