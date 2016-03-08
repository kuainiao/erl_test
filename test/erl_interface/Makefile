

erl_interface:
	gcc -o extprg complex.c erl_comm.c example1_driver.c

##erl
##c(complex1).
##l(complex1).
##complex1:start("extprg").
##complex1:bar(2).
##complex1:foo(1).


erl_port:
	gcc -o example_drv -fpic -shared complex.c port_driver.c

##erl
##c(complex5).
##l(complex5).
##complex5:start("extprg").
##complex5:bar(2).
##complex5:foo(1).
