% IACR Transactions DOCUMENT CLASS -- version 0.23 (15 May 2016)
% Written by Gaetan Leurent gaetan.leurent@inria.fr (2016)
%
% To the extent possible under law, the author(s) have dedicated all
% copyright and related and neighboring rights to this software to the
% public domain worldwide. This software is distributed without any
% warranty.
%
% You should have received a copy of the CC0 Public Domain Dedication
% along with this software. If not, see
% <http://creativecommons.org/publicdomain/zero/1.0/>.
%
%
%%% Class options:
%
% [preprint]   Preprint (no copyright info)
% [submission] Anonymous submission
% [spthm]      Emulate llncs sptheorem and remove automatic \qed in proof
% [nohyperref] Disable automatic loading of hyperref
% [draft]
%
%%% HOWTO use this class
%
%% Title
% \title[short]{Long title}
%
%% Authors/affiliation: 
% \author{Alice \and Bob}
% \institute{ABC\\ \email{alice@abc} \and DEF\\ \email{bob@def}}
%
%% Keywords/abstract:
% \keywords{banana \and apple}
% \begin{abstract}
% Lorem ipsum dolor sit amet...
% \end{abstract}
%
%% Warnings
% - please don't use any \pagestyle of \thispagestyle command
% - if you have proof with explicit \qed inside, you should either
%   remove \qed symbols, replace them by \qedhere, or add option [spthm]

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{iacrtrans}[2016/05/15 v0.23 IACR Transactions Author Class]

% Common definitions
\def\publname{IACR Transactions on Symmetric Cryptology}


