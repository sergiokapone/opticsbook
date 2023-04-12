%%% --------------------------------------------------------
%%> \section{Declaration}
%%% --------------------------------------------------------


\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{ProblemBook}[2018/01/21]
\LoadClass[onecolumn, twoside, 14pt]{extbook}






%%% --------------------------------------------------------
%%> \section{Class options}
%%% --------------------------------------------------------


\newif\ifelectronic
\newif\ifbiblatex
\newif\ifmarginversioninfo

\DeclareOption{print}{
	\PassOptionsToPackage{colorlinks=false}{hyperref}
	\PassOptionsToPackage{pdfsubject={Version for Printing}}{hyperref}
	\electronicfalse
}

\DeclareOption{electronic}{\def\defcolor{\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}\definecolor{malina}{rgb}{0.6,0.0,0.0}}
	\PassOptionsToPackage{linkcolor=malina}{hyperref}
	\PassOptionsToPackage{colorlinks=true}{hyperref}
	\PassOptionsToPackage{urlcolor=malina}{hyperref}
	\PassOptionsToPackage{citecolor=green!60!black}{hyperref}
	\PassOptionsToPackage{pdfsubject={Electronic Version}}{hyperref}
	\electronictrue
}

\DeclareOption{marginversioninfo}{%
	\marginversioninfotrue
}

\DeclareOption{biblatex}{
	\biblatextrue
}

\ExecuteOptions{electronic}
\ProcessOptions\relax
\defcolor{}





%%% --------------------------------------------------------
%%> \section{Page geometry}
%%% --------------------------------------------------------


\newlength{\topspace}
\setlength{\topspace}{2cm}
\RequirePackage[%
	a4paper,%
	footskip=1cm,%
	headsep=1cm,%
	top=2cm, %поле сверху
	bottom=2cm, %поле снизу
	left=2cm, %поле ліворуч
	right=2cm, %поле праворуч
]{geometry}






%%% --------------------------------------------------------
%%> \section{Compilers}
%%% --------------------------------------------------------



\RequirePackage{fontspec}
\setsansfont{CMU Sans Serif}%{Arial}
\setmainfont{stix}%{CMU Serif}%{Times New Roman}
\setmonofont{CMU Typewriter Text}%{Consolas}
\defaultfontfeatures{Ligatures={TeX}}
\newfontfamily\Annabelle{Annabelle}
\RequirePackage{luacolor}
%\RequirePackage{lua-widow-control}
\RequirePackage[english,russian,ukrainian]{babel}





%%% --------------------------------------------------------
%%> \section{Logic variables}
%%% --------------------------------------------------------


\newif\ifappendix
\newif\ifanswers
\newif\iftoc
\newif\ifbibliography
\newif\ifintro





%%% --------------------------------------------------------
%%> \section{Typography}
%%% --------------------------------------------------------


\RequirePackage{microtype}
%\RequirePackage[nosingleletter, hyphenation, lastparline]{impnattypo}
%\usepackage[defaultlines=4,all]{nowidow}
%\clubpenalty =1000
%\widowpenalty=1000
%\setlength{\parskip}{0.5ex}%
\setlength{\parindent}{2.5em}%
%\renewcommand{\baselinestretch}{1.1}
\def\@textbottom{\vskip \z@ \@plus 1pt}
\let\@texttop\relax
%\setlength{\emergencystretch}{1em}






%%% --------------------------------------------------------
%%> \section{Packages}
%%% --------------------------------------------------------


\RequirePackage[overload]{textcase}
\let\MakeUppercase\MakeTextUppercase
\RequirePackage{indentfirst}





%%% --------------------------------------------------------
%%> \subsection{Floats}
%%% --------------------------------------------------------

\RequirePackage{caption}
\RequirePackage[justification=centering,labelsep=period]{caption}
\RequirePackage{subcaption}
\renewcommand\thesubfigure{\alph{subfigure}}
\RequirePackage{wrapfig}




%%% --------------------------------------------------------
%%> \subsection{Mathematics}
%%% -------------------------------------------------------


