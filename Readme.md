GitBeX: Documentation that works with GitBook and LaTeX
=======================================================

If you write technical documentation (or just plain books), [GitBook](https://gitbook.com) is a powerful tool that can turn a simple set of Markdown files into an indexed and searchable website. What's more, GitBook offers options to automatically export this documentation into various formats, such as PDF or eBook.

However, if you want to turn that same documentation into something that's printable, GitBook it not your friend. The file it generates feels like (and as a matter of fact, actually *is*) a bunch of web pages printed to PDF from a web browser and smacked one after the other. This is acceptable for e-readers or on-screen viewing, but gives a rather sub-standard look for a printed document. Even bare-bones features, such as page numbers and a table of contents, are absent from the generated document. Besides, apart from a few stylesheet tweaks, you have absolutely no control over the appearance of the resulting PDF. Needless to say, this output cannot be used as the basis for a professional-looking printed book.

This repository contains a template project that allows you to write documentation that can both:

1. Be used as the source of a GitBook project (that is, GitBook can point to your repository and process it as usual)
2. Be automatically converted into LaTeX source files in a separate folder; you can compile these files, and have complete control over the LaTeX document class that is being used for the compilation.

Among the nice things that a compilation through LaTeX brings:

- Larger choice of fonts
- Justification, hyphenation, kerning
- Produces a table of contents with actual page numbers (the GitBook PDF has weird section numbers in the TOC)
- Index terms at the end
- All the other goodies LaTeX takes care of (no section title alone at the bottom of a page, etc.)

How it works
------------

First, create a new Git repository by cloning or downloading this project.

Go to GitBook, and click on the "New Book" button. In the available options, select "GitHub".

![GitBook screenshot](gitbook-create-github.png?raw=true)

Complete customization on the book's template can be done by fiddling with the LaTeX class, `gitbook.cls`.

<!-- :wrap=soft:maxLineLen=80: -->