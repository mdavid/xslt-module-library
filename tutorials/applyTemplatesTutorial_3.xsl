<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:strip-space elements="*"/>
  <xsl:output method="html"/>
  <xsl:template match="/">
    <xsl:text>Table of Contents:</xsl:text>
    <br/>
    <xsl:element name="ol">
      <xsl:apply-templates select="document('')/*/xsl:template//h1" mode="toc"/>
    </xsl:element>
    <br/>
    <h1>this is heading 1</h1>
    <p>this is paragraph one <b>with bold text <i>with bold and italicized text</i>
      </b>
      <i> with italicized text</i>
    </p>
    <h1>this is heading 2</h1>
    <p>this is paragraph one <b>with bold text <i>with bold and italicized text</i>
      </b>
      <i> with italicized text</i>
    </p>
    <h1>this is heading 3</h1>
    <p>this is paragraph one <b>with bold text <i>with bold and italicized text</i>
      </b>
      <i> with italicized text</i>
    </p>
    <h1>this is heading 4</h1>
    <p>this is paragraph one <b>with bold text <i>with bold and italicized text</i>
      </b>
      <i> with italicized text</i>
    </p>
  </xsl:template>
  
  <xsl:template match="h1 | p | b | i">
    <xsl:copy>
      <xsl:element name="name()">
        <xsl:apply-templates/>
      </xsl:element>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="h1" mode="toc">
    <xsl:element name="li">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>

