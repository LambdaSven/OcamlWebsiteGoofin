# Overview
This project is a learning project for learning how to create a basic website using Ocaml (Dream) and HTMX. There will be minimal javascript, and all the HTML will be written in Ocaml with Tyxml.

All the reactivity will be handled with HTMX.

I might turn it into a blog website, long term. But for now, it's just a place to learn and experiement.

# Setup

This project should be run in a switch with ocaml 5.1.0, using 

`opam switch create . 5.1.0`

This project requires the following dependencies

Dream
Tyxml
Tyxml-ppx
Omd
Core

Additionally, if you're working on it you should also install 

ocaml-lsp-server

You can instal all of the above with the following command.

`opam install dream tyxml tyxml-ppx ocaml-lsp-server omd`
