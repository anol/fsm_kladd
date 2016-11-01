digraph ebax
{ 
	graph[fontname="Arial" splines=true overlap=false ranksep=2 nodesep=2] 
	node[fontname="Arial" shape=box height=1 width=2 style="rounded, bold, filled"] 
	edge[fontname="Arial" style="bold"] 
	subgraph cluster0 
	{
		label = "ebax";	
	Start [ label="Start\n" ];
	Inhibit [ label="Inhibit\n\nentry / Stop" ];
	Ready [ label="Ready\n\nentry / Confirm" ];
	Extending [ label="Extending\n\nentry / StartExtendTimer" ];
	Retracting [ label="Retracting\n\nentry / StartRetractTimer" ];
	MaxExtended [ label="MaxExtended\n\nentry / StartMaxExtendedTimer" ];
	
	Start -> Ready[label="SafetyAllow"];
		Inhibit -> Ready[label="SafetyAllow"];
		Ready -> Inhibit[label="SafetyInhibit"];
		Ready -> Retracting[label="RequestHome /\nRetract"];
		Ready -> Extending[label="RequestCompaction /\nExtend"];
		Extending -> Inhibit[label="SafetyInhibit"];
		Extending -> MaxExtended[label="ExtendTimerExpired /\nStop"];
		Retracting -> Inhibit[label="SafetyInhibit"];
		Retracting -> Ready[label="RetractTimerExpired /\nStop"];
		MaxExtended -> Retracting[label="MaxExtendedTimerExpired /\nRetract"];
		
	}
}
		