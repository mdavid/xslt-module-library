<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="../f/func-repeat.xsl"/>
 
 <xsl:output method="text" />
  
  <xsl:variable name="test" select="'test'"/>
  <xsl:template match="valuedef">
    <xsl:value-of separator="" select=
    "'###,###', if(decimals gt 0) then '.' else (), f:repeat('0', decimals)"/>
    
  </xsl:template>
</xsl:stylesheet>