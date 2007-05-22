<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f" 
 >
 
 <xsl:import href="../f/func-trignm.xsl"/>
 <!-- To be applied on any xml file -->

 <xsl:output method="text"/>
  
  <xsl:template match="/">
   <xsl:text>&#xA;</xsl:text>
   <xsl:for-each select="(1 to 100)">
      <xsl:variable name="vSinx" select="f:sin(xs:double(.))"/>
      <xsl:variable name="vCosx" select="f:cos(xs:double(.))"/>
     <xsl:sequence select=
     "('sin^2(', ., ') + cos^2(', ., ') = ', 
       $vSinx*$vSinx + $vCosx*$vCosx, '&#xA;')"/>
   </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>