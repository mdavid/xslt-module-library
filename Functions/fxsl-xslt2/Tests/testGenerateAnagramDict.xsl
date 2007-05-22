<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="../f/func-standardXSLTXpathFunctions.xsl"/>
 
 <!-- To be applied on dictEnglish.xml -->

 <xsl:template match="/">
   <anagrams>
	   <xsl:for-each-group select="/*/w" group-by=
	   "codepoints-to-string(f:xsltSort(string-to-codepoints(.),
	                                    (f:_auxInt2Str())
	                                    )
                           )">
	    <xsl:sort select="current-grouping-key()"/>
		    <xsl:if test="current-group()[2]">
	        <aChain key="{current-grouping-key()}">
		        <xsl:sequence select="current-group()"/>
		      </aChain>
		      <xsl:sequence select="'&#xA;'"/>
		    </xsl:if>
	   </xsl:for-each-group> 
   </anagrams>
 </xsl:template>
 
 <xsl:variable name="vZeroes" select="'0000000000'" 
                              as="xs:string"/>
 <xsl:function name="f:_auxInt2Str" as="xs:string">
   <xsl:param name="arg1" as="xs:integer"/>
   
   <xsl:variable name="vstrParm" as="xs:string"
      select="xs:string($arg1)"/>
      
   <xsl:sequence select=
    "concat(substring($vZeroes,1, 
                      10 - string-length($vstrParm)
                      ), 
            $vstrParm
            )"
    />
 </xsl:function>
 
 <xsl:function name="f:_auxInt2Str" as="element()">
   <f:_auxInt2Str/>
 </xsl:function>
 
 <xsl:template match="f:_auxInt2Str" as="xs:string"
   mode="f:FXSL">
   <xsl:param name="arg1" as="xs:integer"/>
   
   <xsl:sequence select="f:_auxInt2Str($arg1)"/>
 </xsl:template>
</xsl:stylesheet>