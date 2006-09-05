<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="text"/>
<xsl:template match="/">
  <xsl:apply-templates select="foo/bar[8]"/>
</xsl:template>
<xsl:template match="bar">
  <xsl:value-of select="preceding-sibling::bar[3]"/>
</xsl:template>
</xsl:stylesheet>
