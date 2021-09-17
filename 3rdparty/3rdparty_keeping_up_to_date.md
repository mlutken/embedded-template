Updating git hosted libraries here using git subtrees
=====================================================

If you generally don't need to change your 3rdparty library, then using a git *submodule* 
might be overkill/complicated.

Instead you can use the much simpler git *subtrees*, which simply imports the entire 3rdparty 
library into your main repository. This way the 3rdparty files will allways be present whenever 
you do normal clone/update commands.

*IMPORTANT*: All commands are executed from the PROJECT_REPO_ROOT repo root!
If you need to do a similar import of a new subtree git project simply use 
*add* instead off *pull* for the initial import command. Like for example this:

Example of adding and updating a 3rdparty module (Free RTOS)
------------------------------------------------------------
 - First time add: *PROJECT_REPO_ROOT$* git subtree add --prefix 3rdparty/FreeRTOS-Kernel https://github.com/FreeRTOS/FreeRTOS-Kernel.git --squash
 - Subsequent updates: *PROJECT_REPO_ROOT$* git subtree pull --prefix 3rdparty/FreeRTOS-Kernel https://github.com/FreeRTOS/FreeRTOS-Kernel.git --squash


