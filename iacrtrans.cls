\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{iacrtrans}[2016/04/01 v0.1 IACR Transactions Author Class]

% Options
\newif\if@loadhr
\@loadhrtrue
\DeclareOption{nohyperref}{\@loadhrfalse}
\newif\if@submission
\@submissionfalse
\newif\if@preprint
\@preprintfalse
\DeclareOption{preprint}{\@preprinttrue}
\DeclareOption{submission}{\@submissiontrue}
\DeclareOption{draft}{\@preprinttrue\PassOptionsToClass{\CurrentOption}{article}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% article class with a4paper
%\LoadClass[11pt,oneside]{article}[2007/10/19]
\LoadClass[11pt,twoside]{article}[2007/10/19]
%\LoadClass{amsart}

% Geometry
\RequirePackage[a4paper,scale=0.75,marginratio=1:1]{geometry}

% Title fonts: bf+sf
\RequirePackage{sectsty}
\allsectionsfont{\sffamily\boldmath}
\def\@maketitle{%
  \ifdefined\IACR@last@author%
  \@temptokena=\expandafter{\IACR@runningauthors}%
  \@temptokenb=\expandafter{\IACR@last@author}%
  \xdef\IACR@runningauthors{\the\@temptokena{} and \the\@temptokenb}%
  \fi%
  \newpage
  \null
  \vskip 2em%
  \begin{center}%
  \let \footnote \thanks
    {\LARGE \bfseries\sffamily\boldmath \@title \par}%
    \vskip 1.5em%
    {\large
      \lineskip .5em%
      \begin{tabular}[t]{c}%
        \if@submission
        Anonymous Submission
        \else
        \@author
        \fi
      \end{tabular}\par}%
  \end{center}%
  \par
  \vskip 1.5em}

\def\publname{IACR Transactions on Symmetric Cryptology}

% Author/affiliations
\RequirePackage{authblk}
\setcounter{Maxaffil}{1}
\renewcommand\Affilfont{\small~}

% Head/foot
\RequirePackage{fancyhdr}
\fancypagestyle{title}{%
\fancyhf{} % clear all header and footer fields
\if@submission\else\if@preprint\else
\fancyfoot[L]{\publname\\DOI:xxx}
\fancyfoot[R]{\textcopyright IACR}
\fi\fi
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\fancyhf{} % clear all header and footer fields
\fancyhead[RO,LE]{\thepage}
\fancyhead[RE]{\def\thanks##1{}\def\\{}\IACR@runningtitle}
\if@submission
\fancyhead[LO]{Anonymous Submission to \publname}
\else
\fancyhead[LO]{\def\thanks##1{}\IACR@runningauthors}
\fi
\renewcommand{\markboth}[2]{}

%\def\IACR@runningauthors{}
\let\IACR@saved@author=\author
\def\author{\@ifnextchar[{\IACR@@@author}{\IACR@@author}}
\def\IACR@@@author[#1]#2{\IACR@addauthor{#2}\IACR@saved@author[#1]{#2}}
\def\IACR@@author#1{\IACR@addauthor{#1}\IACR@saved@author{#1}}
\newtoks{\@temptokena}
\newtoks{\@temptokenb}
%\newtoks{\@IACR@last@author}
\def\IACR@addauthor#1{
  \ifdefined\IACR@runningauthors
  \ifdefined\IACR@last@author
  \@temptokena=\expandafter{\IACR@runningauthors}
  \@temptokenb=\expandafter{\IACR@last@author}
  \xdef\IACR@runningauthors{\the\@temptokena, \the\@temptokenb}
  \fi
  \gdef\IACR@last@author{#1}
  \else
  \gdef\IACR@runningauthors{#1}
  \fi}


\def\title{\@ifnextchar[{\IACR@@@title}{\IACR@@title}}
\def\IACR@@@title[#1]#2{\gdef\IACR@runningtitle{#1}\gdef\@title{#2}}
\def\IACR@@title#1{\IACR@@@title[#1]{#1}}
\def\runningtitle#1{\gdef\IACR@runningtitle{#1}}

\let\IACR@maketitle=\maketitle
\def\maketitle{\IACR@maketitle \thispagestyle{title}\pagestyle{fancy}}

% TODO
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
    \def\and{\unskip, }\the\@IACR@keywords
  \endquotation}

% Hyperref
\if@loadhr
  \RequirePackage{etoolbox}
  \AtEndPreamble{\@ifpackageloaded{hyperref}{}{\usepackage{hyperref}}}
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
\newtheorem{claim}{Claim}

\theoremstyle{remark}
\newtheorem{remark}{Remark}
\newtheorem{note}{Note}
\newtheorem{case}{Case}


% Floats and captions
\RequirePackage{float}
\newcommand\fs@iacr{\def\@fs@cfont{\sffamily\bfseries}\let\@fs@capt\floatc@plain
  \def\@fs@pre{}\def\@fs@post{}%
  \def\@fs@mid{\vspace\abovecaptionskip\relax}%
  \let\@fs@iftopcapt\iffalse}
\floatstyle{iacr}
\restylefloat{table}
\restylefloat{figure}

% Extra packages
\RequirePackage{xcolor}
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
