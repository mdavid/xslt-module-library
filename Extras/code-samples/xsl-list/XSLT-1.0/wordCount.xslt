<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:exslt="http://exslt.org/common"
                version="1.0">
<xsl:template match="poem">
<xsl:variable name="wordCount">
  <words>
    <xsl:call-template name="wordCount">
      <xsl:with-param name="paragraph" select="translate(normalize-space(hey_diddle), '.', '  ')"/>
    </xsl:call-template>
  </words>
</xsl:variable>
Words in Paragraph:
<xsl:for-each select="exslt:node-set($wordCount)/words/word">
Word <xsl:number/>: <xsl:value-of select="."/>
</xsl:for-each>
Total Words: <xsl:value-of select="count(exslt:node-set($wordCount)/words/word)"/>
</xsl:template>
<xsl:template name="wordCount">
<xsl:param name="paragraph"/>
<xsl:if test="$paragraph">
  <word>
    <xsl:value-of select="substring-before($paragraph, ' ')"/>
  </word>
  <xsl:call-template name="wordCount">
    <xsl:with-param name="paragraph" select="substring-after($paragraph, ' ')"/>
  </xsl:call-template>
</xsl:if>
</xsl:template>
</xsl:stylesheet>

