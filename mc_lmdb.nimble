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
