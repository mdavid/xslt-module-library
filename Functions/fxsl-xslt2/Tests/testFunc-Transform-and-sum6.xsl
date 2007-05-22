<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>
   <xsl:import href="../f/func-transform-and-sum.xsl"/>
   <xsl:import href="../f/func-exp.xsl"/>
   <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
   <xsl:import href="../f/func-flip.xsl"/>

   <!-- to be applied on numList.xml -->

   <xsl:output method="text"/>
   
    <xsl:template match="/">
      <xsl:value-of select=
      "format-number(f:transform-and-sum(f:flip(f:pow(),-0.5), 1 to 25000), '####.000000000')"/>
    </xsl:template>
</xsl:stylesheet>