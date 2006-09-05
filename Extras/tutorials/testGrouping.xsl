<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                version="1.0">
<xsl:strip-space elements="*"/>
<xsl:output method="html" indent="yes" encoding="iso-8859-1"/>

<xsl:variable name="number_of_columns">2</xsl:variable>

<xsl:template match="/">
  <xsl:variable name="groupedContent">
  <xsl:copy>
    <Columns>
      <xsl:apply-templates select="/DBInspector/ColumnNames/Column">
        <xsl:with-param name="matchingEntrie" select="DBInspector/ColumnEntries/Row"/>
      </xsl:apply-templates>
    </Columns>
  </xsl:copy>
  </xsl:variable>
  <xsl:call-template name="transform">
    <xsl:with-param name="groupedContent" select="xalan:nodeset($groupedContent)"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="Column">
  <xsl:param name="matchingEntrie"/>
  <xsl:variable name="pos" select="position()"/>
    <xsl:copy>
      <xsl:attribute name="name"><xsl:value-of select="."/></xsl:attribute>
      <xsl:copy-of select="$matchingEntrie/Entrie[position() = $pos]"/>
    </xsl:copy>
</xsl:template>

<xsl:template name="transform">
  <xsl:param name="groupedContent"/>
  <table>
    <xsl:apply-templates select="$groupedContent/Columns/Column" mode="transform"/>
  </table>
</xsl:template>

<xsl:template match="Column" mode="transform">
<xsl:variable name="pos" select="position()"/>
  <xsl:if test="(($pos - 1) mod $number_of_columns) = 0">
    <tr>
      <xsl:apply-templates select=". | following-sibling::Column[position() &lt; ($pos + ($number_of_columns - 1))]" mode="row"/>
    </tr>
  </xsl:if>
</xsl:template>

<xsl:template match="Column" mode="row">
  <td>
    <table>
      <tr>
        <td>
          <xsl:value-of select="@name"/>
        </td>
      </tr>
      <tr>
        <td>
          <!-- this value-of translates the name of column into dashes which allows you to control the length of your dashed line more precisely to the length of the data -->
          <xsl:value-of select="translate(@name, 'abcdefghijklmnopqrstuvwxyz', '--------------------------')"/>
        </td>
      </tr>
      <xsl:apply-templates select="Entrie"/>
    </table>
  </td>
</xsl:template>

<xsl:template match="Entrie">
  <tr>
    <td>
      <xsl:value-of select="."/>
    </td>
  </tr>
</xsl:template>

</xsl:stylesheet>
