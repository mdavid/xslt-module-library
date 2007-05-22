<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="C:/CVS-DDN/fxsl-xslt2/f/func-scanlDVC.xsl"/>
 <xsl:import href="C:/CVS-DDN/fxsl-xslt2/f/func-Operators.xsl"/>
  
 <xsl:template match="/">
   <xsl:variable name="vProds" as="xs:decimal*" select=
    "for $i in 0 to 99,
         $j in 0 to 99,
         $ij in $i*$j,
         $k in 0 to 99
           return
             $ij * $k
         "
    />
    
    <xsl:value-of select="f:scanl(f:add(), 0, $vProds)[position() mod 1000 = 1]"
    separator="&#xA;"/> 

  <!--<xsl:sequence select="sum($vProds)"/>-->
 </xsl:template>
</xsl:stylesheet>