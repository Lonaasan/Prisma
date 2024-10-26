# General Concept

## What do we want to archieve with Prisma?

- Communication bridge / library between modules (& mods if possible?) using the `string` / `math` table
- Try to save data over warps with the `storage` table
- Save config data over `status.setStatusProperty`, and, if wanted, custom data / config data for mods
- Being able to recover the last state of a mod before uninit for special demands, for example:
    - Having a log of where the player was and being able to go / warp back in history
    - Being able to keep the settings for lua mods and not needing to set them again
- Being able to handle script execution over tables
    - Deactivating / activating lua scripts
    - allowing realtime lua manupilation (Experimental / safescripts off)
- 

## How do we want to structure Prisma?

- Table structure (prisma.core, prisma.debug, prisma.debug.log, etc)

## How do we want to structure Prisma-compatible Mods?

Mods that work with prisma should (right now) write their mods into string.prisma.api.mods like this:

```json
string.prisma.api.mods.name = {
    "author": "examplename",
    "description": "exampletext",
    "version": "1.0.0",
    "requires": {
        "examplerequire": "1.2.3",   // exact version
        "examplerequire1": "*3.0.0", // * Major releases
        "examplerequire2": "^2.1.1", // ^ Minor releases
        "examplerequire3": "~2.4.3", // ~ Patch releases
    },
    "scripts": {
        "examplescript": {
            "scriptpath": "/path/to/your/examplescript.lua",
            "options": {
                "autostart": true
                },
            "tables": {
                "tech":true,
                "localAnimator":true
            }
        }
    }
}
```