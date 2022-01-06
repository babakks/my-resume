bump-build-no:
	echo -n "$$(( 1+$$(cut -f1 -d" " version.dat || echo "-1") )) ($$(date -u +%y-%m-%d))" > version.dat

check-pretty:
	latexindent -l resume.tex > resume.pretty.tex \
	&& diff resume.tex resume.pretty.tex \
	&& latexindent -l structure.tex > structure.pretty.tex \
	&& diff structure.tex structure.pretty.tex

pretty:
	latexindent -l resume.tex -w \
	&& latexindent -l structure.tex -w

clean:
	rm -f *.bak* *.aux *.log *.out *.ent *.fls *.fdb_latexmk *.synctex.gz *.pretty.tex

build:
	lualatex resume.tex
