<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
  <xsl:call-template name="bottles_of_beer">
    <xsl:with-param name="bottles" select="'99'"/>
  </xsl:call-template>
</xsl:template>
<xsl:template name="bottles_of_beer">
<xsl:param name="bottles"/>
<xsl:variable name="ps_bottle">bottle<xsl:if test="$bottles != 1">s</xsl:if></xsl:variable>
  <xsl:value-of select="concat($bottles, ' ', $ps_bottle)"/> of beer on the wall.
  <xsl:value-of select="concat($bottles, ' ', $ps_bottle)"/> of beer.
  Take one down, pass it around, <xsl:value-of select="$bottles - 1"/> bottles of beer on the wall.
  <xsl:if test="$bottles &gt; 1">
    <xsl:call-template name="bottles_of_beer">
      <xsl:with-param name="bottles" select="$bottles - 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>
</xsl:stylesheet>
