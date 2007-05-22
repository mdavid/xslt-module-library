<xsl:stylesheet version="2.0"

 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"

 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs">

 <xsl:import href="../f/func-iter.xsl"/>

 <!-- To be applied on any xml file, or with initial template named
"initial" -->

 <xsl:output omit-xml-declaration="yes"/>

 <xsl:variable name="vExecutionLimit" as="xs:integer"
              select="100"/>
 <xsl:variable name="vNL" select="'&#xA;'"/>

 <xsl:template name="initial" match="/">

   <xsl:variable name="vRawResults" select=
   "f:iterUntil(f:last(), f:transform(), (0,false()))"/>

   Results:

   Last tick: <xsl:sequence select="$vRawResults[1]"/>
   Stop condition:  <xsl:sequence select="$vRawResults[last()]"/>

   Transform output:
 <xsl:text/>
    <xsl:sequence select=
        "for $i in 2 to count($vRawResults) -1
             return $vRawResults[$i]"
    />

 </xsl:template>

 <xsl:function name="f:transform" as="item()+">
   <xsl:param name="pWorld" as="item()+"/>

   <xsl:variable name="vnewTick" select="$pWorld[1]+1"/>

   <xsl:variable name="vmyResults" as="item()*">
     <!-- Do whatever processing is needed here -->
     <!-- and produce our "useful" results      -->

     <xsl:sequence select=
         " remove(remove($pWorld, count($pWorld)),1),
          $vnewTick, '   ', 3*$vnewTick, $vNL"/>

     <!-- Set the stop condition in the last item -->
     <xsl:sequence select=
      "if($vnewTick gt $vExecutionLimit)
         then true()
         else false()
      "/>
   </xsl:variable>

   <!-- Produce the results                        -->
   <!-- The "tick" is always the 1st item returned -->

   <xsl:message>
     f:transform():
       Results: "<xsl:sequence select="$vnewTick, $vmyResults"/>"
   </xsl:message>
   
   <xsl:sequence select="$vnewTick, $vmyResults"/>
 </xsl:function>

 <xsl:function name="f:transform" as="element()">
   <f:transform/>
 </xsl:function>

 <xsl:template match="f:transform" as="item()+" mode="f:FXSL">
   <xsl:param name="arg1" as="item()+"/>

   <xsl:sequence select="f:transform($arg1)"/>
 </xsl:template>

 <xsl:function name="f:last" as="xs:boolean">
   <xsl:param name="arg1" as="item()*"/>

   <xsl:sequence select="xs:boolean($arg1[last()])"/>
 </xsl:function>

 <xsl:function name="f:last" as="element()">
   <f:last/>
 </xsl:function>

 <xsl:template match="f:last" as="xs:boolean" mode="f:FXSL">
   <xsl:param name="arg1" as="item()*"/>

   <xsl:message>
     f:last(): $arg1 = "<xsl:sequence select="$arg1"/>"
   </xsl:message>

   <xsl:sequence select="f:last($arg1)"/>
 </xsl:template>

</xsl:stylesheet>