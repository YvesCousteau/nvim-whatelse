# 💭 rewind.nvim

## 🌳 Tree

```
rewind.nvim/
├── lua/
│   └── rewind/
│       ├── init.lua          -- Entry point for the plugin |> deps: [ui, config]
│       ├── config.lua        -- Default configuration and user overrides |> deps: []
│       ├── state.lua         -- State management |> deps: []
│       ├── util.lua          -- Helper functions |> deps: [state]
│       ├── data.lua          -- Data handling |> deps: [config]
│       │
│       ├── ui/
│       │   ├── init.lua      -- Entry Point of UI logic |> deps: [config, keymap, command]
│       │   └── util.lua      -- Help functions |> deps: [util]
│       ├── keymap/
│       │   ├── init.lua      -- Entry Point of keymap |> deps: [util, config]
│       │   ├── boards.lua    -- Keymap for Boards UI |> deps: [util, config]
│       │   └── help.lua      -- Keymap for Help UI |> deps: [util, config]
│       └── command/
│           ├── init.lua      -- Entry Point of keymap |> deps: [util]
│           ├── boards.lua    -- Command to access Boards functions |> deps: [data]
│           ├── lists.lua     -- Command to access Lists functions |> deps: [data]
│           ├── tasks.lua     -- Command to access Tasks functions |> deps: [data]
│           └── help.lua      -- Command to access Help functions |> deps: [config, util]
├── README.md                 -- Documentation
└── LICENSE                   -- License file
```

```
init.lua
├── config.lua
└── ui.lua
    ├── config.lua
    ├── util.lua
    ├── command/init.lua
    │   └── data.lua
    └── keymap/init.lua
        ├── util.lua
        └── config.lua


```

## 📏 Arch

- **Boards**: Top-level containers for projects.
- **Lists**: Columns representing workflow stages.
- **Tasks**: Individual tasks within lists.

## 🌈 Highlights

- Each task is created as **TODO** status.

## 📡 API

- **:Rewind container add "new container"**: Add a container.
- **:Rewind container remove "new container"**: Remove a container.
- **:Rewind container update "new container" list add "new list"**: Add a list for a specific container.
- **:Rewind container update "new container" list remove "new list"**: Remove a list for a specific container.
- **:Rewind container update "new container" list update "new list" task add "new task"**: Add a task for a specific list.
- **:Rewind container update "new container" list update "new list" task remove "new task"**: Remove a task for a specific list.
- **:Rewind container update "new container" list update "new list" task update "new task" DONE/DOING/TODO**: Change task status.

---

## ✨ Features

- 📋 **Note**: take note for a boards and give it a tag(s) (shout out to trello architecture).
- ♻️ **Temporary**: you can keep your notes for your current session and note save them.\
   (delete them when session is quit)
- 💾 **Save**: you can save your note and sync it between your sessions (localy for now).

---

https://github.com/folke/flash.nvim/blob/main/README.md?plain=1

## ✨ Features

- 🔍 **Search Integration**: integrate **flash.nvim** with your regular
  search using `/` or `?`. Labels appear next to the matches,
  allowing you to quickly jump to any location. Labels are
  guaranteed not to exist as a continuation of the search pattern.
- ⌨️ **type as many characters as you want** before using a jump label.
- ⚡ **Enhanced `f`, `t`, `F`, `T` motions**
- 🌳 **Treesitter Integration**: all parents of the Treesitter node
  under your cursor are highlighted with a label for quick selection
  of a specific Treesitter node.
- 🎯 **Jump Mode**: a standalone jumping mode similar to search
- 🔎 **Search Modes**: `exact`, `search` (regex), and `fuzzy` search modes
- 🪟 **Multi Window** jumping
- 🌐 **Remote Actions**: perform motions in remote locations
- ⚫ **dot-repeatable** jumps
- 📡 **highly extensible**: check the [examples](https://github.com/folke/flash.nvim#-examples)

## 📋 Requirements

## 📦 Installation

## ⚙️ Configuration

## 🚀 Usage

## 📡 API

## 💡 Examples

## 🌈 Highlights

## 📦 Alternatives

---

## Features

## Install

### Dependencies

### Setup

### Default configuration

## Usage

### HTTP file syntax

### Keybindings

### Commands

### Lua scripting

## Extensions

### Telescope Extension

#### Mappings

#### Config

### Lualine Component

## Contribute

## Related software

## License
