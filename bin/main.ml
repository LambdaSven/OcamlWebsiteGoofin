let number = ref 0

(* File into raw MD string *)
let md_to_string year title = 
  let ic = "blogs/" ^ year ^ "/" ^ title in
  let open Core in
  In_channel.read_all ic

(* Raw HTML String *)
let get_blog year title = 
 let open Omd in
 let file = md_to_string year title in
 to_html @@ of_string file

(*HTML String into Tyxml object *)
let content year title = 
  let s_html = get_blog year title in
  [%html s_html]

let l_link = 
  let open Tyxml.Html in 
   a ~a:[a_href "/ily"] [txt "Hey, Guess What?"]

let htmx_script = 
  let open Tyxml.Html in
  script ~a:[a_src "https://unpkg.com/htmx.org@2.0.4"] (txt "")
(*
let highlight_script = 
  let open Tyxml.Html in
    link ~a:[a_rel [`Stylesheet]; a_href "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/default.min.css"]

let highlight_js = 
 let open Tyxml.Html in
    script ~a:[a_src "https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"] (txt "") 
*)

let ht_button_Increase =
  let open Tyxml.Html in 
  button ~a:[
    Unsafe.string_attrib "hx-post" "/inc";
    Unsafe.string_attrib "hx-target" "#count";
    Unsafe.string_attrib "hx-swap" "textContent"]
  [txt "Increase"] 


let ht_button_decrease =
  let open Tyxml.Html in 
  button ~a:[
    Unsafe.string_attrib "hx-post" "/dec";
    Unsafe.string_attrib "hx-target" "#count";
    Unsafe.string_attrib "hx-swap" "textContent"] 
  [txt "Decrease"] 

let ht_button_update =
  let open Tyxml.Html in
  button ~a:[
    Unsafe.string_attrib "hx-get" "/update";
    (* Unsafe.string_attrib "hx-trigger" "load(*, every 1s"; *)
    Unsafe.string_attrib "hx-target" "#count";
    Unsafe.string_attrib "hx-swap" "textContent"
  ]
    [txt "Update!"]

let count = 
  let open Tyxml.Html in 
  p ~a:[a_id "count"] [txt @@ string_of_int !number]

let counter = 
  let open Tyxml.Html in 
  div ~a:[a_class ["counter"]]
    [ht_button_Increase; count; ht_button_decrease; ht_button_update]

let page = 
  let open Tyxml.Html in 
  html 
    (head (title (txt "Wheeee!")) [htmx_script])
    (body [l_link; counter])

(*
let html_to_string html = Fmt.str "%a" (Tyxml.Html.pp ()) html
*)

let elt_to_string elt = Fmt.str "%a" (Tyxml.Html.pp_elt ()) elt



let () =
  Dream.run (* ~interface:"192.168.0.106" *)
  @@ Dream.logger
  @@ Dream.router [
    Dream.get "/" (
      fun _ ->
      Dream.html @@ elt_to_string page
    );
    Dream.get "/echo/:word" (
      fun request -> 
        Dream.html @@ Dream.param request "word"
      );
    Dream.get "/ily" (
      fun _ -> 
        Dream.html "I love you :)"
    );
    Dream.post "/inc" (
      fun _ -> 
      number := !number + 1;
        Dream.html @@ string_of_int !number
      );
    Dream.post "/dec" (
      fun _ -> 
      number := !number - 1;
      Dream.html @@ string_of_int !number
    );
    Dream.get "/update" (
      fun _ -> Dream.html @@ string_of_int !number
      );
    Dream.get "/:year/:title" (
       fun request -> 
        Dream.html @@ content (Dream.param request "year") (Dream.param request "title")
      )
  ]
