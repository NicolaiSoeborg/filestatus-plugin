# Filestatus Plugin for Micro

A simple plugin to see the filestatus of a buffer in [Micro](https://github.com/zyedidia/micro).

The plugin will check if the buffer has been modified on save.

When running the `save` command (`ctrl + s`) the plugin will detect and change `isModified`, if needed.

You can also manually run `filestatus` (`ctrl + e`) and the plugin will show the current buffer CRC32 checksum.


## TODO:

 * Detect filesize and set quotas to not check large files

 * Better handeling of large files?
