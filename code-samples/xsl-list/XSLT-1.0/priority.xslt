<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:template match="/">
  <xsl:element name="sect1">
    <xsl:apply-templates select="sect1/para[not(starts-with(.,'* '))]" mode="normal"/>
  </xsl:element>
</xsl:template>
<xsl:template match="para" mode="normal">
<xsl:variable name="followingParagraph" select="following-sibling::para[not(starts-with(., '*'))][1]"/>
  <xsl:copy-of select="."/>
  <xsl:if test="following-sibling::para[1][starts-with(., '* ')]">
    <xsl:element name="itemizedlist">
      <xsl:apply-templates select="following-sibling::para[starts-with(.,'* ') and not(preceding-sibling::para = $followingParagraph)]" mode="buildList"/>
    </xsl:element>
  </xsl:if>
</xsl:template>
<xsl:template match="para" mode="buildList">
  <xsl:element name="listitem">
    <xsl:element name="para">
      <xsl:apply-templates select="text() | *"/>
    </xsl:element>
  </xsl:element>
</xsl:template>
<xsl:template match="text()[starts-with(., '* ')]">
  <xsl:value-of select="substring-after(., '* ')"/>
</xsl:template>
<xsl:template match="text() | *">
  <xsl:copy-of select="."/>
</xsl:template>
</xsl:stylesheet>
