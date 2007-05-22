<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
  <xsl:import href="../f/func-iter.xsl"/>
 <xsl:template match="/">
  <xsl:sequence select="f:scanIterDVC(1000000, f:stepProdSum(), '0000000')"/>
 </xsl:template>
 
 <xsl:function name="f:stepProdSum" as="xs:string">
   <xsl:param name="pParams" as="xs:string"/>
<!--   
   <xsl:message>
     $pParams: "<xsl:value-of select="$pParams"/>"
   </xsl:message>
-->   
   <xsl:variable name="i" as="xs:integer" select=
    "xs:integer(substring($pParams,1,2))"/>

   <xsl:variable name="j" as="xs:integer" select=
    "xs:integer(substring($pParams,3,2))"/>

   <xsl:variable name="k" as="xs:integer" select=
    "xs:integer(substring($pParams,5,2))"/>
   
   <xsl:variable name="sum" as="xs:decimal" select=
    "xs:decimal(substring($pParams,7))"/>
   
   <xsl:variable name="vNewSum" as="xs:decimal" select=
    "$i*$j*$k
     +
      $sum
    "
    />
    
    <xsl:sequence select=
    "concat(xs:string(format-number(xs:integer(substring($pParams,1,6)) + 1, '000000')), 
            xs:string($vNewSum)
            )"
    />
 </xsl:function>
 
  <xsl:function name="f:stepProdSum" as="element()">
    <f:stepProdSum/>
  </xsl:function>
  
  <xsl:template match="f:stepProdSum" mode="f:FXSL" as="xs:string">
    <xsl:param name="arg1"/>
    
    <xsl:sequence select="f:stepProdSum($arg1)"/>
  </xsl:template>

</xsl:stylesheet>