<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exslt="http://exslt.org/common"
    version="1.0">
  <xsl:param name="dirPath" select="'Main/Computers/WWW'"/> 
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/">
    <xsl:variable name="dirPathXML">
      <xsl:call-template name="PathToXML">
        <xsl:with-param name="dirPath" select="$dirPath"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="dirXML" select="exslt:node-set($dirPathXML)"/>
    <xsl:apply-templates select="$dirXML/*" mode="locDir">
      <xsl:with-param name="directory" select="*"/>
    </xsl:apply-templates>
  </xsl:template>
  <xsl:template name="PathToXML">
    <xsl:param name="dirPath"/>
    <xsl:choose>
      <xsl:when test="starts-with($dirPath, '/')">
        <xsl:call-template name="PathToXML">
          <xsl:with-param name="dirPath" select="substring-after($dirPath, '/')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="element">
          <xsl:choose>
            <xsl:when test="string-length(substring-after($dirPath, '/')) &gt; 0">
              <xsl:attribute name="name">
                <xsl:value-of select="substring-before($dirPath, '/')"/>
              </xsl:attribute>
              <xsl:call-template name="PathToXML">
                <xsl:with-param name="dirPath" select="substring-after($dirPath, '/')"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:when test="contains($dirPath, '/')">
              <xsl:value-of select="substring-before($dirPath, '/')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$dirPath"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="element" mode="locDir">
    <xsl:param name="directory"/>
    <xsl:variable name="name" select="@name"/>
    <xsl:choose>
      <xsl:when test="*">
        <xsl:apply-templates select="*" mode="locDir">
          <xsl:with-param name="directory" select="$directory[@name = $name]/*"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <table>
          <tr>
            <xsl:apply-templates select="$directory[@name = $name]/*" mode="outputYahoo"/>
          </tr>
        </table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="element[last()]" mode="outputYahoo">
    <td>
      <a href="{@name}">&#160;<xsl:value-of select="@name"/>&#160;</a>
    </td>
  </xsl:template>
  <xsl:template match="element" mode="outputYahoo">
    <td>
      <a href="{@name}">&#160;<xsl:value-of select="@name"/>&#160;</a>
    </td>
    <td>|</td>
  </xsl:template>

</xsl:stylesheet>
