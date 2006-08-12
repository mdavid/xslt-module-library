<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="textFile" select="document('results.txt')"/>
<xsl:template match="/">
  <xsl:variable name="parseText">
    <xsl:element name="parseText">
      <xsl:element name="text">
        <xsl:value-of select="$textFile//*"/>
      </xsl:element>
    </xsl:element>
  </xsl:variable>
  <xsl:copy-of select="$parseText"/>
</xsl:template>
</xsl:stylesheet>f
