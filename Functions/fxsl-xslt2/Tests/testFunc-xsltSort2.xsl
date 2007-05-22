<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-map.xsl"/>
 <xsl:import href="../f/func-flip.xsl"/>
 <xsl:import href="../f/func-standardXSLTXpathFunctions.xsl"/>
 <xsl:import href="../f/func-standardAxisXpathFunctions.xsl"/>

<!--
  To be applied on testFunc-xsltSort2.xml
-->

 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:template match="/">
  <employees>
   <xsl:sequence select=
     "f:xsltSort(/*/employee, 
		             f:map(f:flip(f:element()), /*/sort)
                 )"/>  
  </employees> 
 </xsl:template>
</xsl:stylesheet>