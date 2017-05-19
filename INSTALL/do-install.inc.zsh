
setopt extendedglob 

# go to source directory (if not already there)
cd $(dirname $(dirname "${0:a}"))

echo INSTALLING dotfiles for $INSTALLER_NAME

for myfile in ${(k)FILES}
do
    theirfile=${FILES[$myfile]}
    
    target="$BASE/$theirfile"

    # check that the target file is not already a link to my file.
    if [[ -h "$target" && "${myfile:A}" = "${target:A}" ]]; then
        echo $target was already installed.
    else
        # Create directories as needed
        mkdir -p $(dirname "$target") || (echo failed to install $target && exit 1) || exit 1

        # Backup the target file if it existed before
        if [[ -e "$target" ]]; then
            mv "$target" "$target"~ || (echo failed to install $target && exit 1) || exit 1
            echo created backup "$target"~
        fi

        # Do the deed
        ln -v -s ${myfile:a} $target || (echo failed to install $target && exit 1) || exit 1
    fi
done


