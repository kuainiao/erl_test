%% @author 余健
%% @doc httpclient

-module(spider_http).

-include( "spider.hrl" ).

-export([get_html/2, get_html/1]).

-define( TIMEOUT, 30000 ).

get_html( Url, FileName ) ->
	timer:sleep(1000),
	HtmlStr = 
		case mnesia:dirty_read(spider_url, Url) of
			[] ->
                case get_html( Url ) of
                    {ok, Html} ->
						case html_write( Url, Html,  FileName ) of
							{error, _Other} ->"<html></html>";
							File_Doc ->	
                        		SpiderVO = #spider_url{ url = Url, filePath = File_Doc },
								mnesia:dirty_write(SpiderVO),
                        		Html
						end;
                    {error, _Other} ->
                        "<html></html>"
                end;
            [SpiderVO] ->
               FilePath = SpiderVO#spider_url.filePath,
                case read_file( FilePath ) of
                    {error, _} ->
                        "<html></html>";
                    Html2 -> Html2
                end
		end,    
    try mochiweb_html:parse( HtmlStr ) of
        [] -> {<<"html">>, [], [<<>>]};                
        Html_xml -> Html_xml
    catch
        _:_Why -> {<<"html">>, [], [<<>>]}
    end.


get_html( Url ) ->
	case httpc:request(get, { Url, [{"Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"}, {"User-Agent", "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.154 Safari/537.36"}]}, [], [] ) of
	    {ok,{{"HTTP/1.1",200,"OK"}, _Head, HtmlStr}} ->
	        {ok, HtmlStr};
	    Other ->
	        {error, Other}
	end.

-define( FILEPATH, spider_init:get_path("../doc/html/") ).
html_write( Url, Html, FileName ) ->
	FilePath = ?FILEPATH++FileName,
    case file:list_dir(FilePath) of
        {ok, _Filelist} ->
			NewFileName = case Url of
				"http://www.zhihu.com/topic"++R ->
					string:join(string:tokens( R, "/?=" ), "_")++".htm";
				"http://www.zhihu.com/question/"++Num ->
					Num++".htm"
			end,
            NewFilePath =  FilePath++"/"++NewFileName,
			case file:open( NewFilePath, [write, {encoding, utf8}] ) of
		        {ok, S} ->
		            io:format( S, "~p.~n", [ Html ]),
		            file:close( S ),
		            NewFilePath;
		        {error, Other} ->
		            {error, Other}
		    end;
        _Other ->
            file:make_dir( FilePath ),
            html_write( Url, Html, FileName )
    end.

read_file( FilePath ) ->
    case file:consult( FilePath ) of
        {ok, [FileConent]} -> FileConent;
        Other -> Other
    end.
