<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" omit-xml-declaration="yes" encoding="US-ASCII"/>
	<xsl:template match="xfsm">
		<xsl:text>digraph </xsl:text>
		<xsl:value-of select="/xfsm/@name"/>
		<xsl:text>
{ 
	graph[fontname="Arial" splines=true overlap=false ranksep=2 nodesep=2] 
	node[fontname="Arial" shape=box height=1 width=2 style="rounded, bold, filled"] 
	edge[fontname="Arial" style="bold"] 
	subgraph cluster0 
	{
		label = "</xsl:text>
		<xsl:value-of select="/xfsm/@name"/>
		<xsl:text>";	
	</xsl:text>
		<xsl:for-each select="states/state">
			<xsl:value-of select="@name"/>
			<xsl:text> [ label="</xsl:text>
			<xsl:value-of select="@name"/>
			<xsl:text>\n</xsl:text>
			<xsl:if test="@on_enter">
				<xsl:text>\nentry / </xsl:text>
				<xsl:value-of select="@on_enter"/>
			</xsl:if>
			<xsl:if test="@on_leave">
				<xsl:text>\nexit / </xsl:text>
				<xsl:value-of select="@on_leave"/>
			</xsl:if>
			<xsl:text>" ];
	</xsl:text>
		</xsl:for-each>
		<xsl:text>
	</xsl:text>
		<xsl:for-each select="states/state">
			<xsl:variable name="state_name">
				<xsl:value-of select="@name"/>
			</xsl:variable>
			<xsl:for-each select="/xfsm/use_cases/use_case/case[@in=$state_name]">
				<xsl:value-of select="$state_name"/>
				<xsl:text> -> </xsl:text>
				<xsl:choose>
					<xsl:when test="@to">
						<xsl:value-of select="@to"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$state_name"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>[label="</xsl:text>
				<xsl:value-of select="@on"/>
				<xsl:if test="@do">
					<xsl:text> /\n</xsl:text>
					<xsl:value-of select="@do"/>
				</xsl:if>
				<xsl:text>"];
		</xsl:text>
			</xsl:for-each>
		</xsl:for-each>
		<xsl:text>
	}
}
		</xsl:text>
	</xsl:template>
</xsl:stylesheet>