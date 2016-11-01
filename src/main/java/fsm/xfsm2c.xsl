<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" omit-xml-declaration="yes" encoding="US-ASCII"/>
	<xsl:variable name="file_prefix">
		<xsl:value-of select="/xfsm/@name"/>
	</xsl:variable>
	<xsl:variable name="event_prefix">
		<xsl:value-of select="/xfsm/events/@prefix"/>
	</xsl:variable>
	<xsl:variable name="action_prefix">
		<xsl:value-of select="/xfsm/actions/@prefix"/>
	</xsl:variable>
	<xsl:variable name="state_prefix">
		<xsl:value-of select="/xfsm/states/@prefix"/>
	</xsl:variable>
	<xsl:variable name="event_type">
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_event_t </xsl:text>
	</xsl:variable>
	<xsl:variable name="action_type">
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_action_t </xsl:text>
	</xsl:variable>
	<xsl:variable name="state_type">
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_state_t </xsl:text>
	</xsl:variable>
	<xsl:template match="xfsm">
		<p title="File intro">
			<xsl:text>
// Name: </xsl:text>
			<xsl:value-of select="$file_prefix"/>
			<xsl:text>.cpp
// Date: </xsl:text>
			<xsl:value-of select="@date"/>
			<xsl:text>
// Sign: </xsl:text>
			<xsl:value-of select="@sign"/>
			<xsl:text>

#include "tp_external.h"
#include "</xsl:text>
			<xsl:value-of select="$file_prefix"/>
			<xsl:text>.h"
			
//=========================================================================
// Local Data
//=========================================================================

static int nMyTraceLevel = 1;
		
</xsl:text>
		</p>
		<p title="Local Procedures">
			<xsl:text>
//=========================================================================
// Procedures used for Tracing
//=========================================================================

#define RETURN_STRING( CASE ) case CASE: return #CASE;
</xsl:text>
			<p title="Event2String">
				<xsl:text>
extern const char* </xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_Event2String(</xsl:text>
				<xsl:value-of select="$event_type"/>
				<xsl:text>nEvent) {
	switch (nEvent) {
		RETURN_STRING(</xsl:text>
				<xsl:value-of select="$event_prefix"/>
				<xsl:text>Void)
		</xsl:text>
				<xsl:for-each select="events/event">
					<xsl:text>RETURN_STRING(</xsl:text>
					<xsl:value-of select="$event_prefix"/>
					<xsl:value-of select="@name"/>
					<xsl:text>)
		</xsl:text>
				</xsl:for-each>
				<xsl:text>RETURN_STRING(</xsl:text>
				<xsl:value-of select="$event_prefix"/>
				<xsl:text>Max) 
	} 
	return "Error:</xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>IllegalEvent";
}
</xsl:text>
			</p>
			<p title="Action2String">
				<xsl:text>
extern const char* </xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_Action2String(</xsl:text>
				<xsl:value-of select="$action_type"/>
				<xsl:text>nAction) { 
	switch (nAction) { 
		RETURN_STRING(</xsl:text>
				<xsl:value-of select="$action_prefix"/>
				<xsl:text>Void)
		</xsl:text>
				<xsl:for-each select="actions/action">
					<xsl:text>RETURN_STRING(</xsl:text>
					<xsl:value-of select="$action_prefix"/>
					<xsl:value-of select="@name"/>
					<xsl:text>)
		</xsl:text>
				</xsl:for-each>
				<xsl:text>RETURN_STRING(</xsl:text>
				<xsl:value-of select="$action_prefix"/>
				<xsl:text>Max)
	}
	return "Error:</xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>IllegalAction"; 
}
</xsl:text>
			</p>
			<p title="State2String">
				<xsl:text>
extern const char*</xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_State2String(</xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:text>nState) { 
	switch (nState) { 
		RETURN_STRING(</xsl:text>
				<xsl:value-of select="$state_prefix"/>
				<xsl:text>Void)
		</xsl:text>
				<xsl:for-each select="states/state">
					<xsl:text>RETURN_STRING(</xsl:text>
					<xsl:value-of select="$state_prefix"/>
					<xsl:value-of select="@name"/>
					<xsl:text>)
		</xsl:text>
				</xsl:for-each>
				<xsl:text>RETURN_STRING(</xsl:text>
				<xsl:value-of select="$state_prefix"/>
				<xsl:text>Max)
	}
	return "Error:</xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>IllegalState";
}
</xsl:text>
			</p>
			<p title="TraceEvent">
				<xsl:text>
static void TraceEvent(</xsl:text>
				<xsl:value-of select="$event_type"/>
				<xsl:text>nOnEvent,</xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:text>nInState,</xsl:text>
				<xsl:value-of select="$action_type"/>
				<xsl:text>nDoAction,</xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:text>nToState) {
	if((</xsl:text>
				<xsl:value-of select="$action_prefix"/>
				<xsl:text>Void != nDoAction)||(nInState != nToState)){
		tdprintf("%s: %s",</xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_State2String(nInState), </xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_Event2String(nOnEvent));
		if (</xsl:text>
				<xsl:value-of select="$action_prefix"/>
				<xsl:text>Void != nDoAction) { 
			xprintf(" [%s]", </xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_Action2String(nDoAction)); 
		} 
		if (nInState != nToState) { 
			xprintf(" => %s", </xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_State2String(nToState)); }
			xprintf("\n"); 
	}
}
</xsl:text>
			</p>
			<p title="FsmLookup">
				<xsl:text>	
//=========================================================================
// Local Procedures used to implement the State Machine
//=========================================================================

