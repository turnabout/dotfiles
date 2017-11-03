Style guidelines
================
Short document describing my preferred style guidelines across 
all of my dotfiles (mostly just so I don't forget).


1) Header blocks
----------------
All dotfiles contain a comment header block at the top.

They must:

1. Be generated with the `figlet` utility, using the standard default font.
2. Span exactly 6 lines in height, with one empty comment line at the bottom of it.
3. Span no more than 80 columns in width.

Example 1 (vimrc)::
    "        _                    
    " __   _(_)_ __ ___  _ __ ___ 
    " \ \ / / | '_ ` _ \| '__/ __|
    "  \ V /| | | | | | | | | (__ 
    "   \_/ |_|_| |_| |_|_|  \___|
    "                             

Example 2 (bashrc)::
    #   _               _              
    #  | |__   __ _ ___| |__  _ __ ___ 
    #  | '_ \ / _` / __| '_ \| '__/ __|
    #  | |_) | (_| \__ \ | | | | | (__ 
    #  |_.__/ \__,_|___/_| |_|_|  \___|
    #                                 


2) Section blocks
-----------------
Dotfiles that are long enough to warrant it may use comment section blocks.
They are used to delimit important sections of the dotfile.

They must:

1. Span exactly 3 lines in height.
2. Span exactly 80 columns in width.
3. Use the following examples' "boxed-in" style.
4. Have 2 empty lines preceding them.
5. Have no empty line following them, 
   unless the following element must have empty lines preceding it.

Example 1 (vimrc)::


    " +----------------------------------------------------------------------------+
    " | Mappings                                                                   |
    " +----------------------------------------------------------------------------+

Example 2 (bash_functions)::


    # +----------------------------------------------------------------------------+
    # | General helper functions                                                   |
    # +----------------------------------------------------------------------------+

2) Subsection blocks
--------------------
Sections may contain one or more subsections when it's logical.
For example, `.vimrc` mappings are separated in 
multiple subsections; normal, insert, and visual.

They must:

1. Span exactly 3 lines in height.
2. Span exactly 50 lines in width.
3. Use the following examples' "boxed-in" style.
4. Have 1 empty line preceding them.
5. Have no empty line following them, 
   unless the following element must have empty lines preceding it.

Example 1 (vimrc)::

    " +----------------------------------------------+
    " |  Normal                                      |
    " +----------------------------------------------+

3) Bash functions
-----------------
Bash functions must:
1. Use the `function` keyword
2. Have 1 empty lines preceding them.
3. Have no empty line following them, 
4. Include a comment block above them, properly documenting its purpose, 
   usage and globals/arguments/return values (if applies).

   The comment block must follow one of two styles:
   1. **Simple style**, if the function:
      * is simple and needs 1 or 2 lines to be explained
      * uses no globals
      * has no arguments
      * has no return value
   2. **Full style**, if the function:
      * is complicated and needs more than 2 lines to be explained
      * uses globals, OR has arguments, OR has a return value

   The comment block must be "simple styled" if the function is simple
   enough, or "full styled" 

A simple style function comment block must:
1. Be no more than 3 lines in height.
2. Have its first line briefly describe what the function does.
3. Have its second and third lines, if necessary, describe it in more details.
4. Not exceed 80 columns in length.

Example::
    
    # Reload .bashrc
    function reloadb() {
        source ~/.bashrc
    }

    # Brief function description
    # Further describing inner workings and how to use this function
    # and so on, up to three lines and up to 80 columns of width.
    function my_func() {
    }

More complicated functions that either take in arguments or have
more intricate logic must use a more complicated comment block.

This comment block must:

1. Have an empty comment line at the top and the bottom.
2. Declare, in order, Globals, Arguments, and Returns
3. Each of these declarations must have one empty line 
   preceding and following them.
4. Each of these declarations must be indented by two spaces.
5. If one of these declarations is empty, just list "None".

Example::
    
    #
    # Open tmux session or window with 4 panes.
    #
    # Globals:
    #   None
    # 
    # Arguments:
    #   $@ Array containing 4 command strings to execute 
    #      in all 4 panes.
    #      Panes are opened w/ corresponding commands in order:
    #      0 1
    #      2 3
    #
    #      Last index contains the new window name.
    #
    # Returns:
    #   None
    #
    function tsplit() {
    }

