#include <stdio.h>
#include <version/git_info.h>
#include <version/version_info.h>

int main()
{
    printf("*** version playground ***\n");
    printf("project version  : '%s'\n", version_string());
    printf("git refspec      : '%s'\n", git_refspec());
    printf("git sha          : '%s'\n", git_sha1());
    printf("git local changes: '%s'\n", git_local_changes());
    return 0;
}
