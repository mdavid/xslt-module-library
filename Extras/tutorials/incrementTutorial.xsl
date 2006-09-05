<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/>
<xsl:template match="/">
  <xsl:call-template name="incrementValue">
    <xsl:with-param name="value">1</xsl:with-param>
  </xsl:call-template>
</xsl:template>
<xsl:template name="incrementValue">
  <xsl:param name="value"/>
    <xsl:if test="$value &lt;= 10">
      <xsl:value-of select="$value"/>
      <xsl:call-template name="incrementValue">
        <xsl:with-param name="value" select="$value + 1"/>
      </xsl:call-template>
    </xsl:if>
</xsl:template>
</xsl:stylesheet>
