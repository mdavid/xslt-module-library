<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
                
<xsl:param name="filter" select="//person[contains(FName,'a') and LName='Brown']"/>

<xsl:template match="/">
	<xsl:apply-templates select="$filter"/>
</xsl:template>
<xsl:template match="person">
  <xsl:value-of select="LName"/>, <xsl:value-of select="FName"/>
</xsl:template>
</xsl:stylesheet>
