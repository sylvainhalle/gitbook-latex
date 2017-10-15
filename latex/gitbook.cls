%% --------------------------------------------------------------------------
%% A simple but non-trivial book style class
%%
%% gitbook.cls
%% Copyright 2012-2017 Sylvain Hallé
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
\ProvidesClass{gitbook}[2017/10/15 v1.0 Simple GitBook document class]


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
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage[titles]{tocloft}
\RequirePackage{emptypage} %% Don't show numbers on empty pages
\RequirePackage{caption}   %% Change figure captions
\RequirePackage{pdfpages}
\RequirePackage{hyphenat}
\RequirePackage{makeidx}

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
