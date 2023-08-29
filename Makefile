bump-build-no:
	echo -n "$$(( 1+$$(cut -f1 -d" " version.dat || echo "-1") )) ($$(date -u +%y-%m-%d))" > version.dat

tag:
	git tag --annotate "v$$(cat version.dat | cut -f1 -d' ')" -m "$$(cat version.dat)"

check-pretty:
	latexindent -l resume.tex > resume.pretty.tex \
	&& diff resume.tex resume.pretty.tex \
	&& latexindent -l sop.tex > sop.pretty.tex \
	&& diff sop.tex sop.pretty.tex \
	&& latexindent -l title.tex > title.pretty.tex \
	&& diff title.tex title.pretty.tex \
	&& latexindent -l structure.tex > structure.pretty.tex \
	&& diff structure.tex structure.pretty.tex

check-pretty-docker:
	$(call run_in_docker,make check-pretty)

pretty:
	latexindent -l resume.tex -w \
	&& latexindent -l sop.tex -w \
	&& latexindent -l title.tex -w \
	&& latexindent -l structure.tex -w

pretty-docker:
	$(call run_in_docker,make pretty)

clean:
	rm -f *.bak* *.aux *.log *.out *.ent *.fls *.fdb_latexmk *.synctex.gz *.pretty.tex

build-resume:
	lualatex -interaction=nonstopmode resume.tex \
	&& lualatex -interaction=nonstopmode resume.tex

build-resume-docker:
	$(call run_in_docker,make build-resume)

build-sop:
	lualatex -interaction=nonstopmode sop.tex \
	&& lualatex -interaction=nonstopmode sop.tex

build-sop-docker:
	$(call run_in_docker,make build-sop)

define run_in_docker
	docker run \
		--rm \
		-v '.:/app' \
		$(texlive_image) \
		bash -c 'cd /app && $(1)'
endef

texlive_image = 'texlive/texlive@sha256:4e514fb5596a8db3defd38f40fc0f7b119eb3fcc88a4bfe291cd36eb00551ddb'
