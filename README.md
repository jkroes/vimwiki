# Building this website
cd <project-dir>
Rscript -e 'rmarkdown::render_site()'

# Notes
Markdown files beginning with _ are not rendered, as they are considered to be
child documents included in parent .Rmd files.

.Rmd files only need title in its YAML header.

# Files

_index.Rmd: vimwiki's index (SPC v w)
index.Rmd is the website's home page

