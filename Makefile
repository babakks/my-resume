check-pretty:
	diff resume.tex <(latexindent -l resume.tex) \
	&& diff structure.tex <(latexindent -l structure.tex)
pretty:
	latexindent -l resume.tex -w \
	&& latexindent -l structure.tex -w
clean:
	rm -f *.bak* *.aux *.log *.out *.ent *.fls *.fdb_latexmk *.synctex.gz
build:
	lualatex resume.tex

SHELL = /usr/bin/bash
