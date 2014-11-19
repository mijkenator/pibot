-module(pibot_sup).

-behaviour(supervisor).

%% API
-export([start_link/0, start_link/1]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

start_link(ExtProg) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, ExtProg).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init(ExtProg) ->
    {ok, { {one_for_one, 5, 10}, [
            {robot_port_gs, {robot_port_gs, start_link, [ExtProg]}, permanent, 10, worker, [robot_port_gs]}
    ]} }.

