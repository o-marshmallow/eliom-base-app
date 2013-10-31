{shared{
  open Eliom_content.Html5
  open Eliom_content.Html5.F
}}

class page_config () : Eba_page.config = object
  method title = "app"
  method js : string list list = []
  method css : string list list = []

  method default_error_page :
    'a 'b. 'a -> 'b -> exn option -> Eba_page.page_content_t Lwt.t =
    (fun gp pp exc ->
       Lwt.return [
         D.div [p [pcdata "error"]]
       ])

  method default_connect_error_page :
    'a 'b. int64 -> 'a -> 'b -> exn option -> Eba_page.page_content_t Lwt.t =
    (fun uid gp pp exc ->
       Lwt.return [
         D.div [p [pcdata "error"]]
       ])
end

class session_config () = object
  method on_open_session = Lwt.return ()
  method on_close_session = Lwt.return ()
  method on_start_process = Lwt.return ()
  method on_start_connected_process = Lwt.return ()
end

class email_config () = object
  method from_addr =
    ("team DEFAULT", "noreply@DEFAULT.DEFAULT")

  method mailer = "/usr/bin/sendmail"
end

module App = struct
  let session_config = new session_config ()
  let page_config = new page_config ()
  let email_config = new email_config ()

  let states = [
    (`Normal, "Normal", Some "allow you to register users");
    (`Restricted, "Restricted", Some "allow you to pre-register (not register) users");
  ]
end
