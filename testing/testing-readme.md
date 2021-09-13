
# Updating gtest from github using git subtrees
Git URL: https://github.com/google/googletest.git

### GTest is imported from Github using git subtree
See more here: https://blog.developer.atlassian.com/the-power-of-git-subtree/

These commands were used to import (FROM THE ROOT OF the PROJECT !!!):
- *project-repo-root$* git subtree add --prefix testing/googletest https://github.com/google/googletest.git master --squash 


To keep up to date with upstream changes use (FROM THE ROOT OF the PROJECT !!!):
- *project-repo-root$* git subtree pull --prefix testing/googletest https://github.com/google/googletest.git master --squash 

