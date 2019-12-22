import os

version     = "1.1.0"
author      = "Luke Parker"
description = "A Nim Wrapper for LMDB."
license     = "MIT"

installFiles = @[
    "mc_lmdb.nim"
]

installDirs = @[
    "mc_lmdb",
    "LMDB"
]

requires "nim >= 0.19.4"

before install:
    let makeExe: string = system.findExe("make")
    if makeExe == "":
        echo "Failed to find execuable `make`."
        quit(1)

    withDir projectDir() / "LMDB":
        exec makeExe