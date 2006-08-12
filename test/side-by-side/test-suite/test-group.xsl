<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/booklist">
    <authors>
      <xsl:call-template name="RecursiveGrouping">
        <xsl:with-param name="list" select="book"/>
      </xsl:call-template>
    </authors>
  </xsl:template>

  <xsl:template name="RecursiveGrouping">
    <xsl:param name="list"/>
    
     <!-- Selecting the first author name as group identifier and the group
    itself-->
    <xsl:variable name="group-identifier" select="$list[1]/@author"/>
    <xsl:variable name="group" select="$list[@author=$group-identifier]"/>
    
     <!-- Do some work for the group -->
    <author name="{$group-identifier}" number-of-books="{count($group)}"/>
    
     <!-- If there are other groups left, calls itself -->
    <xsl:if test="count($list)>count($group)">
      <xsl:call-template name="RecursiveGrouping">
        <xsl:with-param name="list"
            select="$list[not(@author=$group-identifier)]"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>

    
    
