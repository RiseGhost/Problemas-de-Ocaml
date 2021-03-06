(*Trabalho realizado por:
-> Nome: José Miguel Alves Melo dos Santos   Número: 45968
-> Nome: Rúben José Dias Alves               Número: 46244
*)

let count = ref 0 (*-> Endereço de memória onde fica guadado o número de chamadas da função*) 
(*Calculo da sequência de Schroder utilizando a formula de baixo *)
let rec schroder x =
  count :=  !count + 1;
  if x = 0. || x = 1. then
    x +. 1.
  else
    ( ((6.*.x -. 3.) *. schroder (x -. 1.)) -. ((x -. 2.) *. schroder (x -. 2.) ) ) /. (x +. 1.)

(*Calculo da sequência de Schroder utilizando a formula de somatórios *)
let y =  ref 0 (*Endereço de memória utilizado como variável auxiliar para efetuar a soma*)
let rec schroder1 x = 
  y := 0;
  count := !count + 1;
  if x = 0 || x = 1 then
    x + 1
  else
    (for i = 1 to (x - 2) do
      y := schroder1 i * schroder1 (x-i-1) + !y
    done;
    3 * schroder1 (x-1) + !y)

open Z
open Scanf
let schroderaux = ref [Z.of_float 1.;Z.of_float 2.]

let b,a = Scanf.sscanf (read_line ()) " %d %d" (fun a b -> a,b)
let () = 
    (*Parte responsável por calculuar 0 < S < 10000*)
    for i = 0 to 10000 do
      schroderaux := ( ((Z.of_float 6. * Z.of_int i - Z.of_float 3.) * (List.nth !schroderaux 0)) - ((Z.of_int i - Z.of_float 2.) * (List.nth !schroderaux 1) ) ) / (Z.of_int i + Z.of_float 1.) :: !schroderaux;
    done;
    (*-------------------------------------------------------------------------------------------------*)
    print_int (schroder1 b);
    print_string (" ");
    print_int (!count);
    count := 0;
    print_newline ();
    print_int ( int_of_float ( schroder (float_of_int (b)) ) );
    print_string (" ");
    print_int (!count);
    print_newline ();
    print_string ( Z.to_string ( List.nth !schroderaux ( Z.to_int(Z.of_int 10000 - Z.of_int a) ) ) );
    print_newline ();
