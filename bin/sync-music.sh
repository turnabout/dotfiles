#!/usr/bin/env bash
set -e

rsync \
    -avh \
    --progress \
        /home/kevin/Music/navidrome/ \
        kevin@hs:/srv/navidrome/music/

