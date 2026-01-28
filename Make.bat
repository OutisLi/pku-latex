@echo off

@rem Copyright (c) 2008-2009 solvethis
@rem Copyright (c) 2010-2012 Casper Ti. Vector
@rem Public domain.

set JOB=thesis
set OUTDIR=build
@rem 这个变量的值可以为 latex、pdflatex 或 xelatex。
set LATEX=xelatex -synctex=1 -interaction=nonstopmode -file-line-error -output-directory=%OUTDIR%
set BIBTEX=biber -l zh__pinyin --output-safechars --input-directory=%OUTDIR% --output-directory=%OUTDIR%
set DVIPDF=dvipdfmx

if "%LATEX%"=="latex" (set DODVIPDF=%DVIPDF% %JOB%
) else (set DODVIPDF=echo No need to run %DVIPDF%.)
if "%1"=="" goto doc
if "%1"=="doc" goto doc
if "%1"=="clean" (goto clean) else (goto usage)

:doc
if not exist %OUTDIR% mkdir %OUTDIR%
if not exist %OUTDIR%\chap mkdir %OUTDIR%\chap
set TEXINPUTS=.;misc;
%LATEX% %JOB%
%BIBTEX% %JOB%
%LATEX% %JOB%
%LATEX% %JOB%
%DODVIPDF%
copy /y %OUTDIR%\%JOB%.pdf %JOB%.pdf
goto end

:clean
if exist %OUTDIR% (
    for /f "delims=" %%F in ('dir /b /a:-d %OUTDIR%') do if /I not "%%F"==".gitignore" del /q "%OUTDIR%\\%%F"
)
if exist %OUTDIR%\\chap (
    for /f "delims=" %%F in ('dir /b /a:-d %OUTDIR%\\chap') do if /I not "%%F"==".gitignore" del /q "%OUTDIR%\\chap\\%%F"
)
goto end

:usage
echo %0 [doc] [clean]
goto end

:end

@rem vim:ts=4:sw=4
