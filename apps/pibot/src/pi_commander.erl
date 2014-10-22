-module(pi_commander).

-include_lib("../../deps/erlang-brickpi/include/brickpi.hrl").
-export([
    start/0,
    move/1
]).

start() ->
    brickpi:start(),
    brickpi:set_motor_enable(?PORT_A,1),
    brickpi:set_motor_enable(?PORT_B,1).


move(<<"s">>)   -> 
    brickpi:set_motor_speed(?PORT_A, 0),
    brickpi:set_motor_speed(?PORT_B, 0),
    brickpi:update();
move(<<"l">>)   -> ok;
move(<<"r">>)   -> ok;
move(<<"fwd">>) -> 
    brickpi:set_motor_speed(?PORT_A,-200),
    brickpi:set_motor_speed(?PORT_B,-200),
    brickpi:update();
move(<<"bwd">>) ->
    brickpi:set_motor_speed(?PORT_A, 200),
    brickpi:set_motor_speed(?PORT_B, 200),
    brickpi:update();
move(_) -> ok.
