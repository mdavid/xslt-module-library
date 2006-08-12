<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
  <xsl:apply-templates select="test/*"/>
</xsl:template>
<xsl:template match="c">
  <xsl:element name="doc">
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>
<xsl:template match="a">
  <xsl:element name="b">
    <xsl:value-of select="@cref"/>
  </xsl:element>
</xsl:template>
<xsl:template match="x">
  <xsl:element name="i">
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>
<xsl:template match="d"/>
</xsl:stylesheet>
