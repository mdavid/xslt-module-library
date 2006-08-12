<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:strip-space elements="*"/>
<!-- this element tells the processor to strip the excess white space out of the results so that our output doesnt include all of the tabs and extra white space that tends to exist in the XML file -->
<xsl:output method="html"/>
<xsl:template match="html">
Table of Contents: <br/>
 <xsl:element name="ol">
  <xsl:apply-templates select="//h1" mode="toc"/>
 </xsl:element>
 <xsl:apply-templates select="*"/>
</xsl:template>

<xsl:template match="h1 | p | b | i">
  <xsl:copy>
    <xsl:element name="name()">
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:copy> 
</xsl:template>

<xsl:template match="h1" mode="toc">
  <xsl:element name="li">
    <xsl:value-of select="."/>
  </xsl:element>
</xsl:template>
</xsl:stylesheet>