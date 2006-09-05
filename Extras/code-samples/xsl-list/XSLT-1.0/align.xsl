<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
  <xsl:apply-templates select="form-data/form"/>
</xsl:template>
<xsl:template match="form">
  <div>
    <xsl:apply-templates select="field"/>
  </div>
</xsl:template>
<xsl:template match="field">
<xsl:variable name="opposite-float">
<xsl:choose>
  <xsl:when test="@align = 'left'">
    <xsl:text>right</xsl:text>
  </xsl:when>
  <xsl:otherwise>
    <xsl:text>left</xsl:text>
  </xsl:otherwise>
</xsl:choose>
</xsl:variable>
  <div style="clear:both">
    <div style="float:{$opposite-float}">
      <img href="{@image}" style="width:{@image-width}; height:{@image-height}" />
    </div>
    <div style="float:{@align}">
      <xsl:value-of select="@value"/>
    </div>
  </div>
</xsl:template>
</xsl:stylesheet>
