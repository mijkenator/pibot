-module(pibot_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

init(_Type, Req, []) ->
	{ok, Req, undefined}.

handle(Req, State) ->
    lager:debug("PH HANDLE: ~p ~p", [Req, State]),
	{Method, Req2} = cowboy_req:method(Req),
    lager:debug("PH HANDLE1: ~p", [Method]),
	HasBody = cowboy_req:has_body(Req2),
    lager:debug("PH HANDLE2: ~p", [HasBody]),
	{ok, Req3} = request_processor(Method, HasBody, Req2),
	{ok, Req3, State}.

request_processor(<<"POST">>, true, Req) ->
    try
        lager:debug("PH RP1-0", []),
        {ok, PostVals, Req2} = cowboy_req:body_qs(Req),
        lager:debug("PH RP1-1 ~p", [PostVals]),
        Request = proplists:get_value(<<"request">>, PostVals),
        {JSON} = jiffy:decode(Request),
        lager:debug("PH RP1-2 ~p", [JSON]),
        Command = proplists:get_value(<<"type">>, JSON),
        lager:debug("PH RP1-3 ~p", [Command]),
        reply(command_apply(Command, JSON), Req2)
    catch
        Error:Reason -> error_response(Error, Reason, Req)
    end;
request_processor(<<"POST">>, false, Req) ->
	cowboy_req:reply(400, [], <<"Missing body.">>, Req);
request_processor(_, _, Req) ->
	cowboy_req:reply(405, Req).%% Method not allowed.


reply(Response, Req) ->
	cowboy_req:reply(200, [
		{<<"content-type">>, <<"text/plain; charset=utf-8">>}
	], Response, Req).

terminate(Reason, _Req, _State) ->
    lager:debug("PH TERMINATE: ~p", [Reason]),
	ok.

command_apply(<<"move">> = Type, JSON) ->
    pi_commander:move(proplists:get_value(<<"direction">>, JSON)),
    jiffy:encode({[{<<"type">>, Type}, {<<"status">>, <<"ok">>}]});   
command_apply(_,_) -> <<"unknown command">>. 

%error_response(Error, {ErrorType, Reason}) ->
%    .........
%    ;
error_response(Error, Reason, Req) ->
    lager:error("PH RP error: ~p ~p", [Error, Reason]),
    reply(jiffy:encode({[{<<"type">>, <<"unknown">>}, {<<"status">>, <<"failed">>}, {<<"error">>, [666, <<"infernal server error">>]}]}), Req).


