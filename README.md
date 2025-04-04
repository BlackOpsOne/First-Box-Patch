# First-Box-Patch
A verifiable and global first box patch.

# [Download](https://github.com/BlackOpsOne/First-Box-Patch/releases/latest/download/common_zombie_patch.ff)

## Features
- Disables on Round 20
- Only gives each weapon once
- On Der Riese, the Ray Gun is given on the first hit of the second box
- On the latest version of Plutonium, the patch will display the GSC checksums for verification
   - These checksums will be different depending on the map as the game loads different files, but are always the same unless a file is modified.

## Installing
1. Go to the `Call of Duty Black Ops/zone/Common` folder
1. Rename `common_zombie_patch.ff` to `common_zombie_patch_original.ff`
1. Put the first box `common_zombie_patch.ff` into Common

## Reverting to Vanilla
1. Go to the `Call of Duty Black Ops/zone/Common` folder
1. Rename `common_zombie_patch.ff` to `common_zombie_patch_firstbox.ff`
1. Rename `common_zombie_patch_original.ff` to `common_zombie_patch.ff`

## Verifying the patch
You can compare the checksums shown at the start of the game with [this list](Checksums.md).
