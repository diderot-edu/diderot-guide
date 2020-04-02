# Installation

Diderot specific binaries for MacOS and Linux are located in the bin directory of the guide.
Download the guide here: https://github.com/diderot-edu/diderot-guide


## MacOS
 1) Install pandoc version 2.7.2. Go to the link below and install the right package for your system. https://github.com/jgm/pandoc/releases/tag/2.7.2

2) The binaries that you need for the guide are included here in ./bin.


## Windows
- Install WSL as documented in the [Microsoft Guide](https://docs.microsoft.com/en-us/windows/wsl/install-win10). (Choose Ubuntu as the Linux subsystem) 
- A Ubuntu tile will be added to the start menu. 
- Launch the Ubuntu WSL from the start menu.
- The WSL opens a traditional Unix home directory which is separate from the Windows home directory. The Windows home directory is available at `/mnt/c/Users/USERNAME`
- To continue setting up, follow the Unbuntu steps below.

## Ubuntu
- Install the necessary tools.
```
sudo apt update
sudo apt upgrade
sudo apt install make pandoc
sudo apt install texlive texlive-science texlive-latex-extra
```

- Make sure that  you have the  correct version of pandoc.
Download from [github](https://github.com/jgm/pandoc/releases/tag/2.7.2)
and install with the command:
```dpkg -i pandoc-2.7.2-1-amd64.deb```

- Test
```
$ cd diderot-guide/book
$ make
```

The above command generate `book.pdf`


To generae the xml for a chapter, you can use a command of the form

```
$ make graph-contraction/edge.xml
```




