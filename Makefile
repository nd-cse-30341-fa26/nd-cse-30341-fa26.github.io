# Configuration

DOCROOT=	public
WWWROOT=	weasel:$(HOME)/www/courses/cse.30341.fa26
YASB=		scripts/yasb.py

SLIDES_MD=	$(wildcard slides/*.md)
SLIDES_HTML=	$(patsubst slides/%, public/%, $(SLIDES_MD:.md=.html))
SLIDES_PDF=	$(patsubst slides/%, static/pdf/%, $(SLIDES_MD:.md=.pdf))
THEME_CSS=	static/css/domer-slides.css

# Rules

build:	$(SLIDES_HTML)
	@$(YASB)

install:	build
	@rsync -av --progress --delete $(DOCROOT)/. $(WWWROOT)/.

public/%.html:	slides/%.md $(THEME_CSS)
	scripts/marp.sh --theme $(THEME_CSS) --html -o $@ $<

public/static/pdf/%.pdf: slides/%.md $(THEME_CSS)
	scripts/marp.sh --theme $(THEME_CSS) --pdf -o$@ $<

clean:
	@echo Cleaning...
	@rm -fr $(DOCROOT)
