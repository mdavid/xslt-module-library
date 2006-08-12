<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:strip-space elements="*"/>
<xsl:output method="xml" indent="yes" encoding="iso-8859-1"/>

<xsl:template match="/">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="*">
	<xsl:if test=". != ''">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:element name="name()">
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:copy>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>
