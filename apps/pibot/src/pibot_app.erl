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
            {"/api/[...]", pibot_handler, []}
            ,{"/[...]", cowboy_static, {dir, "../../priv_dir/html", [{mimetypes, cow_mimetypes, all}]}}
        ]}
    ]),
    {ok, _} = cowboy:start_http(http, 50, [{port, 2345}], [
        {env, [{dispatch, Dispatch}]}
    ]),
    ex_reloader:start(),
    PrivDir = code:priv_dir(pibot),
    {ok, ExtProg} = application:get_env(pibot, extprog),
    pibot_sup:start_link(filename:join([PrivDir, ExtProg])).
    %pibot_sup:start_link().

stop(_State) ->
    ok.
