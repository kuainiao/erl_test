
make:
	./rebar co
	#gcc -fPIC -shared -I /usr/local/lib/erlang/usr/include/ -o priv/leofs_magick.so c_src/magick/leofs_magick.c -O  `GraphicsMagickWand-config --cppflags --ldflags --libs`
	#g++ -fPIC -shared -I /usr/local/lib/erlang/usr/include/ -o priv/leofs_magick.so c_src/magick/leofs_magick.cpp -O  `GraphicsMagick++-config --cppflags --ldflags --libs`
	#gcc -fPIC -shared -I /usr/local/lib/erlang/usr/include/ -o priv/leofs_magick.so c_src/magick/leofs_magick_1.c -O  `GraphicsMagick-config --cppflags --ldflags --libs`

release:
	rm -rf rel/erl_test;
	cd rel && ../rebar generate;

get-deps:
	./rebar get-deps


st:
	erl +K true +pc unicode -pa ebin/ deps/*/ebin/ -s erl_app #leofs_magick_test
	#erl -pa ebin +K true +A 10 +sbt db +sbwt very_long +swt very_low +Mulmbcs 32767 +Mumbcgs 1 +Musmbcs 2047


cl:
	./rebar cl;


IP=192.168.1.101

config:
	cd deps/recon_web && make config IP=$(IP) PORT=8031;
	sed -i 's/127.0.0.1/$(IP)/' priv/docroot/index.html