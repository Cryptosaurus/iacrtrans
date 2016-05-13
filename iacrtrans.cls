% IACR Transactions DOCUMENT CLASS -- version 0.22 (10 May 2016)
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
\ProvidesClass{iacrtrans}[2016/05/10 v0.22 IACR Transactions Author Class]

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
\newcommand{\runningauthor}[1]{\gdef\IACR@runningauthors{#1}}
\newcommand{\runnintitle}[1]{\gdef\IACR@runningtitle{#1}}

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
%  \global\let\@author\@empty
  \global\let\@date\@empty
  \global\let\@title\@empty
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}
\def\@maketitle{%
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
          \ifnum\theIACR@author@cnt=\IACR@author@last and \else \unskip, \fi}
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

\def\IACR@runningauthors{
  \def\thanks##1{}\def\inst##1{}\def\footnote##1{}%
  \setcounter{IACR@author@cnt}{1}%
  \def\and{\stepcounter{IACR@author@cnt}%
    \ifnum\theIACR@author@cnt=\IACR@author@last%
    and
    \else
    \unskip,
    \fi}
  \@author
}

\def\author{\@ifnextchar[{\IACR@@@author}{\IACR@@author}}
\def\IACR@@@author[#1]#2{\gdef\@author{#2}\runningauthor{#1}}
\def\IACR@@author#1{\gdef\@author{#1}}

\def\title{\@ifnextchar[{\IACR@@@title}{\IACR@@title}}
\def\IACR@@@title[#1]#2{\gdef\@title{#2}\runnintitle{#1}}
\def\IACR@@title#1{\IACR@@@title[#1]{#1}}
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
\fancyhead[RE]{\def\thanks##1{}\def\\{}\IACR@runningtitle}
\if@submission
\fancyhead[LO]{Anonymous Submission to \publname}
\else
\fancyhead[LO]{\IACR@runningauthors}
\fi
\renewcommand{\markboth}[2]{}
\pagestyle{fancy}

\def\subtitle#1{\gdef\@subtitle{#1}}

%Abstract style, keywords
\newtoks{\@IACR@keywords}
\@IACR@keywords={No keywords given.}
\newcommand{\keywords}[1]{
  \def\@tmp@keywords{#1}\@IACR@keywords=\expandafter{\@tmp@keywords}}

\renewenvironment{abstract}{%
  \small\quotation\setlength{\parindent}{0pt}\noindent
  \textbf{\textsf{Abstract.}}}
  {\smallskip\par\textbf{\textsf{Keywords:}}
    \def\and{\unskip\ \textperiodcentered\ }\the\@IACR@keywords
  \endquotation}

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
\newcommand\fs@iacr{\def\@fs@cfont{\sffamily\bfseries}\let\@fs@capt\floatc@plain
  \def\@fs@pre{}\def\@fs@post{}%
  \def\@fs@mid{\vspace\abovecaptionskip\relax}%
  \let\@fs@iftopcapt\iffalse}
\floatstyle{iacr}
\restylefloat{table}
\restylefloat{figure}

% Extra commands
\newcommand{\email}[1]{\href{mailto:#1}{\nolinkurl{#1}}}


% Line # for submission
\if@submission
\RequirePackage[mathlines]{lineno}
\linenumbers
\def\linenumberfont{\normalfont\tiny\sffamily\color{gray}}
% Taken from http://phaseportrait.blogspot.fr/2007/08/lineno-and-amsmath-compatibility.html
\newcommand*\patchAmsMathEnvironmentForLineno[1]{%
  \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
  \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
  \renewenvironment{#1}%
     {\linenomath\csname old#1\endcsname}%
     {\csname oldend#1\endcsname\endlinenomath}}% 
\newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
  \patchAmsMathEnvironmentForLineno{#1}%
  \patchAmsMathEnvironmentForLineno{#1*}}%
\AtBeginDocument{%
\patchBothAmsMathEnvironmentsForLineno{equation}%
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
