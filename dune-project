(lang dune 3.16)

(name WebOcaml)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name WebOcaml)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune dream tyxml tyxml-ppx omd)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
