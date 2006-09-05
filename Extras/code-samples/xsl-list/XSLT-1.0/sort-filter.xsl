<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
  <xsl:apply-templates select="Documents/Document[@filter = 'food' or @filter = '']">
    <xsl:sort select="@title"/>
  </xsl:apply-templates>
  </xsl:template>
  <xsl:template match="Document">
    <xsl:copy>
      <xsl:element name="local-name()">
        <xsl:copy-of select="@* | Article[@filter = 'food']"/>
      </xsl:element>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
