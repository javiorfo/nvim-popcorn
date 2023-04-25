# nvim-popcorn
Neovim library for popup utilities written in Lua

## Caveats
- This library has been developed on and for Linux following open source philosophy.

## Installation
`Packer`
```lua
use 'javiorfo/nvim-popcorn'
```
`Lazy`
```lua
{ 'javiorfo/nvim-popcorn' }
```

## Overview
| Feature | nvim-popcorn | NOTE |
| ------- | ------------- | ---- |
| Popup borders | :heavy_check_mark: | Includes 5 different borders (also opened to implementation) |
| Set width and height | :heavy_check_mark: |  |
| Set title | :heavy_check_mark: | Optional. Centered with highlighting options |
| Set footer | :heavy_check_mark: | Optional. Centered with highlighting options |
| Title or footer with right or left align | :x: | |
| Backgroung color | :x: | Same of editor |
| Content in text format | :heavy_check_mark: | By table. With highlighting options |
| Content file | :heavy_check_mark: | By string |
| Content open to implementation | :heavy_check_mark: | By function |
| Callback | :heavy_check_mark: | Optional. By function |
| Close popup | :heavy_check_mark: | Pressing <ESC> or Clicking outside of it |

## Usage
- By default the values by parameters are:
```lua
local popcorn = require'popcorn'
local borders = require'popcorn.borders'

local opts = {
    -- Required
    width = 50,

    -- Required
    height = 8,

    -- Optional. If not set then simple_thick_border will be the default
    border = borders.rounded_corners_border,

    -- Optional. The first table value is the title text, the second one is the group to link
    -- The second value is optional too. In this case I will highlight "Popcorn Title" linking to "Type" group
    title = { "Popcorn Title", "Type" },

    -- Optional. The first table value is the footer text, the second one is the group to link
    -- The second value is optional too. In this case I will highlight "Popcorn Footer" linking to "String" group
    footer = { "Popcorn Footer", "String" },

    -- Optional. This will be the body of the popup 
    -- content is a table
    content = {
        { "Results: ", "Constant" }, -- The second value is the group to link to
        { "     - Some text here" },
        { "     - More text here" }
    },

    -- Optional. A second approach could be to open a file and show the content in the popup body
    -- content is a string
    -- content = "path/to/file/to/show/file.txt"

    -- Optional. A third approach could be to implement some code in a function
    -- content is a function
    -- In this example a terminal is opened in the popup body
    -- content = function() vim.cmd("start | term") end 
    
    -- Optional. If a callback is necessary this is the implementation
    -- Pressing <CR> will execute the callback
    -- In this example It will print the first line of the popup body
    callback = function()
        print("Callback result => " .. vim.fn.getline(1))
    end
}

-- Open popup
popcorn:new(opts):pop()
```

#### BORDERS
- Check the borders available in [this file](https://github.com/javiorfo/nvim-popcorn/blob/master/lua/popcorn/borders.lua)
- You can add your own border if you like. Further information in `:help popcorn`

## Screenshots
#### Examples of the differents popup's included in this library. Run `:luafile %` in [these files](https://github.com/javiorfo/nvim-popcorn/blob/master/tests)

<img src="https://github.com/javiorfo/img/blob/master/nvim-popcorn/popcorn.gif?raw=true" alt="popcorn" style="width:800px;"/>

**NOTE:** The colorscheme **malt** from [nvim-whisky](https://github.com/javiorfo/nvim-whisky) is used in this image.
