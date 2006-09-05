<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="text"/>
<xsl:template match="/">
  <xsl:apply-templates select="RR/RR_row/RR_group1/RR_group2/RR_group3/RR_group4"/>
</xsl:template>
<xsl:template match="RR_group4[ancestor::RR_group2/type = 1]">
type 1
</xsl:template>
<xsl:template match="RR_group4[ancestor::RR_group2/type = 2]">
type 2
</xsl:template>
<xsl:template match="RR_group4[ancestor::RR_group2/type = 3]">
type 3
</xsl:template>
</xsl:stylesheet>
