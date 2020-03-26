# Installation

Diderot specific binaries for MacOS and Linux are located in the bin directory.

## Windows
The necessary tools to build the guide don't exist on Windows, but it can be built by using the Windows Subsysem for Linux (WSL).

- Install WSL as documented in the [Microsoft Guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10). (Choose Ubuntu as the Linux subsystem) 
- A Ubuntu tile will be added to the start menu. 
- Launch the Ubuntu WSL from the start menu.
- The WSL creates a traditional Unix home directory. The original Windows home directory is available at `/mnt/c/Users/USERNAME`
- To continue setting up, follow the Unbuntu steps below.

## Ubuntu
- Install the necessary tools.
```
sudo apt update
sudo apt upgrade
sudo apt install make pandoc
sudo apt install texlive texlive-science texlive-latex-extra
```

- Get and build the guide.
```
git clone https://github.com/diderot-edu/diderot-guide
cd diderot-guide/book
make
```

Note: Ther version of pandoc installed by apt is an older release but works for building the guide. For a
more recent version of pandoc, download from [github](https://github.com/jgm/pandoc/releases/tag/2.7.2)
and install with the command:
```dpkg -i pandoc-2.7.2-1-amd64.deb```

## MacOS
TBD - need instructons on installing the necessary LaTeX components. 
