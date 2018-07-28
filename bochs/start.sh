#!/bin/bash

BXSHARE=/usr/share/bochs

export BXSHARE

bochs -f bochsrc -q

# BXSHARE=/usr/share/bochs && sudo bochs -f bochsrc -q