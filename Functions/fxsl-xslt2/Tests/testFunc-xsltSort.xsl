<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-id.xsl"/>
 <xsl:import href="../f/func-flip.xsl"/>
 <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
 <xsl:import href="../f/func-standardAxisXpathFunctions.xsl"/>

<!--
  To be applied on testFunc-xsltSort.xml
-->

 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
 <xsl:template name="initial" match="/">
  <result>
   <xsl:sequence select=
     "f:xsltSort(/*/*, 
                 f:flip(f:attribute(),'sortorder')
                 )"/>  
  </result> 
 </xsl:template>
</xsl:stylesheet>