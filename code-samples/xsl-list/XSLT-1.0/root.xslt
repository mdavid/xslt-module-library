<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
  <xsl:apply-templates select="test/foo"/>
</xsl:template>
<xsl:template match="foo">
  hello
  <xsl:apply-templates select="/test/bar"/>
</xsl:template>
<xsl:template match="bar">
  it works
</xsl:template>
</xsl:stylesheet>
