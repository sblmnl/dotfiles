#!/bin/sh

apt update && apt install -y extrepo

extrepo enable librewolf

apt update && apt install -y librewolf
