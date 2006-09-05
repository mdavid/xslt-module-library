<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:variable name="sourceDoc" select="document('groupingTutorial_1.xml')"/>
<xsl:variable name="translationDoc" select="document('groupingTutorial_2.xml')"/>
<xsl:output method="xml" indent="yes"/>
<xsl:template match="/">
  <xsl:variable name="groupTranslation">
    <xsl:element name="translations">
      <xsl:apply-templates select="$sourceDoc/file1/terms">
        <xsl:with-param name="translationDoc" select="$translationDoc/file2/translated"/>
      </xsl:apply-templates>
    </xsl:element>
  </xsl:variable>
  <xsl:copy-of select="$groupTranslation"/>
</xsl:template>

<xsl:template match="terms">
  <xsl:param name="translationDoc"/>
  <xsl:variable name="pos" select="position()"/>
    <xsl:element name="tranlatedTerm">
      <xsl:element name="source">
        <xsl:attribute name="lang"><xsl:value-of select="source[position() = 1]/@lang"/></xsl:attribute>
        <xsl:value-of select="source[position() = 1]/term"/>
      </xsl:element>
      <xsl:element name="translation">
        <xsl:attribute name="lang"><xsl:value-of select="$translationDoc/term[position() = $pos]/@lang"/></xsl:attribute>
        <xsl:value-of select="$translationDoc/term[position() = $pos]"/>
      </xsl:element>
    </xsl:element>
</xsl:template>
</xsl:stylesheet>
