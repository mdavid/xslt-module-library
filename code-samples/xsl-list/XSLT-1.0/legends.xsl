<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" encoding="UTF-8"/>
  
  <xsl:template match="/members">
    <div class="right-side-head-title">
      <h2>Legends of the XSLT Community</h2>
    </div>
    <div class="right-side-head-sub-title">Individuals</div>
    <div class="legends-container">
      <xsl:apply-templates select="member[@type = 'individual']">
        <xsl:sort select="substring-after(., ' ')"/>
      </xsl:apply-templates>
    </div>
    <div class="right-side-head-sub-title">Entitities</div>
    <div class="legends-container">
      <xsl:apply-templates select="member[@type = 'entity']">
        <xsl:sort select="substring-after(., ' ')"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>
  <xsl:template match="member">
    <div class="legends">
      <a href="{@href}">
        <xsl:value-of select="."/>
      </a>
    </div>
  </xsl:template>
</xsl:stylesheet>
