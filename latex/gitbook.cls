%% --------------------------------------------------------------------------
%% Classe essai/mémoire/thèse UQAC
%%
%% uqac-these.cls
%% Copyright 2012 Sylvain Hallé
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%% http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Sylvain Hallé.
%%
%% This work consists of the file mybook.cls.
%% --------------------------------------------------------------------------

%% ------------------------
%% Déclarations
%% ------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lifmanual}[2013/03/20 Thèse UQAC, V1.01 par Sylvain Hallé]

%% ------------------------
%% Passage des autres options �  la classe thesis
%% ------------------------
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{book}%
}
\ProcessOptions

%% ------------------------
%% Classe de base
%% ------------------------
\ifx\pdfoutput\undefined
\LoadClass[11pt,letterpaper,openright,dvips]{book}
\else
\LoadClass[11pt,letterpaper,openright,pdftex]{book}
\fi

%% ------------------------
%% Extensions
%% ------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[paperwidth=18.7cm,paperheight=23.2cm]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\let\footruleskip\undefined\RequirePackage{fancyhdr}
\RequirePackage[explicit]{titlesec}
\RequirePackage{textcase}
\RequirePackage{setspace}
\RequirePackage[titles]{tocloft}
\RequirePackage{emptypage} %% On ne pagine pas pages vides
\RequirePackage{caption} %% Pour définir les légendes des figures
\RequirePackage{xcolor}
\RequirePackage{pdfpages}
\RequirePackage{hyphenat}
\RequirePackage{makeidx}
\RequirePackage{enumitem}
\RequirePackage{multicol}

\definecolor{Highlight}{RGB}{173,73,106}

%% ------------------------
%% Chargement conditionnel de packages selon le document produit
%% ------------------------
\ifx\pdfoutput\undefined
  %\newcommand{\hypersetup}[1]{}
\else
  \RequirePackage[babel]{microtype}
\fi

%% ------------------------
%% Choix de la police de caractère
%% ------------------------
\RequirePackage[adobe-utopia]{mathdesign}
%% Redefine default sans-serif font as Helvetica
\usepackage{PTSans}
%\renewcommand{\sfdefault}{pts}

%% ------------------------
%% En français: les paragraphes n'ont pas d'alinéa et sont séparés
%% par une ligne vide
%% ------------------------
\setlength{\parindent}{0pt}
\setlength{\parskip}{10pt}

%% ------------------------
%% Marges de la page et interligne
%% ------------------------
\geometry{hmargin={5cm,1.5cm},vmargin={1.5cm,2cm}}

%% ------------------------
%% Style de la page
%% ------------------------
\fancyhead[LO,RE]{}
\fancyhead[RO,LE]{}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot{}
\fancyfoot[LE]{\sffamily\bfseries\small \parbox{20pt}{\thepage}\quad|\quad\chaptername{} \thechapter{}: \leftmark}
\fancyfoot[RO]{\sffamily\bfseries\small \rightmark\quad|\quad\parbox{20pt}{\raggedleft\thepage}}
\pagestyle{fancy}
%% On redéfinit le style plain pour ne pas avoir de numéros de page
%% �  la première page des chapitres
\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}

