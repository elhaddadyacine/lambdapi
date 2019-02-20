(** Calling provers in Why3 *)

open Why3


(* list of provers' name *)
let provers_name : (string * string) list ref =
    ref
    [
        "altergo", "Alt-Ergo";
        "AltErgo", "Alt-Ergo";
        "e"      , "Eprover";
        "eprover", "Eprover";
    ]

(* get the real name of a prover *)
let get_name : string -> string = fun s ->
    try
        List.assoc s !provers_name
    with
        Not_found  -> failwith ("Failed to find `" ^ s ^ "`")

(* get why3 config *)
let config : Whyconf.config = Whyconf.read_config None

(* get the main config *)
let main : Whyconf.main = Whyconf.get_main config

(* get a prover from the config file *)
let prover : string -> Whyconf.config_prover = fun prover_name ->
    let fp = Whyconf.parse_filter_prover prover_name in
    let provers = Whyconf.filter_provers config fp in
    if Whyconf.Mprover.is_empty provers then
        failwith (prover_name ^ " is not installed or not configured@.")
    else
        snd (Whyconf.Mprover.max_binding provers)

let alt_ergo = prover "Alt-Ergo"

(* build an empty environment *)
let env : Env.env ref = ref (Env.create_env [])

(* init the environment *)
let init_env () =
    env := Env.create_env (Whyconf.loadpath main)

(* load a prover *)
let prover_driver : Whyconf.config_prover -> Driver.driver = fun cp ->
    try
        Whyconf.load_driver main !env cp.Whyconf.driver []
    with e ->
        Console.out 1 "Failed to load driver for alt-ergo: %a@."
    Exn_printer.exn_printer e;
    exit 1

(* calls a prover with a task *)
let rst : Whyconf.config_prover -> Task.task -> Call_provers.prover_result =
    fun prv tsk ->
        Call_provers.wait_on_call (Driver.prove_task
        ~limit:Call_provers.empty_limit
        ~command:prv.Whyconf.command (prover_driver prv) tsk)

(* print the prover answer *)
let test prv tsk = Console.out 2 "Prover's answer : %a@."
    Call_provers.print_prover_result (rst prv tsk)