% Options
\newif\if@loadhr
\@loadhrtrue
\DeclareOption{nohyperref}{\@loadhrfalse}
\newif\if@submission
\@submissionfalse
\newif\if@preprint
\@preprintfalse
\DeclareOption{final}{\PassOptionsToClass{\CurrentOption}{article}}      % Default
\DeclareOption{preprint}{\@preprinttrue}
\DeclareOption{submission}{\@submissiontrue}
\DeclareOption{draft}{\@preprinttrue\PassOptionsToClass{\CurrentOption}{article}}
\newif\if@spthm
\@spthmfalse
\DeclareOption{spthm}{\@spthmtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% article class with a4paper
\LoadClass[10pt,twoside]{article}[2007/10/19]

% Geometry
\RequirePackage[a4paper,hscale=0.65,vscale=0.75,marginratio=1:1]{geometry}

% Title fonts: bf+sf
\RequirePackage{sectsty}
\allsectionsfont{\sffamily\boldmath}
% Also for descrptions
\renewcommand*\descriptionlabel[1]{\hspace\labelsep
                                   \normalfont\bfseries\sffamily #1}


% Title/Author/affiliations
\def\@institute{No institute given.}
\newcommand{\institute}[1]{\gdef\@institute{#1}}
\newcommand{\authorrunning}[1]{\gdef\IACR@runningauthors{#1}}
\newcommand{\titlerunning}[1]{\gdef\IACR@runningtitle{#1}}

\newcounter{IACR@author@cnt}
\newcounter{IACR@inst@cnt}
\newif\if@IACR@autoinst
\@IACR@autoinsttrue
\def\IACR@author@last{0}

\renewcommand\maketitle{\par
  \begingroup
    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \@maketitle
    \thispagestyle{title}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\@maketitle\relax
  \global\let\@thanks\@empty
  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
  % PDF info
  \if@loadhr%
  \hypersetup{pdfauthor=\IACR@runningauthors}%
  \hypersetup{pdftitle=\IACR@runningtitle}%
  \fi%
  % Count authors and affiliations
  \setcounter{IACR@author@cnt}{1}%
  \setcounter{IACR@inst@cnt}{1}%
  \setbox0\hbox{\def\thanks##1{\global\@IACR@autoinstfalse}\def\inst##1{\global\@IACR@autoinstfalse}\def\and{\stepcounter{IACR@author@cnt}}\@author}%
  \setbox0\hbox{\def\and{\stepcounter{IACR@inst@cnt}}\@institute}%
  \xdef\IACR@author@last{\theIACR@author@cnt}%
  \edef\IACR@inst@last{\theIACR@inst@cnt}%
  \ifnum\IACR@author@last=\IACR@inst@last\else\@IACR@autoinstfalse\fi
  \ifnum\IACR@author@last=1 \@IACR@autoinstfalse\fi
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
      {\LARGE \bfseries\sffamily\boldmath \@title\par}
    \ifdefined\@subtitle\vskip .5em{\large\sffamily\bfseries\@subtitle\par}\fi}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
        \if@submission
        Anonymous Submission
        \else
        \setcounter{IACR@author@cnt}{1}%
        \def\and{\if@IACR@autoinst\inst{\theIACR@author@cnt} \fi
          \stepcounter{IACR@author@cnt}%
          \ifnum\theIACR@author@cnt=\IACR@author@last\unskip\ and \ignorespaces\else\unskip, \fi}
        \@author\if@IACR@autoinst\inst{\theIACR@author@cnt}\fi
        \vskip 1em\par
        \small
        \setcounter{IACR@author@cnt}{1}%
        \def\and{\par\stepcounter{IACR@author@cnt}$^\theIACR@author@cnt$~}
        \ifnum\IACR@inst@last>1 $^1$~\fi
        \@institute
        \fi
      }%
  \end{center}%
  \par
  \vskip 1.5em}

\def\author{\@ifnextchar[{\IACR@@@author}{\IACR@@author}}
\def\IACR@@@author[#1]#2{\authorrunning{#1}\gdef\@author{#2}}
\def\IACR@@author#1{%
  \gdef\@author{#1}%
  \if@submission\gdef\IACR@runningauthors{Anonymous Submission to \publname}%
  \else{%
    \def\thanks##1{}%
    \def\\{}%
    \def\and{, }%
    \def\zap@one,##1{}
    \def\zap@last##1,##2{\ifx##1\@empty\else and ##1\expandafter\zap@one\fi}
    \def\zap@last@comma##1,##2,##3{%
      ##1%
      \ifx##3\@empty%
      \expandafter\zap@last\else
      ,\expandafter\zap@last@comma\fi%
      ##2,##3}
    \edef\IACR@runningauthors{\expandafter\@author}
    \edef\IACR@runningauthors{\expandafter\zap@last@comma\IACR@runningauthors,\@empty,\@empty}
    \def\zap@comma@space##1 ,##2{%
      ##1%
      \ifx##2\@empty\else, \expandafter\zap@comma@space\fi
      ##2}
    \edef\IACR@runningauthors{\expandafter\zap@comma@space\IACR@runningauthors{} ,\@empty}
    \def\zap@dbl@space##1 ##2{%
      ##1 %
      \ifx##2\@empty\else \expandafter\zap@dbl@space\fi
      ##2}
    \xdef\IACR@runningauthors{\expandafter\zap@dbl@space\IACR@runningauthors{} \@empty}}\fi}


\def\title{\@ifnextchar[{\IACR@@@title}{\IACR@@title}}
\def\IACR@@@title[#1]#2{\gdef\@title{#2}\titlerunning{#1}}
\def\IACR@@title#1{\gdef\@title{#1}%
  {\def\thanks##1{}\def\\{}\xdef\IACR@runningtitle{#1}}}

\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}

\newcommand{\inst}[1]{\unskip$^{#1}$}
\def\fnmsep{\unskip$^,$}


% Head/foot
\RequirePackage{fancyhdr}
\fancypagestyle{title}{%
\fancyhf{} % clear all header and footer fields
\if@submission\else\if@preprint\else
\fancyfoot[L]{\small \publname\\DOI:xxx}
\fancyfoot[R]{\small \textcopyright{} IACR}
\fi\fi
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\fancyhf{} % clear all header and footer fields
\fancyhead[RO,LE]{\thepage}
\fancyhead[RE]{\IACR@runningtitle}
\fancyhead[LO]{\IACR@runningauthors}
\renewcommand{\markboth}[2]{}
\pagestyle{fancy}

\def\subtitle#1{\gdef\@subtitle{#1}}

%Abstract style, keywords
\def\@IACR@keywords{No keywords given.}
\def\keywords#1{\gdef\@IACR@keywords{#1}}

\renewenvironment{abstract}{%
  \small\quotation\setlength{\parindent}{0pt}\noindent
  \textbf{\textsf{Abstract.}}}
  {\smallskip\par\textbf{\textsf{Keywords:}}
    \def\and{\unskip\ \textperiodcentered\ \ignorespaces}\@IACR@keywords
  \endquotation%
  \if@loadhr%  PDF keywords
  \def\and{, }%
  \def\zap@comma@space##1 ,##2{%
    ##1%
    \ifx##2\@empty\else, \expandafter\zap@comma@space\fi
    ##2}
  \edef\@tmp{\expandafter\@IACR@keywords}
  \edef\@tmp{\expandafter\zap@comma@space\@tmp{} ,\@empty}
  \hypersetup{pdfkeywords=\@tmp}
  \fi}

% Hyperref
\if@loadhr
  \RequirePackage{xcolor}
  \RequirePackage{etoolbox}
  \AtEndPreamble{
    \@ifpackageloaded{hyperref}{}{\usepackage{hyperref}}
    \hypersetup{colorlinks=true,
      citecolor=black!70!green,
      linkcolor=black!70!red}
  }
  \setcounter{tocdepth}{2}
\fi
% autoref: capitals for Sections, and adding Algorithm
\def\equationautorefname{Equation}%
\def\footnoteautorefname{footnote}%
\def\itemautorefname{item}%
\def\figureautorefname{Figure}%
\def\tableautorefname{Table}%
\def\partautorefname{Part}%
\def\appendixautorefname{Appendix}%
\def\chapterautorefname{Chapter}%
\def\sectionautorefname{Section}%
\def\subsectionautorefname{Subsection}%
\def\subsubsectionautorefname{Subsubsection}%
\def\paragraphautorefname{paragraph}%
\def\subparagraphautorefname{subparagraph}%
\def\FancyVerbLineautorefname{line}%
\def\theoremautorefname{Theorem}%
\def\pageautorefname{page}%
\def\algorithmautorefname{Algorithm}

% AMS math
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}
\theoremstyle{definition}
\newtheorem{definition}{Definition}
\newtheorem{example}{Example}
\newtheorem{exercise}{Exercise}
\newtheorem{property}{Property}
\newtheorem{question}{Question}
\newtheorem{solution}{Solution}

\theoremstyle{plain}
\newtheorem{theorem}{Theorem}
\newtheorem{proposition}{Proposition}
\newtheorem{problem}{Problem}
\newtheorem{lemma}{Lemma}
\newtheorem{conjecture}{Conjecture}
\newtheorem{corollary}{Corollary}
\newtheorem*{claim}{Claim}

\theoremstyle{remark}
\newtheorem{remark}{Remark}
\newtheorem{note}{Note}
\newtheorem{case}{Case}

\theoremstyle{plain}

%Emulate LLNCS spnewtheorem
\if@spthm
\def\spnewtheorem{\@ifstar{\IACR@spstar}{\IACR@sp}}
\def\IACR@spstar#1#2#3#4{\newtheorem*{#1}{#2}}
\def\IACR@sp#1{\@ifnextchar[{\IACR@sp@b{#1}}{\IACR@sp@a{#1}}}
\def\IACR@sp@a#1#2[#3]#4#5{\newtheorem{#1}{#2}[#3]}
\def\IACR@sp@b#1[#2]#3#4#5{\newtheorem{#1}[#2]{#3}}
\renewcommand{\pushQED}[1]{}
\fi

% Floats and captions
\RequirePackage{float}
\newcommand\fs@iacrabove{%
  % Swap \abovecaptionskip and \belowcaptionskip
  \addtolength\abovecaptionskip{-\belowcaptionskip}
  \addtolength\belowcaptionskip{\abovecaptionskip}
  \addtolength\abovecaptionskip{-\belowcaptionskip}
  \setlength\abovecaptionskip{-\abovecaptionskip}
  \fs@plaintop%
  \def\@fs@cfont{\sffamily\bfseries}}
\newcommand\fs@iacrbelow{%
  \fs@plain%
  \def\@fs@cfont{\sffamily\bfseries}}
\floatstyle{iacrabove}
\restylefloat{table}
\floatstyle{iacrbelow}
\restylefloat{figure}

% Extra commands
\def\email{\@ifnextchar[{\IACR@@email}{\IACR@email}}
\def\IACR@@email[#1]#2{\href{mailto:#1}{\nolinkurl{#2}}}
\def\IACR@email#1{\href{mailto:#1}{\nolinkurl{#1}}}


% Line # for submission
\newcommand\linenomathWithnumbersforAMS{%
  \ifLineNumbers 
%%  \ifx\@@par\@@@par\else
    \ifnum\interlinepenalty>-\linenopenaltypar
      \global\holdinginserts\thr@@ 
      \advance\interlinepenalty \linenopenalty
     \ifhmode                                   % v4.3 
      \advance\predisplaypenalty \linenopenalty
     \fi 
%%      \advance\postdisplaypenalty \linenopenalty
      \advance\interdisplaylinepenalty \linenopenalty
    \fi
  \fi
  \ignorespaces
  }

\if@submission
\RequirePackage[mathlines]{lineno}
\linenumbers
\def\linenumberfont{\normalfont\tiny\sffamily\color{gray}}

% Taken from http://phaseportrait.blogspot.fr/2007/08/lineno-and-amsmath-compatibility.html
\newcommand*\patchAmsMathEnvironmentForLineno[1]{%
  \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
  \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
  \renewenvironment{#1}%
     {\linenomathWithnumbersforAMS\csname old#1\endcsname}%
     {\csname oldend#1\endcsname\endlinenomath}}% 
\newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
  \patchAmsMathEnvironmentForLineno{#1}%
  \patchAmsMathEnvironmentForLineno{#1*}}%
\AtBeginDocument{%
%\patchBothAmsMathEnvironmentsForLineno{equation}%
\patchBothAmsMathEnvironmentsForLineno{align}%
\patchBothAmsMathEnvironmentsForLineno{flalign}%
\patchBothAmsMathEnvironmentsForLineno{alignat}%
\patchBothAmsMathEnvironmentsForLineno{gather}%
\patchBothAmsMathEnvironmentsForLineno{multline}%
}
\fi

% Microtype
\RequirePackage{microtype}

% Fonts
\usepackage[T1]{fontenc}
\usepackage{lmodern}
