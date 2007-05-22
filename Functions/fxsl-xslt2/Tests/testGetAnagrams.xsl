<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 >
 
 <xsl:import href="../f/func-qsort.xsl"/>
  
 <xsl:key name="kAnagram" match="w" 
   use="codepoints-to-string(f:qsort(string-to-codepoints(.)))"
  />
 <xsl:template match="/">
   <xsl:copy-of select="key('kAnagram', 'acert')"/>
 </xsl:template>
</xsl:stylesheet>