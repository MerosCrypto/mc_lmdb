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
    when defined(WINDOWS):
        var clExe: string = system.findExe("cl")
        if clExe == "":
            echo "Failed to find execuable `cl`."
            quit(1)

        let libExe: string = system.findExe("lib")
        if libExe == "":
            echo "Failed to find execuable `lib`."
            quit(1)

        withDir projectDir() / "LMDB":
            exec clExe & " /c mdb.c"
            exec clExe & " /c midl.c"
            exec libExe & " mdb.obj midl.obj /OUT:lmdb.obj"
    else:
        let makeExe: string = system.findExe("make")
        if makeExe == "":
            echo "Failed to find execuable `make`."
            quit(1)

        withDir projectDir() / "LMDB":
            exec makeExe
