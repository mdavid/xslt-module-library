<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:exslt="http://exslt.org/common" 
		version="1.0">
<xsl:output method="xml"/>
<xsl:template match="/">
<xsl:variable name="conversion" select="translate(content/ubb, '[]', '&lt;>')"/>
<xsl:variable name="processedInput">
	<xsl:value-of select="$conversion" disable-output-escaping="yes"/>
</xsl:variable>
<xsl:variable name="processedInput2Nodeset" select="exslt:node-set($processedInput)"/>
<xsl:apply-templates select="$processedInput2Nodeset"/>
</xsl:template>
<xsl:template match="*">
	hello
	<xsl:apply-templates/>
</xsl:template>
</xsl:stylesheet>
