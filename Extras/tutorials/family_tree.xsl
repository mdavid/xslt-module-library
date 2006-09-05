<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">
  <xsl:apply-templates select="//*[@lastname][1]" mode="find_last_name">
    <xsl:with-param name="the_whole_family_tree" select="*[not(self::bastard_child_of_foo)]"/>
  </xsl:apply-templates>
</xsl:template>
<xsl:template match="*" mode="find_last_name">
<xsl:param name="the_whole_family_tree"/>
  <xsl:apply-templates select="$the_whole_family_tree" mode="return_to_your_roots">
    <xsl:with-param name="last_name" select="@lastname"/>
  </xsl:apply-templates>
</xsl:template>
<xsl:template match="*" mode="return_to_your_roots">
<xsl:param name="last_name"/>
    <xsl:element name="{name()}">
      <xsl:attribute name="last_name"><xsl:value-of select="$last_name"/></xsl:attribute>
      <xsl:apply-templates mode="return_to_your_roots">
      <xsl:with-param name="last_name" select="$last_name"/>
    </xsl:apply-templates>
    </xsl:element>
</xsl:template>
</xsl:stylesheet>
