# Copyright (c) 2008-2009 solvethis
# Copyright (c) 2010-2012,2014-2015,2018 Casper Ti. Vector
# Public domain.

# 被编译的主文件的文件名，不包括扩展名。
JOB = thesis
OUTDIR = build
# 这个变量的值可以为 latex、pdflatex 或 xelatex。
LATEX = xelatex -synctex=1 -interaction=nonstopmode -file-line-error \
    -output-directory=$(OUTDIR)
BIBTEX = biber -l zh__pinyin --output-safechars \
    --input-directory=$(OUTDIR) --output-directory=$(OUTDIR)
DVIPDF = dvipdfmx

# 如果用 LaTeX 编译，则使用 dvipdfmx 将 dvi 转成 pdf。
ifeq ($(LATEX), latex)
    DODVIPDF = $(DVIPDF) -o $(JOB).pdf $(OUTDIR)/$(JOB)
endif

# 区分是 Windows 环境还是类 UNIX 环境。
# 如果是后者，则 GNU make 将可以检测到已经定义 PATH 环境变量。
ifdef PATH
    MAKE = make
    RM = rm -f
    CP = cp -f
    PDF_FROM = $(OUTDIR)/$(JOB).pdf
    MKDIR_BUILD = mkdir -p $(OUTDIR) $(OUTDIR)/chap
    TEXINPUTS_ENV = TEXINPUTS=.:misc:
    CLEAN_BUILD = find $(OUTDIR) -maxdepth 1 -type f ! -name .gitignore -delete
    CLEAN_BUILD_CHAP = find $(OUTDIR)/chap -type f ! -name .gitignore -delete
else
    MAKE = mingw32-make
    RM = del
    CP = copy /y
    PDF_FROM = $(OUTDIR)\\$(JOB).pdf
    MKDIR_BUILD = if not exist $(OUTDIR) mkdir $(OUTDIR) & if not exist $(OUTDIR)\\chap mkdir $(OUTDIR)\\chap
    TEXINPUTS_ENV = set TEXINPUTS=.;misc; &
    CLEAN_BUILD = for /f "delims=" %%F in ('dir /b /a:-d $(OUTDIR)') do if /I not "%%F"==".gitignore" del /q "$(OUTDIR)\\%%F"
    CLEAN_BUILD_CHAP = for /f "delims=" %%F in ('dir /b /a:-d $(OUTDIR)\\chap') do if /I not "%%F"==".gitignore" del /q "$(OUTDIR)\\chap\\%%F"
endif


$(OUTDIR):
	$(MKDIR_BUILD)

doc: $(OUTDIR)
	$(TEXINPUTS_ENV) $(LATEX) $(JOB)
	$(TEXINPUTS_ENV) $(BIBTEX) $(JOB)
	$(TEXINPUTS_ENV) $(LATEX) $(JOB)
	$(TEXINPUTS_ENV) $(LATEX) $(JOB)
	$(DODVIPDF)
	$(CP) $(PDF_FROM) $(JOB).pdf

clean:
	-$(CLEAN_BUILD)
	-$(CLEAN_BUILD_CHAP)

distclean: clean
	-$(RM) $(JOB).pdf

# vim:ts=4:sw=4
