%%%-------------------------------------------------------------------
%%% @author Ivan Carmenates Garcia
%%% @copyright (C) 2015, Ivanco Software Corporation
%%% @doc
%%% simple_one_to_one template that supervises multiple backend pools.
%%% @end
%%% Created : 16. Aug 2015 1:31 AM
%%%-------------------------------------------------------------------
-module(connection_pool_sup).
-author("Ivan Carmenates Garcia").

-behaviour(supervisor).

%% Supervisor callbacks
-export([init/1]).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Whenever a supervisor is started using supervisor:start_link/[2,3],
%% this function is called by the new process to find out about
%% restart strategy, maximum restart frequency and child
%% specifications.
%%
%% @end
%%--------------------------------------------------------------------
-spec init(Args :: term()) ->
    {ok, {SupFlags :: {RestartStrategy :: supervisor:strategy(),
        MaxR :: non_neg_integer(), MaxT :: non_neg_integer()},
        [ChildSpec :: supervisor:child_spec()]
    }} |
    ignore |
    {error, Reason :: term()}.
init([]) ->
    {ok, {{simple_one_for_one, 10, 10}, [
        {ce_connection_pool,
            {connection_pool, start_link, []},
            permanent,
            10000,
            worker,
            [connection_pool]
        }]}}.