\RequirePackage{lualatex-math}
\RequirePackage{amsmath}
\RequirePackage[math-style=TeX,bold-style=TeX]{unicode-math}
\setmathfont[math-style=TeX]{Stix Two Math}
%\numberwithin{equation}{chapter}
\RequirePackage{esint}
\RequirePackage{nicefrac}
\let\nfrac\nicefrac
\allowdisplaybreaks
\newcommand{\vect}[1]{\symbf{#1}}
\AtBeginDocument{%
	\let\pot\phi
	\let\phi\varphi
	\let\epsilon\varepsilon
	\DeclareMathOperator{\const}{const}
	\DeclareMathOperator{\inv}{inv}
	\newcommand{\Laplasian}{\Delta}
}

\RequirePackage{mhchem}
\RequirePackage{icomma}




%%% --------------------------------------------------------
%%> \subsection{Tables}
%%% -------------------------------------------------------


\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}






%%% --------------------------------------------------------
%%> \subsection{Files}
%%% -------------------------------------------------------


\RequirePackage{currfile}




%%% --------------------------------------------------------
%%> \subsection{TikZ and Tolorbox}
%%% -------------------------------------------------------

\RequirePackage[most, many]{tcolorbox}
\RequirePackage[]{OpticsImages}





%%% --------------------------------------------------------
%%> \subsection{Misc}
%%% -------------------------------------------------------


\RequirePackage{epigraph}
\setlength\epigraphwidth{0.7\textwidth}
\setlength\epigraphrule{0pt}
\renewcommand{\textflush}{flushepinormal}
\RequirePackage{lastpage,refcount}
\RequirePackage[disable]{todonotes}
\RequirePackage{pdftexcmds}

\def\emphz#1{{\itshape\color{blue!80!black} #1}}






%%% --------------------------------------------------------
%%> \section{Title page}
%%% --------------------------------------------------------


\newenvironment{alwayssingle}{%
	\thispagestyle{empty}
	\@restonecolfalse
	\if@twocolumn\@restonecoltrue\onecolumn
	\else\if@openright\cleardoublepage\else\clearpage\fi
	\fi}%
{\if@restonecol\twocolumn
	\else\newpage\thispagestyle{empty}\fi
}

\tcbset{%
	titlepagestyle/.style={%
			enhanced,
			colback=themecolordark,
			colframe=themecolorlight,
			arc=0pt,
			outer arc=0pt,
			leftrule=0pt,
			rightrule=0pt,
			enlarge left by=-1in-\hoffset-\oddsidemargin,
			enlarge right by=-\paperwidth+1in+\hoffset+\oddsidemargin+\textwidth,
			width=\paperwidth,
			left=1in+\hoffset+\oddsidemargin,
			right=\paperwidth-1in-\hoffset-\oddsidemargin-\textwidth,
		}%
}%

\ExplSyntaxOn
\RenewDocumentCommand{\title}{m}
{
	\tl_gset:cn { @title } { #1 } % needed by \maketitle
	\tl_gset:Nn { \realtitle } { #1 }
	%  \seq_set_split:Nnn \l_tmpa_seq { \\ } { #1 }
	%  \tl_gset:Nx \inlinetitle { \seq_use:Nn \l_tmpa_seq { ~ } }
}


\NewDocumentCommand \subtitle{  m  }
{
    \tl_set:Nn  \l_subtitle_tl {#1}
}

\NewDocumentCommand \subtitletypeset{}
{
    \tl_use:N  \l_subtitle_tl
}


\NewDocumentCommand \edition{  m  }
{
    \tl_set:Nn  \l_edition_tl {#1}
}

\NewDocumentCommand \editiontypeset{}
{
    \tl_use:N  \l_edition_tl
}


\ExplSyntaxOff





%%% --------------------------------------------------------
%%> \section{Sectioning}
%%% --------------------------------------------------------


\let\cleardoublepage\clearpage

\def\schapter#1{%
	\chapter*{#1}
	\addcontentsline{toc}{chapter}{#1}%
}

%%% --------------------------------------------------------
%%> \subsection{Appedix section}
%%% --------------------------------------------------------


\renewcommand\appendix{\par
	\appendixtrue
   	\setcounter{chapter}{1}%
    \setcounter{section}{0}%
	\gdef\thesection{\@Alph\c@section}
	\@addtoreset{table}{section}
	\renewcommand\thetable%
	{\thesection.\@arabic\c@table}
	\renewcommand{\theequation}{\thesection.\arabic{equation}}
	\clearpage\pagestyle{appendix}
	\def\@sectiontitlemark{\appendixname}
	\if@twocolumn
		\@restonecoltrue\onecolumn
	\else
		\@restonecolfalse
	\fi
	\chapter*{Додатки}%
	\addcontentsline{toc}{chapter}{Додатки}
	\if@restonecol\twocolumn\fi
}


%%% --------------------------------------------------------
%%> \section{Answers section}
%%% --------------------------------------------------------


\newcommand\answers{\par
	\answerstrue
	\setcounter{chapter}{0}%
	\setcounter{section}{0}%
	\renewcommand{\thesection}{\arabic{section}}
	\clearpage\pagestyle{answers}
	\chapter*{Відповіді}%
	\addcontentsline{toc}{chapter}{Відповіді}
	\renewcommand{\theequation}{\arabic{equation}}
	\if@restonecol\twocolumn\fi
}

\@newctr{footnote}[page] %  Лічильник зносок починаються з кожної сторінки
\RequirePackage[pagestyles, explicit]{titlesec}
\RequirePackage{titletoc}

\newlength\chapnumb
\setlength\chapnumb{4cm}

\titleformat{\part}[display]{\bfseries\sffamily\huge}{\partname\ \thepart }{0pt}{\addvspace{1em}\Huge\centering #1}

\titlecontents{part}%
[0pt]{\sffamily\bfseries\large\protect\addvspace{25pt}\addvspace{1.5ex}}
{}{\partname~}
{\hfill\contentspage}%
[\addvspace{0.7ex}\titlerule\addvspace{10pt}]%

\titleclass{\part}{top}
\newcommand\partbreak{\clearpage}

\titleformat{\chapter}[block]
{\normalfont\sffamily}{}{0pt}
{\parbox[b]{\chapnumb}{%
		\color{themecolordark}\fontsize{100}{90}\selectfont\thechapter}%
	\parbox[b]{\dimexpr\textwidth-\chapnumb\relax}{%
		\raggedleft%
		\hfill{\LARGE\bfseries#1}\\
		\rule{\dimexpr\textwidth-\chapnumb\relax}{0.4pt}}}

\titleformat{name=\chapter,numberless}[block]
{\normalfont\sffamily\bfseries}{}{0pt}
{\parbox[b]{\chapnumb}{%
		\mbox{}}%
	\parbox[b]{\dimexpr\textwidth-\chapnumb\relax}{%
		\raggedleft%
		\hfill{\LARGE#1}\\
		\rule{\dimexpr\textwidth-\chapnumb\relax}{0.4pt}}}

\titleformat{name=\section, numberless}
{\normalsize\bfseries}{}{1em}{#1}

\titleformat{\section}[hang]{\large\bfseries\sffamily}%
{\rlap{\color{themecolordark}\rule[-6pt]{\textwidth}{1.2pt}}\colorbox{themecolordark}{%
        \raisebox{0pt}[13pt][3pt]{ \makebox[60pt]{% height, width
                \color{white}{\thesection}}
}}}%
{15pt}%
{ \color{themecolordark}#1
    %
}

%Underlining ruler for subsections
\titleformat{\subsection}
{\normalfont\bfseries\color{themecolordark}}
{\thesubsection}
{1em}
{#1}
[{\titlerule[0.8pt]}]



%\titleformat{\subsection}
%{\normalsize\bfseries\itshape}{\thesubsection.}{1em}{#1}



\newpagestyle{main}{\headrule%
	\sethead{\ifodd\thepage\relax\else\itshape\small\thechapter.\ \chaptertitle\fi}{}{\ifodd\thepage\itshape\small\thechapter.\ \chaptertitle\else\relax\fi}
	\setfoot{}{\small\thepage}{}}

\newpagestyle{answers}{\headrule%
	\sethead{\ifodd\thepage\relax\else\itshape\small Відповіді\fi}{}{\ifodd\thepage\itshape\small Відповіді\else\relax\fi}
	\setfoot{}{\small\thepage}{}}

\newpagestyle{appendix}{\headrule%
	\sethead{\ifodd\thepage\relax\else\itshape\small Додатки\fi}{}{\ifodd\thepage\itshape\small Додатки\else\relax\fi}
	\setfoot{}{\small\thepage}{}}

\newpagestyle{bibliography}{\headrule%
	\sethead{\ifodd\thepage\relax\else\itshape\small\bibname\fi}{}{\ifodd\thepage\itshape\small\bibname\else\relax\fi}
	\setfoot{}{\small\thepage}{}}

\renewpagestyle{plain}{%
	\sethead{}{}{}
	\setfoot{}{\small\thepage}{}}

\assignpagestyle{\chapter}{plain}
\assignpagestyle{\part}{empty}




%%% --------------------------------------------------------
%%> \section{Spacings}
%%% --------------------------------------------------------


\def\tabcaption{\def\@captype{table}\caption}
\def\figcaption{\def\@captype{figure}\caption}
\RequirePackage[inline]{enumitem}
\setlist{nolistsep}


%  Відступи в формулах

\setlength\abovedisplayskip{1ex}
\setlength\belowdisplayskip{1ex}
\setlength\abovedisplayshortskip{1ex}
\setlength\belowdisplayshortskip{1ex}

% Відступ між написом та рисунком

\setlength{\textfloatsep}{5pt}

% Підписи до рисунку (розмір тексту

\captionsetup[figure]{font=small,labelfont=small}
\captionsetup[table]{font=small,labelfont=small}

% Bibliography spacing
\newlength{\bibitemsep}\setlength{\bibitemsep}{.1\baselineskip plus .05\baselineskip minus .05\baselineskip}
\newlength{\bibparskip}\setlength{\bibparskip}{0pt}
\let\oldthebibliography\thebibliography
\renewcommand\thebibliography[1]{%
	\oldthebibliography{#1}%
	\setlength{\parskip}{\bibitemsep}%
	\setlength{\itemsep}{\bibparskip}%
}




%%% --------------------------------------------------------
%%> \section{hyperref}
%%% --------------------------------------------------------


\RequirePackage[%
	bookmarks = true,
	bookmarksnumbered=true,
	unicode,
	linktocpage = true,
	hypertexnames=false,
	pdftoolbar=false,
	pdfpagelayout=TwoPageLeft,
	pdfauthor={Ponomarenko S.M.},
	pdfdisplaydoctitle=true,
	pdfkeywords={Geometrical Optics, dispersion, Difraction, Interferention, Polarisation, Light},
	pdfencoding=auto
]%
{hyperref}
%\RequirePackage[all]{hypcap}
\RequirePackage{bookmark}

% -------------- Патч для україомовної назви розділу для nameref ------------------ %
\addto\extrasukrainian{%
	\renewcommand{\chapterautorefname}{}%
}
% --------------------------------------------------------------------------------- %

\ifdefined\inlinetitle%
	\AtBeginDocument{\hypersetup{pdftitle={\inlinetitle}}}
\fi





%%% --------------------------------------------------------
%%> \section{Bybliography}
%%% --------------------------------------------------------


\ifbiblatex
	\RequirePackage[backend=biber,
		bibstyle=gost-numeric,
		maxnames = 10,
		babel=other,
		isbn=true,
		url=false,
		defernumbers=true
	]{biblatex}
	\newbibmacro{string+url}[1]{%
		\iffieldundef{url}{#1}{\href{\thefield{url}}{#1}}%
	}
	\DeclareFieldFormat{title}{\usebibmacro{string+url}{#1}}
	\RequirePackage{csquotes}

	\DefineBibliographyStrings{ukrainian}{%
		bibliography = {Література},
	}
	\DeclareBibliographyCategory{Textbooks}
	\DeclareBibliographyCategory{Problems}
\else
	\renewcommand{\@biblabel}[1]{#1.}
	\addto\captionsukrainian{%
		\renewcommand{\bibname}{Література}%
	}
\fi




%%% --------------------------------------------------------
%%> \section{Boxes typesetting}
%%% --------------------------------------------------------


\newtcolorbox{Theory}[2][]{
	breakable,
	enhanced,
	outer arc=0pt,
	arc=0pt,
	colframe=themecolordark,
	colback=themecolordark!20,
	attach boxed title to top left,
	fontupper=\small,
	before upper={\parindent15pt},
	boxed title style={
			colback=themecolordark,
			outer arc=0pt,
			arc=0pt,
			top=3pt,
			bottom=3pt,
		},
	fonttitle=\sffamily,
	colback=white,
	rightrule=0pt,
	%  toprule=0pt,
	before=\nopagebreak,
	title={Формули},
	overlay unbroken and first={
			\path
			let
			\p1=(title.north east),
			\p2=(frame.north east)
			in
			node[anchor=west,font=\sffamily,color=themecolordark,text width=\x2-\x1]
			at (title.east) {#2};
		}
}




\NewTColorBox{Attention}{O{} O{red}}{enhanced,
	breakable,
	before skip=2mm,after skip=3mm,
	before upper={\parindent15pt},
	boxrule=0.4pt,left=5mm,right=2mm,top=1mm,bottom=1mm,
	colback=#2!10,
	colframe=#2!50,
	sharp corners,rounded corners=southeast,arc is angular,arc=3mm,
	underlay={%
			\path[fill=tcbcolback!80!black] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
			\path[draw=tcbcolframe,shorten <=-0.05mm,shorten >=-0.05mm] ([yshift=3mm]interior.south east)--++(-0.4,-0.1)--++(0.1,-0.2);
			\path[fill=themecolordark,draw=none] (interior.south west) rectangle  ([xshift=4mm]interior.north west) node[pos=0.475,text=white, inner sep=0pt]{\Huge !};
		},
	drop fuzzy shadow,#1}





%%% --------------------------------------------------------
%%> \section{Examples typesetting}
%%% --------------------------------------------------------


\def\problemtitle{Задача}
\def\primer{Приклад}
\def\solut{Розв'язок}
\newcounter{example}

\NewDocumentCommand{\Example}{ O{} +m }{%
	%    \refstepcounter{example}
%	\@addtoreset{equation}{example}
\stepcounter{example}
	\begin{example}[Приклад: \theexample][label={#1}]
		#2
	\end{example}
}%

\newlength{\lsize}
\setlength{\lsize}{\dimexpr(0.3\linewidth)\relax}

\newlength{\msize}
\setlength{\msize}{\dimexpr(0.3\linewidth - 1mm)\relax}


\NewTColorBox[auto counter]{example}{O{} O{}}{%
	empty,title={#1},attach boxed title to top left,
	boxed title style={empty,size=minimal,toprule=2pt,top=4pt,
			overlay={\draw[themecolordark,line width=2pt]
					([yshift=-1pt]frame.north west)--([yshift=-1pt]frame.north east);}},
	coltitle=themecolordark,fonttitle=\bfseries,
	before=\par\medskip\noindent,parbox=false,boxsep=0pt,left=0pt, right=10pt, top=4pt,
	code={\if@twoside\tcbset{check odd page, toggle enlargement=evenpage}\fi},
	%	breakable,pad at break=0mm,
	%    grow to right by=\lsize,
	overlay unbroken={\draw[themecolordark,line width=1pt]
			([yshift=-1pt]title.north east)--([xshift=-0.5pt,yshift=-1pt]title.north-|frame.east)
			--([xshift=-0.5pt]frame.south east)--(frame.south west); },
	overlay first={\draw[themecolordark,line width=1pt]
			([yshift=-1pt]title.north east)--([xshift=-0.5pt,yshift=-1pt]title.north-|frame.east)
			--([xshift=-0.5pt]frame.south east); },
	overlay middle={\draw[themecolordark,line width=1pt] ([xshift=-0.5pt]frame.north east)
			--([xshift=-0.5pt]frame.south east); },
	overlay last={\draw[themecolordark,line width=1pt] ([xshift=-0.5pt]frame.north east)
			--([xshift=-0.5pt]frame.south east)--(frame.south west);},
   #2%
}

\newcounter{savedeq}

\NewTColorBox[auto counter]{solutionexample}{+O{} +O{height fill=true}}{%
    code=\setcounter{savedeq}{\value{equation}}%
    \setcounter{equation}{0}\renewcommand{\theequation}{\arabic{equation}},%
    after=\setcounter{equation}{\value{savedeq}},%
breakable, enhanced,sharpish corners, colframe=themecolordark,colback=white,coltitle=white,
boxrule=0.5mm,top=0mm,bottom=0mm,
code={\if@twoside\tcbset{check odd page, toggle enlargement, toggle left and right}\fi},
left=1mm,
#2,
%    right=\lsize,
%    grow to right by=\lsize,
before upper={\parindent1em},
%    underlay={%
%        \begin{tcbclipinterior}
%            \if@twoside%
%            \ifodd\value{page}%
%            \draw[o-o, gray!50,line width=1pt]
%            ([xshift=-\msize, yshift=-20pt]frame.north east)
%            --([xshift=-\msize, yshift=20pt]frame.south east);%
%            \else%
%            \draw[o-o, gray!50,line width=1pt]
%            ([xshift=\msize, yshift=-20pt]frame.north west)
%            --([xshift=\msize, yshift=20pt]frame.south west);%
%            \fi%
%            \else
%            \draw[o-o, gray!50,line width=1pt]
%            ([xshift=-\msize, yshift=-20pt]frame.north east)
%            --([xshift=-\msize, yshift=20pt]frame.south east);%
%            \fi
%    \end{tcbclipinterior}},
overlay first={%
		\draw [gray!50, decoration = {zigzag,segment length = 0.25cm, amplitude = 0.25mm},decorate,] (frame.south west) --  (frame.south east);
	},
overlay middle={%
		\draw [gray!50, decoration = {zigzag,segment length = 0.25cm, amplitude = 0.25mm},decorate,] (frame.north west) -- (frame.north east);
		\draw [gray!50, decoration = {zigzag,segment length = 0.25cm, amplitude = 0.25mm},decorate,] (frame.south west) -- (frame.south east);
	},
overlay last={%
		\draw [gray!50, decoration = {zigzag,segment length = 0.25cm, amplitude = 0.25mm},decorate,] (frame.north west) -- (frame.north east);
	},
fonttitle=\bfseries,
title={\solut},
%    attach boxed title to top center ={yshift=-\tcboxedtitleheight/2,yshifttext=-\tcboxedtitleheight/2},
attach boxed title to top center = {xshift=1cm,yshift*=1mm-\tcboxedtitleheight},
halign title=flush center,
boxed title style={%
		%    colback=blue!50,
		size=fbox,
		boxrule=1pt,
		boxsep=2pt,
		frame code={
				\path[fill=blue!60]
				([yshift=-1mm,xshift=-1mm]frame.north west)
				arc[start angle=0,end angle=180,radius=1mm]
				([yshift=-1mm,xshift=1mm]frame.north east)
				arc[start angle=180,end angle=0,radius=1mm];
				\path[left color=blue!50,right color=blue!50,
					middle color=blue!40!white]
				([xshift=-2mm]frame.north west) -- ([xshift=2mm]frame.north east)
				[rounded corners=1mm]-- ([xshift=1mm,yshift=-1mm]frame.north east)
				-- (frame.south east) -- (frame.south west)
				-- ([xshift=-1mm,yshift=-1mm]frame.north west)
				[sharp corners]-- cycle;
			},
		interior engine=empty,
	},
top=1em,
lowerbox=ignored,
%    height fill,
%    height fixed for=middle and last,
parbox = false,
#1
}





%%% --------------------------------------------------------
%%> \section{Problems typesetting}
%%% --------------------------------------------------------


%\usepackage[framemethod=tikz]{mdframed}
\RequirePackage{ntheorem}
\RequirePackage{answers}
\RequirePackage{xassoccnt}
\NewTotalDocumentCounter{totalproblems}

\newtheoremstyle{problemstyle}%
{%
	\hypertarget{problem:\@roman{##2}}{}%
	\ifcsname r@solution\@roman{##2}\endcsname
		\item[\theorem@headerfont\hyperlink{solution:\@roman{##2}}{##2\theorem@separator}]
	\else
		\item[\theorem@headerfont##2\theorem@separator]
	\fi
}%
{%
	\hypertarget{problem:\@roman{##2}}{}%
	\ifcsname r@solution\@roman{##2}\endcsname
		\item[\theorem@headerfont\hyperlink{solution:\@roman{##2}}{##2\theorem@separator}] ({\itshape##3})
	\else
		\item[\theorem@headerfont##2\theorem@separator] ({\itshape##3})
	\fi
}

\theoremstyle{problemstyle}
\theoremheaderfont{\hspace{1ex}\bfseries}
\theorembodyfont{\normalfont}
\theoremseparator{.}

\newtheorem{problem}{}[chapter]

\DeclareAssociatedCounters{problem}{totalproblems}

\tcbset{%
	answersolutionstyle/.style={%
			enhanced jigsaw,
			colframe=themecolordark,
            colback=cyan!1,
%            interior hidden,
%			boxrule=0pt,
			frame hidden,
			breakable,
            %            before skip=10pt,
			%                after skip=10pt,
%			parbox=false,
        overlay unbroken = {\draw[line width=1pt, themecolordark, rounded corners] (frame.south west) rectangle (frame.north east);},
        extras first={
            overlay={%
                \draw[line width=1pt, themecolordark, rounded corners] (frame.south west) -- (frame.north west) -- (frame.north east) --(frame.south east);
            },
        },
        extras middle={
            overlay={%
                \draw[line width=1pt, themecolordark, rounded corners] (frame.north west) -- (frame.south west)  (frame.south east) --(frame.north east);
            },
        },
        extras last={
            overlay={%
                \draw[line width=1pt, themecolordark, rounded corners] (frame.north west) -- (frame.south west) -- (frame.south east) --(frame.north east);
            },
        },
		},
}

\tcolorboxenvironment{problem}{answersolutionstyle}





%%% --------------------------------------------------------
%%> \section{Answers typesetting}
%%% --------------------------------------------------------


\newtcolorbox{answerbox}{answersolutionstyle,halign=left}

\Newassociation{solution}{Solution}{answer}
\renewenvironment{Solution}[1]{%
	\begin{answerbox}\setcounter{equation}{0}
		\hypertarget{solution:\@roman{#1}}{\hyperlink{problem:\@roman{#1}}{\bfseries#1.}\label{solution\@roman{#1}}}
		}{%
	\end{answerbox}
}





%%% --------------------------------------------------------
%%> \section{AIncluding commands}
%%% --------------------------------------------------------


%  https://tex.stackexchange.com/questions/382776/how-to-create-list-and-assign-it-to-variable



\ExplSyntaxOn
\NewDocumentCommand{\multiinclude}{ m O{} }
{
	\clist_set:Nx \l_Chapters_clist{ #1 }
	\clist_map_inline:Nn \l_Chapters_clist { \InputIfFileExists{##1/##1#2}{}{}\par}
}
\ExplSyntaxOff


\numberwithin{equation}{chapter}

\input{insbox}

\endinput