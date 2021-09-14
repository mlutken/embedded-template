
Adding images to your markdown pages
------------------------------------
![The image title](the-image.svg)

For instance, given a markdown page and an image in the following folders:

/some-path/work/my-page.md
/some-path/work/images/some/more/folders/the-image.svg

In order to copy the page while running DOXYGEN in the "work" folder, IMAGE_PATH should be set as one of the following:

    /some-path/work/images/some/more/folders/the-image.svg
    /some-path/work/images/some/more/folders
    images/some/more/folders/the-image.svg
    images/some/more/folders

In all cases, the image can be successfully referenced in the markdown page as either "the-image.svg" or "folders/the-image.svg", "more/folders/the-image.svg" etc. The criteria is the reference matching part of the actual file path and name (while one could expect the image reference to be relative to the markdown file it appears in - this seems wrong).

I say again, these tests were conducted using a markdown file, and it's possible in this case the mechanics be different from the one applicable to images referenced in source files. 

