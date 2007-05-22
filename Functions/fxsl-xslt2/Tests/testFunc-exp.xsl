
<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >

  <xsl:import href="../f/func-exp.xsl"/>

<!--
  To be applied on any xml file, or with initial template named "initial"
                                                                         
      Expected result:                                                   
		       2.000000001444001                                             
           22.459157762347406                                            
           1.999999999538168                                             
           9.999999955017541                                             
           3.1415926541687718                                            
           2.718281828960005                                             
           3.6894816398697386E-18                                        
-->

  <xsl:output method="text"/>
  
  <xsl:template name="initial" match="/">
    <xsl:variable name="vPi" as="xs:double" 
         select="3.1415926535897932384626433832795E0"/>
    <xsl:variable name="vE" as="xs:double" select="2.71828182845904E0"/>
  
    <xsl:value-of select="f:log10(100E0)"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:pow($vPi, $vE)"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:pow(1024E0, 0.1E0)"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:log2(1024E0)"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:ln(f:pow($vE, $vPi))"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:pow(f:pow($vE, $vPi), 1 div $vPi)"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:pow(2 div 3, 99)"/>
    
    -------------
<xsl:text/>
    <xsl:value-of separator="'&#xA;'" select=
     "for $vN in (-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0,
                   1,2,3,4,5,6,7,8,9,10)
          return f:pow(10, $vN)
     "
     />
  </xsl:template>
</xsl:stylesheet>