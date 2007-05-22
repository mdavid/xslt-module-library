<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
  <xsl:import href="../f/func-multiMap.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>
  
 <xsl:template match="/">
   <xsl:variable name="vDelimElem" as="element()">
     <map/>
   </xsl:variable>
   <multiMap select="f:multiMap($vDelimElem, (f:add(1), f:mult(2), f:mult(10)), 1  to 10)">
   <xsl:sequence select=
    "f:multiMap($vDelimElem, (f:add(1), f:mult(2), f:mult(10)), 1  to 10)"
  />
  </multiMap>
 </xsl:template>
</xsl:stylesheet>