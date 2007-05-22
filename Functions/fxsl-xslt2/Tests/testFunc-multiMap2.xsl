<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
  <xsl:import href="../f/func-multiMap.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>
  <xsl:import href="../f/func-id.xsl"/>
  <xsl:import href="../f/func-const.xsl"/>
  <xsl:import href="../f/func-choice.xsl"/>
  <xsl:import href="../f/func-lift.xsl"/>
  <xsl:import href="../f/func-compose.xsl"/>
  
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
 <xsl:template match="/">
   <xsl:variable name="vDelimElem" as="element()">
     <map/>
   </xsl:variable>
   
   <multiMap>
   <xsl:sequence select=
    "f:multiMap($vDelimElem, 
                (f:compose(f:choice('fizz', '', 0), f:flip(f:mod(),3)), 
                 f:compose(f:choice('buzz', '', 0), f:flip(f:mod(),5)),
                 f:lift4(f:choice(),
                         f:const(''),
                         f:id(),
                         f:const((0,3,5,6,9,10,12)),
                         f:flip(f:mod(),15)
                         )
                ),
                1  to 100)"
  />
  </multiMap>
 </xsl:template>
</xsl:stylesheet>