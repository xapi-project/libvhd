open Vhd

let _ =
  let filename = Sys.argv.(1) in
  let vhd = _open filename [] in
  close vhd
