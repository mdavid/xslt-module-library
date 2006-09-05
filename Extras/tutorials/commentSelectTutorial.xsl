<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="/">
    <xsl:apply-templates select="dataItems"/>
  </xsl:template>
  <xsl:template match="dataItems">
    <xsl:element name="dataItems">
      <xsl:apply-templates select="item"/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="item">
    <xsl:variable name="followingCommentsCountfromPrecedingItem" select="count(preceding-sibling::item[1]/following-sibling::comment())"/>
    <xsl:variable name="followingCommentsCountfromCurrentItem" select="count(following-sibling::comment())"/>
    <xsl:variable name="totalPrecedingCommentsAssociatedWithThisItem">
      <xsl:choose>
        <xsl:when test="position() = 1">
          <xsl:value-of select="count(preceding-sibling::comment())"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$followingCommentsCountfromPrecedingItem - $followingCommentsCountfromCurrentItem"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:element name="item">
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:attribute name="comment">
        <xsl:for-each select="preceding-sibling::comment()[position() &lt;= $totalPrecedingCommentsAssociatedWithThisItem]">
          <xsl:value-of select="concat('COMMENT: ', normalize-space(.), ' ')"/>
        </xsl:for-each>
      </xsl:attribute>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
