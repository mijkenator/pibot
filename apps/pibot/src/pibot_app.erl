-module(pibot_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/", pibot_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_http(http, 10, [{port, 2345}], [
        {env, [{dispatch, Dispatch}]}
    ]),
    ex_reloader:start(),
    pibot_sup:start_link().

stop(_State) ->
    ok.
