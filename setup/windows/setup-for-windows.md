Setup for Windows
=================

Install Chocolatey
------------------
If you do not have the choco installer already setup for your Windows installation, 
then go to here and follow the instructions.

https://chocolatey.org/install


Install clang and other tools using choco installer
---------------------------------------------------
Open a windows command propmt with Admin rights and run these commands
> choco install -y wget make cmake ninja cloc llvm mingw gcc-arm qtcreator doxygen.install
> choco install -y meld --version=3.18.3



Setup meld as git diff and merge tool
-------------------------------------
NOTE: The Meld 3.20 Windows build uses a new build chain. And we DO get crashes so for now we stick to Meld 3.18.3.
      See more here https://meldmerge.org/
> choco install -y meld --version=3.18.3

AND you MUST the meld directory ("C:\Program Files (x86)\Meld\") to your PATH 

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




QTCreator
---------
Please add this to your PATH: 'C:\tools\qtcreator\bin'




