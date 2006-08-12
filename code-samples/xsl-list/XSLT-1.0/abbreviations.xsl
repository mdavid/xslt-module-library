<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
    <abbreviations>
      <xsl:apply-templates select="abbreviations/template">
        <xsl:sort select="@key-sequence"/>
      </xsl:apply-templates>
    </abbreviations>
  </xsl:template>

  <xsl:template match="template">
    <template>
      <xsl:copy-of select="@*"/>
      <xsl:text disable-output-escaping="yes">
      &lt;![CDATA[
      </xsl:text>
      <xsl:value-of select="normalize-space(text())" disable-output-escaping="yes"/>
      <xsl:text disable-output-escaping="yes">
      ]]&gt;
      </xsl:text>
    </template>
  </xsl:template>
</xsl:stylesheet>
