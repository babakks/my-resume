pretty:
	latexindent -l resume.tex -w
	latexindent -l structure.tex -w
clean:
	rm -f *.bak* *.aux *.log *.out *.ent *.fls *.fdb_latexmk *.synctex.gz
build:
	lualatex resume.tex