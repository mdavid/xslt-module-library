<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="/">
    <supplements>
      <xsl:apply-templates select="supplements/supp[not(contains(supp-desc, '('))]"/>
    </supplements>
  </xsl:template>

  <xsl:template match="supp">
    <xsl:for-each select=". | ../supp[contains(supp-desc, current()/supp-desc)]">
    <xsl:sort select="supp-desc"/>
      <xsl:copy-of select="."/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
