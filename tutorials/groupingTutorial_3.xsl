<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:key name="distinctTitle" match="@title" use="."/>
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
    <xsl:variable name="groupTitles">
      <xsl:element name="groupTitles">
        <xsl:apply-templates select="run/child::*[generate-id(@title) = generate-id(key('distinctTitle', @title))]" mode="groupDistinct">
          <xsl:with-param name="allElements" select="*"/>
        </xsl:apply-templates>
      </xsl:element>
    </xsl:variable>
    <xsl:copy-of select="$groupTitles"/>
  </xsl:template>
  <xsl:template match="*" mode="groupDistinct">
    <xsl:param name="allElements"/>
    <xsl:variable name="title" select="@title"/>
    <xsl:element name="group">
      <xsl:attribute name="name">
        <xsl:value-of select="@title"/>
      </xsl:attribute>
      <xsl:copy-of select="$allElements/child::*[@title = $title]"/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
