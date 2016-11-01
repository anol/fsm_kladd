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
			
#ifndef </xsl:text>
			<xsl:value-of select="$file_prefix"/>
			<xsl:text>_H_
#define </xsl:text>
			<xsl:value-of select="$file_prefix"/>
			<xsl:text>_H_
</xsl:text>
		</p>
		<p title="Events">
			<xsl:text>
typedef enum {
	</xsl:text>
			<xsl:variable name="event_prefix">
				<xsl:value-of select="events/@prefix"/>
			</xsl:variable>
			<xsl:value-of select="$event_prefix"/>
			<xsl:text>Void=0,
	</xsl:text>
			<xsl:for-each select="events/event">
				<xsl:value-of select="$event_prefix"/>
				<xsl:value-of select="@name"/>
				<xsl:text>,
	</xsl:text>
			</xsl:for-each>
			<xsl:value-of select="$event_prefix"/>
			<xsl:text>Max
}</xsl:text>
			<xsl:value-of select="$event_type"/>
			<xsl:text>;
</xsl:text>
		</p>
		<p title="Actions">
			<xsl:text>
typedef enum {
	</xsl:text>
			<xsl:variable name="action_prefix">
				<xsl:value-of select="actions/@prefix"/>
			</xsl:variable>
			<xsl:value-of select="$action_prefix"/>
			<xsl:text>Void=0,
	</xsl:text>
			<xsl:for-each select="actions/action">
				<xsl:value-of select="$action_prefix"/>
				<xsl:value-of select="@name"/>
				<xsl:text>,
	</xsl:text>
			</xsl:for-each>
			<xsl:value-of select="$action_prefix"/>
			<xsl:text>Max
}</xsl:text>
			<xsl:value-of select="$action_type"/>
			<xsl:text>;
</xsl:text>
		</p>
		<p title="States">
			<xsl:text>
typedef enum {
	</xsl:text>
			<xsl:variable name="state_prefix">
				<xsl:value-of select="states/@prefix"/>
			</xsl:variable>
			<xsl:value-of select="$state_prefix"/>
			<xsl:text>Void=0,
	</xsl:text>
			<xsl:for-each select="states/state">
				<xsl:value-of select="$state_prefix"/>
				<xsl:value-of select="@name"/>
				<xsl:text>,
	</xsl:text>
			</xsl:for-each>
			<xsl:value-of select="$state_prefix"/>
			<xsl:text>Max
}</xsl:text>
			<xsl:value-of select="$state_type"/>
			<xsl:text>;
</xsl:text>
		</p>
		<xsl:text>
extern </xsl:text>
		<xsl:value-of select="$state_type"/>
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_Initialize();</xsl:text>
		<xsl:text>
extern void </xsl:text>
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_SetTraceLevel(int nLevel);</xsl:text>
		<xsl:text>
extern const char* </xsl:text>
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_Event2String(</xsl:text>
		<xsl:value-of select="$event_type"/>
		<xsl:text> nEvent);</xsl:text>
		<xsl:text>
extern const char* </xsl:text>
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_Action2String(</xsl:text>
		<xsl:value-of select="$action_type"/>
		<xsl:text> nAction);</xsl:text>
		<xsl:text>
extern const char* </xsl:text>
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_State2String(</xsl:text>
		<xsl:value-of select="$state_type"/>
		<xsl:text> nState);</xsl:text>
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
		<xsl:text>*pDoAction);</xsl:text>
		<xsl:text>
		
#endif /* </xsl:text>
		<xsl:value-of select="$file_prefix"/>
		<xsl:text>_H_ */
</xsl:text>
	</xsl:template>
</xsl:stylesheet>