<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-reverse.xsl"/>
  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:value-of select="f:reverse(1 to 1000000)"/>
  </xsl:template>
</xsl:stylesheet>