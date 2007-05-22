<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 >
 
 <xsl:import href="../f/func-qsort.xsl"/>
 
 <!-- To be applied on: dictAnagrams.xml -->
  
 <xsl:key name="kAngrmChain" match="aChain" 
   use="@key"
  />
 <xsl:template match="/">
   <xsl:sequence select="f:anagrams('trace', .)"/>
 </xsl:template>

  <xsl:function name="f:anagrams" as="xs:string*">
   <xsl:param name="pWord" as="xs:string"/>
   <xsl:param name="pContext" as="node()"/>
   
   <xsl:sequence select=
     "key('kAngrmChain',f:anagramKey($pWord),$pContext)"/>
  </xsl:function>
  
 <xsl:function name="f:anagramKey" as="xs:string">
   <xsl:param name="pWord" as="xs:string"/>
   
   <xsl:sequence select=
    "codepoints-to-string(f:qsort(string-to-codepoints($pWord)))"/>
 </xsl:function>
</xsl:stylesheet>