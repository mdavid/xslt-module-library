<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
  <xsl:import href="../f/func-map.xsl"/>
  <xsl:import href="../f/func-standardStringXpathFunctions.xsl"/>
  
 <xsl:template match="/">
    <xsl:sequence select=
    "f:map(f:codepoints-to-string(), string-to-codepoints('Therese'))"
    />
 </xsl:template>
</xsl:stylesheet>