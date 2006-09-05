<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="root">
    <xsl:apply-templates select="//nd">
      <xsl:sort select="."/>
    </xsl:apply-templates>
</xsl:template>
<xsl:template match="nd">
  <xsl:value-of select="."/><br/>
</xsl:template>
<xsl:template match="nd[position() != 1]">
</xsl:template>
</xsl:stylesheet>
