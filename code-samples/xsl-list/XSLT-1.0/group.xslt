<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="yes"/>
<xsl:template match="/">
  <xsl:element name="hst_list_equals_ort_nr">
  <xsl:apply-templates select="lines/hst_list">
    <xsl:with-param name="ort" select="lines/orte/ort"/>
  </xsl:apply-templates>
  </xsl:element>
</xsl:template>
<xsl:template match="hst_list">
<xsl:param name="ort"/>
<xsl:variable name="match_hst_to_ort_nr" select="."/>
  <xsl:apply-templates select="$ort/ort_nr[. = $match_hst_to_ort_nr]"/>
</xsl:template>
<xsl:template match="ort_nr">
  hello
</xsl:template>
</xsl:stylesheet>
