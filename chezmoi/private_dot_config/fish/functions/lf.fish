# Prevent nested lf instances, inspiration from https://wiki.archlinux.org/index.php/Ranger#Preventing_nested_ranger_instances
function lf
    if test -z $LF_LEVEL
        /usr/bin/env lf $argv
    else
        exit
    end
end
