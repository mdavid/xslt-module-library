<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" exclude-result-prefixes="ss">

<xsl:output method="xml" indent="yes"/>
<xsl:template match="/">
<fpFormats>
  <xsl:apply-templates select="Workbook/Column/Row/Cell"/> -->
  
</fpFormats>
</xsl:template>

<xsl:template match="Cell">
  <data match="{Data}" src="/static/xsl/lib/xml/{Data}_Format.xml"/>
</xsl:template>
</xsl:stylesheet>
