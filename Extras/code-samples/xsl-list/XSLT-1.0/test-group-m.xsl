<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:key name="author" match="@author" use="."/>
  <xsl:template match="/booklist">
    <authors>
      <xsl:apply-templates select="book[generate-id(@author) = generate-id(key('author', @author))]"/>
    </authors>
  </xsl:template>
  <xsl:template match="book">
    <xsl:variable name="count" select="count(following-sibling::book[@author = current()/@author])"/>
    <author name="{@author}" number-of-books="{$count + 1}"/>
  </xsl:template>
</xsl:stylesheet>

