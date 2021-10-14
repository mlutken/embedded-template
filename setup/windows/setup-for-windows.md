Setup for Windows
=================

Install Chocolatey
------------------
If you do not have the choco installer already setup for your Windows installation, 
then go to here and follow the instructions.

https://chocolatey.org/install


Install clang and other tools using choco installer
---------------------------------------------------
Open a Windows (cmd.exe) command propmt with Admin rights and run these commands
- choco install -y wget make cmake ninja cloc llvm mingw gcc-arm qtcreator doxygen.install graphviz
- choco install -y meld --version=3.18.3


Add the follwing directories to your PATH environment variable:
 - `C:\Program Files\CMake\bin`
 - `C:\Program Files (x86)\Meld`
 - `C:\Program Files\LLVM\share\clang`



Setup meld as git diff and merge tool
-------------------------------------
NOTE: The Meld 3.20 Windows build uses a new build chain. And we DO get crashes so for now we stick to Meld 3.18.3.
      See more here https://meldmerge.org/

If you have not already installed meld version 3.18.3 then run this from 
Windows (cmd.exe) command propmt with Admin rights: 
> choco install -y meld --version=3.18.3

AND you MUST add the meld directory ("C:\Program Files (x86)\Meld") to your PATH 

THEN  
You need to update your .gitconfig file located here:
C:\Users\YOUR-USER-NAME\.gitconfig

With something along these lines:

    [core]
        editor = nano -w
    [user]
        name = Your Name
        email = your.name@somesite.com
        
    [merge]
        tool = meld

    [mergetool "meld"]
        cmd = meld --auto-merge \"$LOCAL\" \"$BASE\" \"$REMOTE\" --output \"$MERGED\"
        trustExitCode = false

    [mergetool]
        # don't ask if we want to skip merge
        prompt = false

        # don't create backup *.orig files
        keepBackup = false

    # ------------------ D I F F -------------------------
    [diff]
        guitool = meld

    [difftool "meld"]
        # --label \"DIFF (ORIGINAL MY)\"
        cmd = meld \"$LOCAL\" \"$REMOTE\"



Before using commands from git bash you need to start a new Git bash promt as you need to get the PATH environment changes 
to take effect.

Examples
 - Directory diff of local changes: `$ git difftool --dir-diff`
 - Directory diff of latest added changes: `$ git difftool --dir-diff --cached`
 - Directory diff of last commit: `$ git difftool --dir-diff HEAD~1 HEAD`
 - Run git mergetool when an ongoing merge has conflicts: `$ git mergetool` 


QTCreator
---------
Please add this to your PATH: 'C:\tools\qtcreator\bin'




