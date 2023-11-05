# Block Tool

This is your main tool for creating new blocks.  It also lets you select and move blocks.

* Click and drag in an empty space or an unselected block to draw the base of a new block.  
    * When you release the mouse button, you will switch to dragging out the height of the block.  
    * Release the mouse button a second time to finish drawing the block.
    * Press Escape to cancel drawing the block.  Right clicking will also cancel drawing the block.

![Creating a block on the surface of another block](create_block_on_surface.gif)

* Click on a block to select it.  You can change how the selection works by holding the <kbd>Ctrl</kbd> or <kbd>⌘</kbd> and <kbd>Shift</kbd> keys.
    * None - Replace the current selection
    * <kbd>Shift</kbd> - Toggle the selection.  Unselected things will become selected and visa versa.
    * <kbd>Ctrl</kbd> or <kbd>⌘</kbd> - Add the clicked block to the current selection
    * <kbd>Ctrl</kbd> <kbd>Shift</kbd> or <kbd>⌘</kbd> <kbd>Shift</kbd> - Remove the block from the current selection

* Click and drag on a selected block to move all selected blocks.  The modifier keys will affect how the blocks move.
    * None - Blocks will move in the XZ plane
    * <kbd>Alt</kbd> or <kbd>⌥</kbd> - Blocks will be moved along the Y axis

![Selecting and dragging blocks](select_and_drag_blocks.gif)

* If you hold <kbd>Ctrl</kbd> or <kbd>⌘</kbd> while clicking and dragging on the face of a block, the block will be extruded along that face.

![Hold ctrl and drag to move face along normal](ctrl_drag_face.gif)

## Support

If you found this software useful, please consider buying me a coffee on Kofi.  Every contribution helps me to make more software:

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Y8Y43J6OB)
