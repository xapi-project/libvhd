(*
 * Copyright (c) Citrix Systems, Inc.
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of XenSource Inc. nor the names of its contributors
 *       may be used to endorse or promote products derived from this software
 *       without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)

type vhd
(** an opened vhd disk *)

type open_flags = 
	| Open_rdonly
	| Open_rdwr
	| Open_fast
	| Open_strict
	| Open_ignore_disabled
	| Open_cached
	| Open_io_write_sparse

type create_flags =
	| Flag_creat_file_size_fixed
	| Flag_creat_parent_raw

type vhd_type =
	| Ty_none
	| Ty_fixed
	| Ty_dynamic 
	| Ty_diff

val _open : string -> open_flags list -> vhd
(** [_open filename flags] opens the vhd file given by [filename] with flags [flags] *)

val close : vhd -> unit
(** [close vhd] closes an open vhd file *)

val create : string -> int64 -> vhd_type -> int64 -> create_flags list -> unit
(** [create name size type mbytes_preallocated flags] creates a vhd with
    filename [name], virtual size [size] and with BATs preallocated for
    [mbytes_preallocated] MiB *)

val snapshot : string -> int64 -> string -> int64 -> create_flags list -> unit
(** [snapshot name size parent mbytes_preallocated flags] creates a vhd snapshot
    of [parent] called [name]. If [size] is 0 then the parent's size is inherited.
    Space for [mbytes_preallocated] worth of BATs are allocated. *)

val get_phys_size : vhd -> int64
(** [get_phys_size vhd] returns the amount of physical space consumed on the
    real disk by the virtual disk. *)

val set_phys_size : vhd -> int64 -> unit
(** [set_phys_size vhd size] allows the physical space allocated on the real disk
    to be increased. *)

val set_virt_size : vhd -> int64 -> unit
(** [set_virt_size vhd size] allows the virtual size of the disk to be increased. *)

val get_uid : vhd -> string
val get_max_bat_size : vhd -> int64 
val get_parent_uid : vhd -> string 
val get_parent : vhd -> string
val get_virtual_size : vhd -> int64
val get_type : vhd -> vhd_type
val get_creator : vhd -> string
val get_hidden : vhd -> int 
val set_hidden : vhd -> int -> unit 
val coalesce : vhd -> unit
val write_sector : vhd -> int64 -> string -> int
val read_sector : vhd -> int64 -> string
val set_log_level : int -> unit
val set_parent : vhd -> string -> bool -> unit
val get_bat : vhd -> (int*int) list
val get_first_allocated_block : vhd -> int64 option
