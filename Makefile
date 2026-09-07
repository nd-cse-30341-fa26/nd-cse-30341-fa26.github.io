# Configuration

DOCROOT=	public
WWWROOT=	weasel:$(HOME)/www/courses/$(shell awk '/prefix/ {print $$2}' site.yaml)
YASB=		scripts/yasb.py

SLIDES_MD=	$(wildcard slides/*.md)
SLIDES_HTML=	$(patsubst slides/%, public/%, $(SLIDES_MD:.md=.html))
SLIDES_PDF=	$(patsubst slides/%, static/pdf/%, $(SLIDES_MD:.md=.pdf))
THEME_CSS=	static/css/domer-slides.css

# Rules

build:	$(SLIDES_HTML)
	@$(YASB)

pdfs:	$(SLIDES_PDF)

install:	build
	@rsync -av --progress --delete $(DOCROOT)/. $(WWWROOT)/.

public/%.html:	slides/%.md $(THEME_CSS)
	scripts/marp.sh --theme $(THEME_CSS) --html -o $@ $<

static/pdf/%.pdf: slides/%.md $(THEME_CSS)
	scripts/marp.sh --theme $(THEME_CSS) --pdf -o $@ $<

clean:
	@echo Cleaning...
	@rm -fr $(DOCROOT)
