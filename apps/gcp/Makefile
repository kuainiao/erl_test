REBAR = ./rebar
DIALYZER = dialyzer

compile: 
	@$(REBAR) compile

clean:
	@$(REBAR) clean

dialyze: 
	@$(DIALYZER)   -pa ebin -I apps -I src  -I src/proto -r src  -r ebin -r -r apps/common apps/config -r apps/pangzi --fullpath $(DIALYZER_WARNINGS) 
