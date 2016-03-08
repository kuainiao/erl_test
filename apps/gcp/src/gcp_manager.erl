-module( gcp_manager ).

-export([insert/1, insert/2, update/2, delete/2, lookup/2]).

insert(Record) ->
	mnesia:dirty_write(Record),
	element(2, Record).

insert(Tab, Record) ->
	mnesia:dirty_write(Tab, Record),
	element(2, Record).

update(Tab, Record) ->
	mnesia:dirty_write(Tab, Record).

delete(Tab, Id) ->
	mnesia:dirty_delete(Tab, Id).

lookup(Tab, Id) ->
	mnesia:dirty_read(Tab, Id).