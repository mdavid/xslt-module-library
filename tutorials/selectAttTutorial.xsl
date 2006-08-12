<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:template match="/">
  <xsl:apply-templates select="select"/>
</xsl:template>
<xsl:template match="select">
  <xsl:element name="select">
    <xsl:apply-templates select="option"/>
  </xsl:element>
</xsl:template>
<xsl:template match="option[@selected]">
  <xsl:element name="option">
    <xsl:attribute name="selected">true</xsl:attribute>
    <xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
    <xsl:value-of select="."/>
  </xsl:element>
</xsl:template>
<xsl:template match="option[not(@selected)]">
  <xsl:element name="option">
    <xsl:attribute name="value"><xsl:value-of select="@value"/></xsl:attribute>
    <xsl:value-of select="."/>
  </xsl:element>
</xsl:template>
</xsl:stylesheet>
