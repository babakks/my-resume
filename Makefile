bump-build-no:
	echo -n "$$(( 1+$$(cut -f1 -d" " version.dat || echo "-1") )) ($$(date -u +%y-%m-%d))" > version.dat

check-pretty:
	latexindent -l resume.tex > resume.pretty.tex \
	&& diff resume.tex resume.pretty.tex \
	&& latexindent -l sop.tex > sop.pretty.tex \
	&& diff sop.tex sop.pretty.tex \
	&& latexindent -l title.tex > title.pretty.tex \
	&& diff title.tex title.pretty.tex \
	&& latexindent -l structure.tex > structure.pretty.tex \
	&& diff structure.tex structure.pretty.tex

check-pretty-using-docker-image:
	export container_name="check-pretty" \
	&& docker build -t $(image_name) . \
	&& docker run --name $$container_name $(image_name) make check-pretty \
	; export exit_code="$$?" \
	; docker rm $$container_name \
	&& exit $$exit_code

pretty:
	latexindent -l resume.tex -w \
	&& latexindent -l sop.tex -w \
	&& latexindent -l title.tex -w \
	&& latexindent -l structure.tex -w

pretty-using-docker-image:
	export container_name="prettify-my-resume" \
	&& docker build -t $(image_name) . \
	&& docker run --name $$container_name -t $(image_name) make pretty \
	; export exit_code="$$?" \
	; docker cp $$container_name:/app/resume.tex . \
	&& docker cp $$container_name:/app/sop.tex . \
	&& docker cp $$container_name:/app/title.tex . \
	&& docker cp $$container_name:/app/structure.tex . \
	; docker rm $$container_name \
	&& exit $$exit_code

clean:
	rm -f *.bak* *.aux *.log *.out *.ent *.fls *.fdb_latexmk *.synctex.gz *.pretty.tex

build-resume:
	lualatex -interaction=nonstopmode resume.tex \
	&& lualatex -interaction=nonstopmode resume.tex

build-resume-using-docker-image:
	export container_name="build-my-resume" \
	&& docker build -t $(image_name) . \
	&& docker run --name $$container_name -t $(image_name) make build-resume \
	; export exit_code=$$? \
	; docker cp $$container_name:/app/resume.pdf . \
	; docker rm $$container_name \
	&& exit $$exit_code

build-sop:
	lualatex -interaction=nonstopmode sop.tex \
	&& lualatex -interaction=nonstopmode sop.tex

build-sop-using-docker-image:
	export container_name="build-my-sop" \
	&& docker build -t $(image_name) . \
	&& docker run --name $$container_name -t $(image_name) make build-sop \
	; export exit_code=$$? \
	; docker cp $$container_name:/app/sop.pdf . \
	; docker rm $$container_name \
	&& exit $$exit_code

image_name = $(shell echo "babakks/my-resume:$$(head -n 1 version.dat | sed -e 's/ /_/g' -e 's/(\|)//g')")