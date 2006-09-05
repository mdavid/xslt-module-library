<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
  <xsl:apply-templates select="label/@paragraph">
    <xsl:with-param name="labelAtt" select="label/@*"/>
    <xsl:with-param name="label" select="label"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="@paragraph[.='true']">
<xsl:param name="labelAtt"/>
<xsl:param name="label"/>
<xsl:element name="p">
  <xsl:element name="span">
    <xsl:attribute name=""></xsl:attribute>
  </xsl:element>
</xsl:element>
</xsl:template>

<xsl:template match="@paragraph[.='false']">
<xsl:param name="labelAtt"/>
<xsl:param name="label"/>

</xsl:template>

</xsl:stylesheet>