%% ------------------------
%% Style des titres et sous-titres
%% ------------------------
% \titleformat{\chapter}%
% [block]%
% {\centering\sffamily\bfseries\selectfont}%
% {\MakeTextUppercase{Chapitre \thechapter}}% Titre du chapitre
% {0cm}% Séparation d'avec le corps du chapitre
% {\vskip 24pt\MakeTextUppercase{#1}}% Code �  exécuter avant le titre
% {}% Code �  exécuter après le titre
% Taken from http://forum.mathematex.net/latex-f6/modification-du-style-de-chapitre-t7022.html

%% On redéfinit chaptermark pour que \leftmark n'affiche pas "CHAPITRE X"
%% (utilisé dans la définition du pied de page plus loin)
\def\chaptermark#1{\markboth{#1}{}}
\def\sectionmark#1{\markright{#1}}

\makeatletter
\def\thickhrulefill{\leavevmode \leaders \hrule height 1ex \hfill \kern \z@}
\def\@makechapterhead#1{%
  \reset@font
  \parindent \z@
  \vspace*{10\p@}%
  \hbox{%
    \vbox{%
      \hsize=1.5cm%
      \begin{tabular}{c}
        %\scshape \strut \@chapapp{} 
        \\
        \colorbox{Highlight}{\vbox{\hbox{\vbox to 1mm{}}\hbox{\color{white} \LARGE \bfseries \hspace{1mm}\thechapter\hspace{1mm}}\hbox{\vbox to 2cm{}}}}%
      \end{tabular}%
      }%
    \vbox{%
      \advance\hsize by -2cm
      \color{Highlight}\hrule height 0.4pt depth 0pt width \hsize
      \par
      \vskip 6pt%
      \hspace{20pt}%
      \parbox{260pt}{%
      \sffamily \Huge \bfseries \raggedright\nohyphens{#1}}%
      }%
    }%
  \vskip 20\p@
}
\def\@makeschapterhead#1{%
  \reset@font
  \parindent \z@
  \vspace*{10\p@}%
  \hbox{%
    \vbox{%
      \hsize=1.5cm%
      \begin{tabular}{c}
        %\scshape \strut \phantom{\@chapapp{}}
        \\
        \colorbox{Highlight}{\vbox{\hbox{\vbox to 1mm{}}\hbox{\color{white} \LARGE \bfseries \hspace{1mm}\phantom{\thechapter}\hspace{1mm}}\hbox{\vbox to 2cm{}}}}%
      \end{tabular}%
      }%
    \vbox{%
      \advance\hsize by -2cm
      \color{Highlight}\hrule height 0.4pt depth 0pt width \hsize
      \par
      \vskip 6pt%
      \hspace{20pt}%
      \parbox{260pt}{%
      \sffamily \Huge \bfseries \raggedright\nohyphens{#1}}%
      }%
    }%
  \vskip 100\p@
}
\makeatother

\titleformat{\section}%
[hang]%
{\sffamily\bfseries\Large\selectfont}%
{\color{Highlight}\MakeTextUppercase{\thesection}}% Titre du chapitre
{0.5cm}% Séparation d'avec le corps du chapitre
{\color{Highlight}#1}% Code �  exécuter avant le titre
{}% Code �  exécuter après le titre

\titleformat{\subsection}%
[hang]%
{\sffamily\itshape\selectfont}%
{\MakeTextUppercase{\thesubsection}}% Titre du chapitre
{0.5cm}% Séparation d'avec le corps du chapitre
{\MakeTextUppercase{#1}}% Code �  exécuter avant le titre
{}% Code �  exécuter après le titre

% Alter some LaTeX defaults for better treatment of figures:
% See p.105 of "TeX Unbound" for suggested values.
% See pp. 199-200 of Lamport's "LaTeX" book for details.
% General parameters, for ALL pages:
\renewcommand{\topfraction}{0.9}	% max fraction of floats at top
\renewcommand{\bottomfraction}{0.8}	% max fraction of floats at bottom
% Parameters for TEXT pages (not float pages):
\setcounter{topnumber}{2}
\setcounter{bottomnumber}{2}
\setcounter{totalnumber}{4}     % 2 may work better
\setcounter{dbltopnumber}{2}    % for 2-column pages
\renewcommand{\dbltopfraction}{0.9}	% fit big float above 2-col. text
\renewcommand{\textfraction}{0.07}	% allow minimal text w. figs
% Parameters for FLOAT pages (not text pages):
\renewcommand{\floatpagefraction}{0.7}	% require fuller float pages
% N.B.: floatpagefraction MUST be less than topfraction !!
\renewcommand{\dblfloatpagefraction}{0.7}	% require fuller float pages

%% Produce placeholder for figure
\newcommand{\imagevide}{\framebox(200,200){IMAGE}}

%% Depth of toc
\setcounter{tocdepth}{1} %% Chapters and sections

%% Codes pour jEdit
%% :mode=latex:wrap=none:
