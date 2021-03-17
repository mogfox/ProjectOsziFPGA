\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fhviearticle}[2015/09/01]


\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\RequirePackage{ifthen}
\RequirePackage{etex}
\RequirePackage{versions}


\SetupKeyvalOptions{
	family=fh,
	prefix=fh@
}


\newif\iffhviearticle@student
\newif\iffhviearticle@lektor

\fhviearticle@studenttrue
\fhviearticle@lektorfalse



\DeclareStringOption[deutsch]{language}
\DeclareBoolOption[false]{lektor}


\PassOptionsToPackage{
	paper=A4,
	pagesize
}{typearea}


\PassOptionsToClass{
	twoside=false,
	bibliography= totocnumbered,
	index=totoc,%            Index ins Verzeichnis einfügen
	parskip=half,%        Europäischer Satz mit abstand zwischen Absätzen
	headsepline,%         Linie nach Kopfzeile
	footsepline,%         Linie vor Fusszeile
	12pt,%,                 Größere Schrift, besser lesbar am bildschirm
	DIV15
}{scrartcl}

\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}

\ProcessKeyvalOptions*

\LoadClass{scrartcl}



\AtBeginDocument{

	\pagestyle{scrheadings}
	\automark{section}
	\KOMAoptions{headsepline=true, footsepline=true}	

	% Fußzeile links
	\footerleft{\vorlesungsbezeichnung} 
 
	% Fußzeile rechts 
	\footerright{\getvalue{author}} 

}


% = Spracheinstellungen
\newtoggle{english}
\newtoggle{german}

\newcommand{\@language}{deutsch}
\ifthenelse{\equal{\fh@language}{deutsch}}
	{
		\toggletrue{german}
		\togglefalse{english}
		\renewcommand{\@language}{deutsch}
	}
	{
		\togglefalse{german}
		\toggletrue{english}
		\renewcommand{\@language}{english}
	}
\newcommand{\inputlng}[1]{\input{\@language/#1}}

\iffh@lektor
	\includeversion{lektor}
\else
	\excludeversion{lektor}
\fi






\usepackage{scrhack}
\usepackage{scrlayer-scrpage}



% Bei Mehrzeiligen Caption sollen weitere Zeilen genau untereinander stehen
%\usepackage[format=hang, font={bf}, textfont=md]{caption}

%
% Paket für die Indexerstellung.
%
\usepackage{makeidx}
\usepackage[nodayofweek]{datetime}

%
% Paket für Übersetzungen ins Deutsche
%

\iftoggle{german}
{
	\usepackage[german, ngerman]{babel}
}
{
	% Paket babel-english muss dazu installiert sein
	%\usepackage[english]{babel}
}


%
% Pakete um Latin1 Zeichnensätze verwenden zu können und die dazu
%  passenden Schriften.
%
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}

%
% Paket zum Erweitern der Tabelleneigenschaften
%
\usepackage{array}
\usepackage{colortbl}
%
% Paket um Grafiken einbetten zu können
%
\usepackage{graphicx}

%
% Spezielle Schrift verwenden.
%
\renewcommand{\encodingdefault}{T1}

%
% Spezielle Schrift im Koma-Script setzen.
%
\setkomafont{sectioning}{\normalfont\bfseries}
\setkomafont{captionlabel}{\normalfont\bfseries}
% Auskommentiert wegen Problemen mit scrpage2
%\setkomafont{pagehead}{\normalfont\itshape}
\setkomafont{descriptionlabel}{\normalfont\bfseries}

%
% Zeilenumbruch bei Bildbeschreibungen.
%
\setcapindent{1em} 	

%
% kopf und fusszeilen
%
\pagestyle{headings}
%\pagestyle{scrheadings}

%
% Type 1 Fonts für bessere darstellung in PDF verwenden.
%

\usepackage{mathptmx}
\usepackage[scaled=.90]{helvet}
\usepackage{inconsolata}


%
% Paket um Textteile drehen zu können
%
\usepackage{rotating}

%
% Package für Farben im PDF
%
\usepackage{xcolor}


%
% Paket um LIstings sauber zu formatieren.
%
\usepackage[savemem]{listings}
\lstloadlanguages{TeX}

%
% ---------------------------------------------------------------------------
% Listing Definationen für PHP Code
%
\definecolor{lbcolor}{rgb}{0.85,0.85,0.85}
\definecolor{boxshade}{rgb}{0.95,0.95,1}
\definecolor{xlgreen}{rgb}{0.8745,1,0.8745}
\definecolor{xlblue}{rgb}{0.43,1,1}
\definecolor{boxshade}{rgb}{0.95,0.95,1}
\definecolor{darkgreen}{rgb}{0,0.6,0}
\definecolor{lightgrey}{rgb}{0.97,0.97,0.97}
\definecolor{LinkColor}{rgb}{0,0,0}
\definecolor{lightbulbbox}{rgb}{0.95,0,0.8}

%\lstset{language=[LaTeX]TeX,
%	stepnumber=1,
%	numbersep=5pt,
%	numberstyle=\tiny,
%	breaklines=true,
%	breakautoindent=true,
%	postbreak=\space,
%	tabsize=2,
%	basicstyle=\ttfamily\footnotesize,
%	showspaces=false,
%	showstringspaces=false,
%	extendedchars=true,
%	backgroundcolor=\color{lbcolor}}

\lstset{language=[LaTeX]TeX,
	stepnumber=1,
	numbersep=5pt,
	numberstyle=\tiny,
	breaklines=true,
	breakautoindent=true,
	postbreak=\space,
	tabsize=2,
	basicstyle=\ttfamily\footnotesize,
	showspaces=false,
	showstringspaces=false,
	extendedchars=true,
	backgroundcolor=\color{lbcolor}
	}

	
%
% ---------------------------------------------------------------------------
%

%
% Neue Umgebungen
% ---------------------------------------------------------------------------

\newenvironment{ListChanges}%
	{\begin{list}{$\diamondsuit$}{}}%
	{\end{list}}


%
% Index erzeucgen
%
\makeindex

\makeatletter
	\newcommand\figcaption{\def\@captype{figure}\caption}
	\newcommand\tabcaption{\def\@captype{table}\caption}
\makeatother

%
% Paket für Links innerhalb des PDF Dokuments
%
\usepackage{float}
\definecolor{LinkColor}{rgb}{0,0,0}
\usepackage[%
%	pdfsubject={},
%	pdfkeywords={},
%	hyperfootnotes=false,
%	plainpages=false
]{hyperref}
	
\hypersetup{colorlinks=true,%
	linkcolor=LinkColor,%
	citecolor=LinkColor,%
	filecolor=LinkColor,%
	menucolor=LinkColor,%
	urlcolor=LinkColor}

\usepackage[numbers]{natbib}

\usepackage{longtable}
%\usepackage[onehalfspacing]{setspace}


\usepackage{textcomp}
\usepackage{dcolumn}
\usepackage{rccol}
\usepackage{fltpoint}
\usepackage{multirow}
\usepackage{multicol}
%\usepackage{picins}
\usepackage{picinpar}


\usepackage{subfig}
%\usepackage{subfigure}

\usepackage{lineno}
\usepackage[below]{placeins}
\usepackage{tabularx} 
\usepackage{paralist}

%---%\usepackage[automark,headsepline]{scrpage2} 
\KOMAoptions{headinclude}


% Um die Anzahl der Seiten festzustellen
\usepackage{lastpage}
\usepackage{flafter}
\usepackage{eurosans,booktabs}
%\usepackage{ulem}


\usepackage{textpos}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{1mm}



%\renewcommand{\rmdefault}{ugm}
%\renewcommand{\sfdefault}{uop}
%\renewcommand{\ttdefault}{pcr}
\usepackage{pdfpages}

\usepackage{enumitem}


\usepackage{framed}
\usepackage{nth}
\usepackage{caption}
\usepackage{xspace}
\usepackage{pgfkeys}
\usepackage{pgffor}
\usepackage{datetime}
\usepackage{environ}
\usepackage{tikz}
\usetikzlibrary{shapes,arrows,positioning,shadows,fit,backgrounds,calc,patterns,scopes,decorations.pathreplacing}

% Für das Schraubenschlüssellogo
\usepackage[tikz]{bclogo}
\usepackage{amsmath}
\usepackage{wrapfig}
\usepackage[os=win]{menukeys}
\usepackage[framemethod=tikz]{mdframed}
\usepackage{pifont}
\usepackage{booktabs}


% =======================================
%
% Eigene Makros
%
% =======================================
\newcommand{\vorlesungsnummer}{\getvalue{vorlesungsnummer}\xspace}
\newcommand{\vorlesungsbezeichnung}{\getvalue{vorlesungsbezeichnung}\xspace}

\newcommand{\footerleft}[1]{%
	\ifoot{#1}
}
\newcommand{\footerright}[1]{%
	\ofoot{#1}
}

\newcommand{\setvalue}[2]{\pgfkeyssetvalue{/variables/#1}{#2}}
\newcommand{\getvalue}[1]{\pgfkeysvalueof{/variables/#1}}
\newcommand{\declare}[1]{%
 \pgfkeys{
  /variables/#1.is family,
  /variables/#1.unknown/.style = {\pgfkeyscurrentpath/\pgfkeyscurrentname/.initial = ##1}
 }%
}

\declare{}

	\setvalue{vorlesungsnummer}{}
	\setvalue{vorlesungsbezeichnung}{}
	
	\setvalue{pdfauthor}{}
	\setvalue{pdftitle} {}
	\setvalue{pdfsubject}{}
	\setvalue{foopdfkeywords}{}
	\setvalue{pdfcreationdate}{\pdfdate}
	\setvalue{pdfmoddate}{\pdfdate}	
	
	\setvalue{aufgabenum}{}
	%\setvalue{aufgabetitel}{}
	


\newcommand{\setpdfinfo}{%
\hypersetup{	
		pdftitle ={\getvalue{pdftitle}},%
		pdfcreator = {TeX},%
		pdfproducer= {pdfTeX 1.40.0},%
		pdfauthor={\getvalue{pdfauthor}},%
		pdfcreationdate={\getvalue{pdfcreationdate}},%
		pdfmoddate={\getvalue{pdfmoddate}},%
		pdfkeywords={\getvalue{pdfkeywords}}, 
		pdfsubject={\getvalue{pdfsubject}},%
	}
}


\newcommand{\smallitemize}
{
  \setlength{\itemsep}{0cm}%
  \setlength{\parskip}{0cm}%
}

\newcommand{\stmt}[1]{\texttt{#1}}
\newcommand{\lstmt}[1]{\hspace*{1cm}\texttt{#1}}
\newcommand{\var}[1]{\textit{#1}}
\newcommand{\jclass}[1]{{\changefont{iwonal}{c}{n}\fontsize{12}{12}\selectfont#1}\xspace}
\newcommand{\jclasssec}[1]{{\changefont{iwonal}{c}{n}\fontsize{14}{14}\selectfont\textbf{#1}}\xspace}


\NewEnviron{sntx}[1]
{
	\par\medskip\noindent
	\begin{tikzpicture}
		\node[inner sep=0pt] (box) {\parbox[t]{.98\textwidth}{%
		
		\begin{minipage}{.2\textwidth}
			\centering
			\tikz[scale=2]
			% bcoutil in Package bclogo!!!			
			\node[scale=1.5]{\bcoutil};
		\end{minipage}%
		\begin{minipage}{.65\textwidth}%
			\BODY%
			\end{minipage}\hfill}%
		};
    \draw[red!75!black,line width=3pt]
      ($ (box.north east) + (-5pt,3pt) $) -- ($ (box.north east) + (0,3pt) $) -- ($ (box.south east) + (0,-3pt) $) -- + (-5pt,0);
    \draw[red!75!black,line width=3pt]
      ($ (box.north west) + (5pt,3pt) $) -- ($ (box.north west) + (0,3pt) $) -- ($ (box.south west) + (0,-3pt) $) -- + (5pt,0);
 		
		
		
	\end{tikzpicture}%
}

% Für Syntax
\newcommand{\syntax}[1]{{$\langle$\begingroup \normalfont\textit{#1}\endgroup$\rangle$}}
%\newcommand{\syntax}[1]{{\begingroup \normalfont\textit{#1}\endgroup}}

\definecolor{darkgreen}{rgb}{0,0.6,0}
\definecolor{lightgrey}{rgb}{0.97,0.97,0.97}

\lstdefinestyle{Common}
{
    extendedchars=\true,
%    language={[Visual]Basic},
    frame=single,
    %===========================================================
    framesep=10pt,%expand outward.
    framerule=0.4pt,%expand outward.
    xleftmargin=10.4pt,%make the frame fits in the text area. 
    xrightmargin=10.4pt,%make the frame fits in the text area.
    %=========================================================== 
    rulecolor=\color{black}
}
\lstset
{
    breaklines=true,
    tabsize=2,
    showstringspaces=false,
    morekeywords={Single,Double}
}

\lstset{literate=%
    {Ö}{{\"O}}1
    {Ä}{{\"A}}1
    {Ü}{{\"U}}1
    {ß}{{\ss}}1
    {ü}{{\"u}}1
    {ä}{{\"a}}1
    {ö}{{\"o}}1
    {€}{{\texteuro}}1
    {~}{{\textasciitilde}}1
    {à}{{\`{a}}}1
}

\lstdefinestyle{VBA}
{
    style=Common,
    language={[Visual]Basic},
    %backgroundcolor=\color{yellow!10},
    backgroundcolor=\color{white},
    basicstyle=\scriptsize\color{black}\ttfamily,
    keywordstyle=\color{blue},
    identifierstyle=\color{black},
    stringstyle=\color{red},
    commentstyle=\color{darkgreen},
         tabsize=2,                  % Groesse von Tabs
         extendedchars=true,         %
         breaklines=true,            % Zeilen werden Umgebrochen
         showspaces=false,           % Leerzeichen anzeigen ?
         showtabs=false,             % Tabs anzeigen ?
         xleftmargin=17pt,
         xrightmargin=17pt,
         %framexleftmargin=10pt,
         framexrightmargin=5pt,
         %framexbottommargin=2pt,
         backgroundcolor=\color{white},
         showstringspaces=false      % Leerzeichen in Strings anzeigen ?        
}

\lstdefinestyle{VBALOC}
{
    style=VBA,
          numbers=left,               % Ort der Zeilennummern
         numberstyle=\tiny,          % Stil der Zeilennummern
         %stepnumber=2,               % Abstand zwischen den Zeilennummern
         numbersep=5pt,              % Abstand der Nummern zum Text
 }


\lstdefinestyle{JAVALOC}
{
		style=VBA,
		frame=b,
		language=Java,
		numbers=left,               % Ort der Zeilennummern
		numberstyle=\tiny,          % Stil der Zeilennummern
		%stepnumber=2,               % Abstand zwischen den Zeilennummern
		numbersep=5pt,              % Abstand der Nummern zum Text
 }

 \lstloadlanguages{[LaTeX]TeX}
\lstdefinestyle{latexown}
{
	style=VBA,
	language=[LaTeX]TeX,
}


%\usepackage{caption}
\DeclareCaptionFont{white}{\color{white}}
\DeclareCaptionFormat{listing}{\colorbox[cmyk]{0.43, 0.35, 0.35,0.01}{\parbox{\textwidth}{\hspace{15pt}#1#2#3}}}
\captionsetup[lstlisting]{format=listing,labelfont=white,textfont=white, singlelinecheck=false, margin=0pt, font={bf,footnotesize}}
 
\newcommand{\btn}[1]{\includegraphics[height=9pt]{images/#1}}


% Nummerierung der Abbildungen nach Kapitel.Abbildung
\renewcommand{\thefigure}{\thesection.\arabic{figure}}
\makeatletter \@addtoreset{figure}{section} \makeatother


% Nummerierung der Abbildungen nach Kapitel.Tabelle
\renewcommand{\thetable}{\thesection.\arabic{table}}
\makeatletter \@addtoreset{table}{section} \makeatother

% Nummerierung der Abbildungen nach Kapitel.Listing
\makeatletter
\AtBeginDocument{%
\renewcommand{\thelstlisting}{\thesection.\arabic{lstlisting}}}
\makeatother

\makeatletter \@addtoreset{lstlisting}{section} \makeatother


% Einzug der In der TOC ändern, da die Nummern sehr breit sind
\makeatletter
\renewcommand{\l@subsection}{\@dottedtocline{2}{1em}{2.6em}}
\makeatother
\makeatletter
\renewcommand{\l@subsubsection}{\@dottedtocline{2}{3.6em}{3.3em}}
\makeatother

\makeatletter
\renewcommand{\l@figure}{\@dottedtocline{2}{1em}{3em}}
\makeatother

\makeatletter
\renewcommand{\l@table}{\@dottedtocline{2}{1em}{3em}}
\makeatother

\makeatletter
\renewcommand{\l@lstlisting}{\@dottedtocline{2}{1em}{3em}}
\makeatother


% Tabbing umdefinieren, damit Abstand zum Text kleiner wird
\makeatletter
\gdef\tabbing{\lineskip \z@skip\let\>\@rtab\let\<\@ltab\let\=\@settab
     \let\+\@tabplus\let\-\@tabminus\let\`\@tabrj\let\'\@tablab
     \let\\=\@tabcr
     \@hightab\@firsttab
     \global\@nxttabmar\@firsttab
     \dimen\@firsttab\@totalleftmargin
     \global\@tabpush\z@ \global\@rjfieldfalse
     \trivlist \item\relax
     \if@minipage\else\vskip-\parskip\fi
     \setbox\@tabfbox\hbox{%
       \rlap{\hskip\@totalleftmargin\indent\the\everypar}}%
     \def\@itemfudge{\box\@tabfbox}%
     \@startline\ignorespaces}
\g@addto@macro\endtabbing{\vskip-2\parskip}

\makeatother


%
% Spezielle Schrift im Koma-Script setzen.
%
\setkomafont{sectioning}{\normalfont\bfseries}
\setkomafont{captionlabel}{\normalfont\bfseries}
% Auskommentiert wegen Problemen mit scrpage2
%\setkomafont{pagehead}{\normalfont\itshape}
\setkomafont{descriptionlabel}{\normalfont\bfseries}


% Kopfzeile geht über den gesamten Text inklusive Randbereich
%\setheadwidth{textwithmarginpar}

% Nummerierung der Überschriften ausschalten
%\setcounter{secnumdepth}{-1}

% Inhaltsverzeichnis 
\setcounter{tocdepth}{4}

\newcommand{\changefont}[3]{\fontfamily{#1}\fontseries{#2}\fontshape{#3}\selectfont}


% Referenz auf Kapitel
\newcommand{\kaprefnb}[1]{\hyperref[#1]{Kapitel~\ref*{#1} (\nameref{#1})}}

% Referenz auf Kapitel
\newcommand{\kapref}[1]{\hyperref[#1]{Kapitel~\ref*{#1}}}
\newcommand{\chapref}[1]{\hyperref[#1]{chapter~\ref*{#1}}}

% Referenz auf eine Kapitel mit Seite
\newcommand{\kaprefnp}[1]{\hyperref[#1]{Kapitel~\ref*{#1} \nameref{#1} auf Seite~\pageref*{#1}}}

% Referenz auf eine Kapitel mit Seite
\newcommand{\kaprefcnp}[1]{\hyperref[#1]{Kapitel~\ref*{#1}, \nameref{#1}, auf Seite~\pageref*{#1}}}


% Referenz auf eine Kapitel mit Seite
\newcommand{\kaprefp}[1]{\hyperref[#1]{Kapitel~\ref*{#1} auf Seite~\pageref*{#1}}}
\newcommand{\chaprefp}[1]{\hyperref[#1]{chapter~\ref*{#1} on page~\pageref*{#1}}}

\newcommand{\kaprefspb}[1]{\hyperref[#1]{(Kapitel~\ref*{#1}, Seite~\pageref*{#1})}  }



% Referenz auf Section
\newcommand{\secref}[1]{\hyperref[#1]{Abschnitt~\ref*{#1}}}

% Referenz auf Abbildung
\newcommand{\figref}[1]{\hyperref[#1]{Abbildung~\ref*{#1}}}
\newcommand{\figrefe}[1]{\hyperref[#1]{figure~\ref*{#1}}}

% Referenz auf Abbildung in Klammer
\newcommand{\figrefb}[1]{\hyperref[#1]{(Abbildung~\ref*{#1})}}

% Referenz auf Abbildung mit Seitenangabe
\newcommand{\figrefp}[1]{\hyperref[#1]{Abbildung~\ref*{#1} auf Seite \pageref{#1}}}


% Referenz auf Anhang
\newcommand{\appref}[1]{\hyperref[#1]{Anhang~\ref*{#1}}}

% Referenz auf Anhang mit Namen in Klammer
\newcommand{\apprefnb}[1]{\hyperref[#1]{Anhang~\ref*{#1}~(\nameref{#1})}}

% Referenz auf Anhang mit Namen 
\newcommand{\apprefn}[1]{\hyperref[#1]{Anhang~\ref*{#1}~\nameref{#1}}}


% Referenz auf Anhang mit Seitenangabe
\newcommand{\apprefp}[1]{\hyperref[#1]{Anhang~\ref*{#1}} auf Seite~\pageref{#1}}

% Referenz auf Tabelle
\newcommand{\tabrefo}[1]{\hyperref[#1]{Tabelle~\ref*{#1}}}

% Referenz auf Tabelle
\newcommand{\tabref}[1]{\hyperref[#1]{Tabelle~\ref{#1}}}

% Referenz auf eine Seite
\newcommand{\pgref}[1]{\hyperref[#1]{Seite~\pageref*{#1}}}


% Referenz auf Listing
\newcommand{\lstref}[1]{\hyperref[#1]{Listing~\ref*{#1}}}
\newcommand{\lstrefn}[1]{\hyperref[#1]{\ref*{#1} (\nameref{#1})}}

% Grafik mit grünem OK Häkchen
\newcommand{\chkok}{
\includegraphics*[height=0.3cm]{images/ok}}
% Grafix mit rotem X für nicht OK
\newcommand{\chknotok}{\includegraphics*[height=0.3cm]{images/notok}}

% Excel Zelle
\def\xlc#1{{\textit{#1}\xspace}}

\newcommand{\xlf}[1]{{\changefont{cmss}{sbc}{n}\small{#1}}}


\newmdenv[
  skipabove=\topskip,
  skipbelow=\topskip,
  innermargin=0pt,
  outermargin=0pt,
  innerleftmargin=12pt,
  innerrightmargin=12pt,
  innertopmargin=5pt,
  innerbottommargin=5pt,
  backgroundcolor=boxshade,
  topline=false,
  rightline=true,
  bottomline=false,
  linecolor=green,
  linewidth=2pt,
   ]{infobox*}
   
\newenvironment{infobox}[1][43]
  {\begin{infobox*}%
   \makebox[0pt][r]{\smash{\raisebox{-0.333\height}{\Large\ding{#1}\hspace{18pt}}}}\ignorespaces}%
  {\end{infobox*}}%


% Environment for a colored box
\newenvironment{fshaded}
{%
	\def\FrameCommand{\fcolorbox{framecolor}{shadecolor}}%
	\MakeFramed {\FrameRestore}
}%
{\endMakeFramed}


% Environment for a box with disclaimer colors
\newenvironment{samplebox}
{
	\definecolor{shadecolor}{rgb}{1,.78,.623}%
	\definecolor{framecolor}{rgb}{1,0,0}%
	\begin{fshaded}
}
{
	\end{fshaded}
}

  
  \newmdenv[
  skipabove=\topskip,
  skipbelow=\topskip,
  innermargin=0pt,
  outermargin=0pt,
  innerleftmargin=12pt,
  innerrightmargin=12pt,
  innertopmargin=5pt,
  innerbottommargin=5pt,
  backgroundcolor=boxshade,
  topline=false,
  rightline=true,
  bottomline=false,
  linecolor=lightbulbbox,
  linewidth=2pt,
   ]{lightbulbbox*}
\newenvironment{lightbulbbox}[1][43]
  {\begin{lightbulbbox*}%
 \makebox[0pt][r]{\smash{\raisebox{-0.333\height}{\includegraphics[height=1.2em]{lightbulb}\hspace{18pt}}}}\ignorespaces}%
  {\end{lightbulbbox*}}%

\newcommand{\upquote}[1]{\textquotedbl#1\textquotedbl}


\def\titel{%
{\Large\bfseries
\begin{description}[leftmargin=1.7cm, style=nextline]
	\smallitemize%
	\item[\aufgabenum] \aufgabetitel%
\end{description}%
%\vspace*{-1em}%
}}%



\newcommand\vsection[1]{\vspace*{-1em}\section{#1}\vspace*{-1em}}
\newcommand\vsubsection[1]{\vspace*{-1em}\subsection{#1}\vspace*{-1em}}

\newcommand\aufgabenum{\getvalue{aufgabenum}}
\newcommand\aufgabetitel{\getvalue{aufgabetitel}}
