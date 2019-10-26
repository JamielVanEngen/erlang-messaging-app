-module(messaging_server).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2]).


init([]) -> {ok, []}.

search_user(_, []) ->
    notfound;
search_user(User, [CurrentUser|Rest]) ->
    if User =:= CurrentUser ->
        User;
    User =/= CurrentUser ->
        search_user(User, Rest)
end.

handle_call({message, Message, Receiver}, _From, Users) ->
    search_user(Receiver, Users),
    {reply, ok}.

handle_cast({subscribe, Username}, Users) ->
    {noreply, Username, Users}.