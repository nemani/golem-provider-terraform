The terraform files in this repo can be used to setup multiple nodes + promethesus server using a startup script.
the first node will run the prom server as well as the first node. 
all other nodes will connect to the first server and push metrics to the running prom pushgate service.
