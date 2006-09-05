<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="links">
  <xsl:apply-templates select="link"/>
</xsl:template>
<xsl:template match="link">
  <xsl:element name="a">
    <xsl:copy-of select="@*"/>
    <xsl:value-of select="."/>
  </xsl:element>
</xsl:template>
</xsl:stylesheet>
