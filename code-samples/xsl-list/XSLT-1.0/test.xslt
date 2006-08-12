<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:s="http://www.loc.gov/MARC21/slim"
                version="1.0">
<xsl:output method="html"/>
<xsl:template match="/">
  <xsl:apply-templates select="//s:subfield[@code = 'a']"/>
</xsl:template>
<xsl:template match="s:subfield">    
     <xsl:copy-of select="."/>
</xsl:template>
</xsl:stylesheet>

<!--<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:s="http://www.loc.gov/MARC21/slim"
                version="1.0">
<xsl:output method="html"/>
<xsl:template match="/">
  <xsl:apply-templates select="//s:subfield"/>
</xsl:template>
<xsl:template match="s:subfield">    
    <xsl:if test="@code = 'a'">
     <xsl:copy-of select="."/>
    </xsl:if>
</xsl:template>
</xsl:stylesheet>-->
<!--

<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:s="http://www.loc.gov/MARC21/slim"
                version="1.0">
<xsl:output method="html"/>
<xsl:template match="/">
  <xsl:apply-templates select="//s:subfield"/>
</xsl:template>
<xsl:template match="s:subfield[@code = 'a']">    
     <xsl:copy-of select="."/>
</xsl:template>

<xsl:template match="s:subfield"/>

</xsl:stylesheet>

-->


<!--

-->
