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
   
   <xsl:variable name="vNumIters" select="25000"/>
   
    <xsl:template match="/">
      <xsl:value-of select=
      "format-number(sum(for $i in 0 to $vNumIters 
                       return f:pow($v2Thirds, 
                                    $i)
                         ), 
                     '##.000000000'
                     )"/>
      <xsl:text>&#xA;</xsl:text>
<!--
      <xsl:value-of select=
      "format-number(sum(for $i in 1 to $vNumIters 
                       return f:pow($i, -0.5)
                         ), 
                     '##.000000000'
                     )"/>
-->
    </xsl:template>
</xsl:stylesheet>