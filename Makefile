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

build-resume:
	lualatex -interaction=nonstopmode resume.tex \
	&& lualatex -interaction=nonstopmode resume.tex

build-resume-using-docker-image:
	export image_name="babakks/my-resume:$$(head -n 1 version.dat | sed -e 's/ /_/g' -e 's/(\|)//g')" \
	&& export container_name="build-my-resume" \
	&& docker build -t $$image_name . \
	&& docker run --name $$container_name -t $$image_name make build-resume \
	&& docker cp $$container_name:/app/resume.pdf . \
	; docker rm $$container_name

build-sop:
	lualatex -interaction=nonstopmode sop.tex \
	&& lualatex -interaction=nonstopmode sop.tex

build-sop-using-docker-image:
	export image_name="babakks/my-resume:$$(head -n 1 version.dat | sed -e 's/ /_/g' -e 's/(\|)//g')" \
	&& export container_name="build-my-sop" \
	&& docker build -t $$image_name . \
	&& docker run --name $$container_name -t $$image_name make build-sop \
	&& docker cp $$container_name:/app/sop.pdf . \
	; docker rm $$container_name
