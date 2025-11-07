#! /usr/bin/bash

cp /usr/share/mime/packages/freedesktop.org.xml /usr/share/mime/packages/freedesktop.org.xml.bak
sed -i 's/<mime-type type=\"application\/vnd.adobe.flash.movie\">/<mime-type type=\"application\/x-shockwave-flash\">/g' /usr/share/mime/packages/freedesktop.org.xml
cat /usr/share/mime/packages/freedesktop.org.xml | grep "<mime-type type=\"application\/x-shockwave-flash\">"
update-mime-database /usr/share/mime
