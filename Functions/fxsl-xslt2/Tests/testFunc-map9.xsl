<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>
   <xsl:import href="../f/func-map.xsl"/>
   <xsl:import href="../f/func-exp.xsl"/>
   <xsl:import href="../f/func-standardXpathFunctions.xsl"/>

   <!-- to be applied on numList.xml -->

   <xsl:output method="text"/>
   
   <xsl:variable name="v2Thirds" as="xs:double" select="2 div 3"/>
   
    <xsl:template match="/">
      <xsl:value-of select=
      "format-number(sum(f:map(f:pow($v2Thirds), 0 to 25000)), '##.000000000')"/>
    </xsl:template>
</xsl:stylesheet>