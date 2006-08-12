<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="X">4</xsl:variable>
<xsl:variable name="Y">3</xsl:variable>

<xsl:template match="/">
	<xsl:apply-templates select="A/B"/>
</xsl:template>

<xsl:template match="B">
<xsl:variable name="X">
	<xsl:choose>
		<xsl:when test="@variable_X">
			<xsl:value-of select="@variable_X"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$X"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:variable>
	This is the value of X * Y for element B: <xsl:value-of select="$X * $Y"/><br/>
	<xsl:apply-templates>
		<xsl:with-param name="X" select="$X"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="A">
<xsl:param name="X" select="$X"/>
	This is the value of X + Y for element A: <xsl:value-of select="$X + $Y"/><br/>
	<xsl:apply-templates>
		<xsl:with-param name="X" select="$X"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="C">
<xsl:param name="X" select="$X"/>
	This is the value of X - Y for element C: <xsl:value-of select="$X - $Y"/><br/>
</xsl:template>

</xsl:stylesheet>