</xsl:text>
				<xsl:text>
static void FsmLookup(</xsl:text>
				<xsl:value-of select="$event_type"/>
				<xsl:text>nOnEvent,</xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:text>nInState,</xsl:text>
				<xsl:value-of select="$action_type"/>
				<xsl:text>* pDoAction,</xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:text>* pToState) {
	switch (nInState) {
		</xsl:text>
				<xsl:for-each select="states/state">
					<xsl:variable name="state_name">
						<xsl:value-of select="@name"/>
					</xsl:variable>
					<xsl:variable name="state">
						<xsl:value-of select="$state_prefix"/>
						<xsl:value-of select="@name"/>
					</xsl:variable>
					<xsl:text>
//=========================================================================
		case </xsl:text>
					<xsl:value-of select="$state"/>
					<xsl:text>:
			switch (nOnEvent) {
			</xsl:text>
					<xsl:if test="@on_enter">
						<p>
							<xsl:text>case </xsl:text>
							<xsl:value-of select="$event_prefix"/>
							<xsl:text>EnterState: *pDoAction = </xsl:text>
							<xsl:value-of select="$action_prefix"/>
							<xsl:value-of select="@on_enter"/>
							<xsl:text>; *pToState = nInState; return;
			</xsl:text>
						</p>
					</xsl:if>
					<xsl:if test="@on_leave">
						<p>
							<xsl:text>case </xsl:text>
							<xsl:value-of select="$event_prefix"/>
							<xsl:text>LeaveState: *pDoAction = </xsl:text>
							<xsl:value-of select="$action_prefix"/>
							<xsl:value-of select="@on_leave"/>
							<xsl:text>; *pToState = nInState; return;
			</xsl:text>
						</p>
					</xsl:if>
					<xsl:for-each select="/xfsm/use_cases/use_case/case[@in=$state_name]">
						<p>
							<xsl:text>case </xsl:text>
							<xsl:value-of select="$event_prefix"/>
							<xsl:value-of select="@on"/>
							<xsl:text>: *pDoAction =</xsl:text>
							<xsl:choose>
								<xsl:when test="@do">
									<xsl:value-of select="$action_prefix"/>
									<xsl:value-of select="@do"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$action_prefix"/>
									<xsl:text>Void</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>; *pToState =</xsl:text>
							<xsl:choose>
								<xsl:when test="@to">
									<xsl:value-of select="$state_prefix"/>
									<xsl:value-of select="@to"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="$state"/>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:text>; return;
			</xsl:text>
						</p>
					</xsl:for-each>
					<xsl:text>default:;
			} 
			break;
	</xsl:text>
				</xsl:for-each>
				<xsl:text>			
//=========================================================================
		default:;
	}
	</xsl:text>
				<xsl:text>		
//==== Use any event specific default action ==============================					
	*pToState = nInState;
	switch (nOnEvent) {
		</xsl:text>
				<xsl:for-each select="/xfsm/events">
					<xsl:if test="@default_action">
						<xsl:variable name="default_action">
							<xsl:value-of select="$action_prefix"/>
							<xsl:value-of select="@default_action"/>
						</xsl:variable>
						<xsl:for-each select="event">
							<xsl:text>case </xsl:text>
							<xsl:value-of select="$event_prefix"/>
							<xsl:value-of select="@name"/>
							<xsl:text>: *pDoAction = </xsl:text>
							<xsl:value-of select="$default_action"/>
							<xsl:text>; return;
		</xsl:text>
						</xsl:for-each>
					</xsl:if>
				</xsl:for-each>
				<xsl:text>default:;
		}</xsl:text>
				<xsl:text>
		
//==== Use default action - ie. no action ================================					
	*pDoAction =</xsl:text>
				<xsl:value-of select="$action_prefix"/>
				<xsl:text>Void;
}

	</xsl:text>
			</p>
		</p>
		<p title="Exported Procedures">
			<xsl:text>
		
//=========================================================================
// Exported Procedures
//=========================================================================

</xsl:text>
			<p title="Initialize">
				<xsl:text>
extern </xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_Initialize(){
	return </xsl:text>
				<xsl:value-of select="$state_prefix"/>
				<xsl:text>Start;
}</xsl:text>
			</p>
			<p title="SetTraceLevel">
				<xsl:text>
extern void </xsl:text>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_SetTraceLevel(int nLevel){
	nMyTraceLevel = nLevel;
}</xsl:text>
			</p>
			<p title="OnEvent">
				<xsl:text>
extern </xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:value-of select="$file_prefix"/>
				<xsl:text>_OnEvent(</xsl:text>
				<xsl:value-of select="$event_type"/>
				<xsl:text>nOnEvent, </xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:text>nInState, </xsl:text>
				<xsl:value-of select="$action_type"/>
				<xsl:text>*pDoAction){
	</xsl:text>
				<xsl:value-of select="$action_type"/>
				<xsl:text>nDoAction = </xsl:text>
				<xsl:value-of select="$action_prefix"/>
				<xsl:text>Void;
	</xsl:text>
				<xsl:value-of select="$state_type"/>
				<xsl:text>nToState = nInState; 
	FsmLookup(nOnEvent, nInState, &amp;nDoAction, &amp;nToState); 
	if (nMyTraceLevel) { 
		TraceEvent(nOnEvent, nInState, nDoAction, nToState); 
	}
	*pDoAction = nDoAction; 
	return nToState; 
} 
				</xsl:text>
			</p>
		</p>
	</xsl:template>
</xsl:stylesheet>