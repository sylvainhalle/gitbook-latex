GitBook-LaTeX: Documentation that works with GitBook and LaTeX
==============================================================

If you write technical documentation (or just plain books), [GitBook](https://gitbook.com) is a powerful tool that can turn a simple set of Markdown files into an indexed and searchable website. What's more, GitBook offers options to automatically export this documentation into various formats, such as PDF or eBook.

However, if you want to turn that same documentation into something that's printable, GitBook it not your friend. The file it generates feels like (and as a matter of fact, actually *is*) a bunch of web pages printed to PDF from a web browser and smacked one after the other. This is acceptable for e-readers or on-screen viewing, but gives a rather sub-standard look for a printed document. Even bare-bones features, such as page numbers and a table of contents, are absent from the generated document. Besides, apart from a few stylesheet tweaks, you have absolutely no control over the appearance of the resulting PDF. Needless to say, this output cannot be used as the basis for a professional-looking printed book.

This repository contains a template project that allows you to write documentation that can both:

1. Be used as the source of a GitBook project (that is, GitBook can point to your repository and process it as usual)
2. Be automatically converted into LaTeX source files in a separate folder; you can compile these files, and have complete control over the LaTeX document class that is being used for the compilation.

Among the nice things that a compilation through LaTeX brings:

- Larger choice of fonts
- Justification, hyphenation, kerning
- Produces a table of contents with actual page numbers (the GitBook PDF has weird section numbers in the TOC)
- Index terms at the end (with cross-references to the corresponding pages)
- Page breaks for each chapter, but nowhere else. In contrast, GitBook inserts a page break for every *file*, regardless of whether they are chapters or merely sections within a chapter.
- All the other goodies LaTeX takes care of (no section title alone at the bottom of a page, etc.)

Pre-requisites
--------------

- Any LaTeX distribution, such as [MiKTeX](http://miktex.org) or [TeX Live](http://tug.org/texlive/).
- [Pandoc](http://pandoc.org/), to convert Markdown files into LaTeX files. You must be able to run it from the command line by typing `pandoc`.
- [Java](http://java.sun.com) version 6 or later, to run a small program that batch-converts a complete folder structure.

How it works
------------

First, create a new Git repository by cloning or downloading this project.

Then, go to GitBook, and click on the "New Book" button. In the available options, select "GitHub".

![GitBook screenshot](gitbook-create-github.png?raw=true)

### Install GitHub integration

Click on the button  "Install GitHub integration". You will be directed to GitHub to install GitBook. Tick the option "Only select repositories", and then pick the repository you've just created. Then click on "Install".

![GitBook screenshot](github-integration.png?raw=true)

### Link to GitBook

Go back to GitBook, and type in the basic info about your book. Select the GitHub repository you've just linked with GitBook.

![GitBook screenshot](gitbook-create.png?raw=true)

### Write content

The content of your book must be put into the `markdown` folder. You are expected to follow these conventions:

- The file `SUMMARY.md` contains the table of contents. Each top-level list item is a chapter; second-level list items are sections within a chapter.
- Each chapter and its related material (image files, etc.) should be placed in its own folder. The name of that folder does not matter.
- Each subfolder must have a file called `README.md`, which should normally contain the top-level content for that chapter.

### Generate LaTeX sources

The repository comes with a Java program called [gitbook-pandoc](https://github.com/sylvainhalle/gitbook-pandoc) that can be used to create a set of LaTeX source files from the Markdown/GitBook project. From the root folder of you project, you should launch it like this:

```
$ java -jar gitbook-pandoc.jar -s markdown -d latex -p chapters
```

Here, `markdown` is the name of the source folder, `latex` is the name of the destination folder, and `chapters` is the name of the subfolder where each chapter will be put.

From then on, you can go to the `latex` folder and compile the book like any other LaTeX project, by typing:

```
pdflatex book
```

Customization
-------------

The project comes with a rather basic LaTeX document class called `gitbook.cls`. It defines a document style suitable for a US-letter, two-sided printed book with a table of contents and an index. Feel free to modify this class to produce a book style to your liking. LaTeX has lots of packages that allow you to modify just about every element of a document, and produce books that are radically different from (and much nicer than) this basic style.

### Changing the title page

You may want to replace the bland title page by a PDF file you created somewhere else. Simply add this in the preamble:

```
\usepackage{pdfpages}
```

and replace the part in `book.tex` that produces the title page by

```
\includepdf{my-cover-page.pdf}
```

Pandoc include file
-------------------

If you examine the file `book.tex`, which forms the backbone of the whole LaTeX book, you'll see that it loads an auxiliary file called `pandoc.inc.tex`. This is due to the fact that Pandoc, when converting Markdown files, produces LaTeX code that depends on lots of custom-defined functions that it places in the preamble of the generated LaTeX file. Alas, the actual functions that are put there heavily depend on what is in the input document, making it impossible to simply include a boilerplate set of command definitions that would work all the time.

The "trick" used by `gitbook-pandoc.jar` is to merge all Markdown files into a single temporary document, and run Pandoc on it; this produces a file called `all.temp.tex` (this file is not versioned with your project). From this file, it retrieves the whole preamble (everything before `\begin{document}`) and places it in `pandoc.inc.tex`, which is then loaded when you compile `book.tex`.

If you customize the book class (`gitbook.cls`), and in particular if you load new packages or override existing LaTeX commands, the dynamically-generated contents of `pandoc.inc.tex` may clash with your definitions. A possible workaround is to have `book.tex` load a static include file with a different name (say `pandoc.inc.2.tex`), and to hand-pick what commands from the auto-generated `pandoc.inc.tex` you aboslutely need to put inside to make the document compile.

Index terms
-----------

One of the features that is lacking from GitBook, compared to LaTeX, is the possibility to identify terms throughout the text and compile them into an index. This can be done in this project by adding special HTML comments in the Markdown source. These comments are ignored by GitBook, but are understood by `gitbook-pandoc.jar` when it converts the files into LaTeX.

To add an index term, you simply write:

```
Temporibus autem <!--\index{foo} quibusdam-->quibusdam<!--/i--> et aut officiis...
```

Here, the word `quibusdam` is surrounded by two HTML comments. The first starts with `\index`, and corresponds to the command you would normally insert in LaTeX to register the word as an index term. The second contains only the string `/i`, to indicate where the index term ends. GitBook will interpret the text as this:

```
Temporibus autem quibusdam et aut officiis...
```

while the generated LaTeX file will look like this:

```
Temporibus autem \index{foo} quibusdam et aut officiis...
```

This hack has a few caveats:

- Due to a [bug in GitBook](https://github.com/GitbookIO/gitbook/issues/2133), you cannot start a paragraph with an HTML comment. (Look out, this completely breaks the rendering.)
- The opening and closing comments must be on the same line
- No spaces are allowed before `\index` in the first comment
- The second comment must appear as is (i.e. no spaces)
- If a Markdown file contains the literal string `GPGP\index`, it will be converted into an index term (not very likely to happen, though!)

About the author
----------------

This project is developed and maintained by [Sylvain Hallé](http://leduotang.ca/sylvain), Associate Professor at [Université du Québec à Chicoutimi](http://www.uqac.ca), Canada.

<!-- :wrap=soft:maxLineLen=80: -->
