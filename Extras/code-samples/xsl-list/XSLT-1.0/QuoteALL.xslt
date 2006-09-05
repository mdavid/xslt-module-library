<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:properties="uri:properties:elements[element]" extension-element-prefixes="properties">

<properties:elements>
  <element artist="Book" select="name">#ff00ff</element>
  <element artist="Journal Article" select="journal">#cccccc</element >
  <element artist="Dan Palmer" select="artist">#ffffff</element >
</properties:elements>

<xsl:variable name="elements" select="document('')/*/properties:elements/element"/>

<xsl:template match="/">
  <html>
    <body>
      <xsl:apply-templates select="catalog"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="catalog">
    <h2>Your Selections</h2>
     <xsl:apply-templates select="cd"/>    
</xsl:template>

<xsl:template match="cd">
<xsl:variable name="artist" select="artist"/> 
<table border="1">
    <tr>
        <th>Title</th>
        <th>Artist</th>
    </tr>
  <tr>
      <td bgcolor="{$elements[@artist = $artist]}"><xsl:value-of select="title"/></td>
      <td ><xsl:value-of select="child::*[local-name() = $elements[@artist = $artist]/@select]"/></td>
  </tr>
</table>
 <h2>Quote from this artist:</h2>
<ul>
  <xsl:apply-templates select="quote"/>
</ul>
</xsl:template>

<xsl:template match="quote">
      <li><xsl:value-of select="."/></li>
</xsl:template>

</xsl:stylesheet>
