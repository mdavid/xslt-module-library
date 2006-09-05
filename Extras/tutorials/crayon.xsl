<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:key name="brand" match="@brand" use="."/>
<xsl:template match="crayons">
  <xsl:apply-templates select="crayon[generate-id(@brand) = generate-id(key('brand', @brand))]" mode="brand">
    <xsl:with-param name="crayons" select="crayon"/>
  </xsl:apply-templates>
</xsl:template>
<xsl:template match="crayon" mode="brand">
<xsl:param name="crayons"/>
<xsl:variable name="brand" select="@brand"/>
  Brand: <xsl:value-of select="@brand"/><br/>
  <xsl:apply-templates select="$crayons[@brand = $brand]" mode="sort"/>
</xsl:template>
<xsl:template match="crayon" mode="sort">
  Color: <xsl:value-of select="@color"/><br/>
</xsl:template>
</xsl:stylesheet>
