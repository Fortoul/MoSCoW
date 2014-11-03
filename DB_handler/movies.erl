-module(movies).
-export([releases/2, id/1, url/1]).

-define(API_KEY, "XXXXXXXXXXXXXXXX")

releases(From, To) ->
	Api_Key = "&api_key=" ++ ?API_KEY ++ "&page=1",
	Filter = "https://api.themoviedb.org/3/discover",
	Type = "/movie",
	ReleaseDateFrom = "?primary_release_date.gte=" ++ From,
	ReleaseDateTo = "&primary_release_date.lte=" ++ To,
	Sort = "&sort_by=popularity.desc",
	Url = Filter ++ Type ++ ReleaseDateFrom ++ ReleaseDateTo ++ Sort ++ Api_Key,
	inets:start(),
	ssl:start(),
	
	% Pattern {ok, {{Version, 200, ReasonPhrase}, Headers, Body}}
	{ok, {{_, 200, _}, _, Body}} = httpc:request(get, {Url, []}, [], []),
	Body.

id(Id) ->
	Url = "https://api.themoviedb.org/3/movie/" ++ Id ++ "?api_key=" ++ ?API_KEY,
	inets:start(),
	ssl:start(),
	{ok, {{_, 200, _}, _, Body}} = httpc:request(get, {Url, []}, [], []),
	Body.

url(Url) ->
	inets:start(),
	ssl:start(),
	{ok, {{_, 200, _}, _, Body}} = httpc:request(get, {Url, []}, [], []),
	Body.
