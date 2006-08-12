<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<!-- This Stylesheet is licensed under the Creative Commons 2.0 Attribution License -->
<!-- For more information in regards to this license please visit the following URL -->
<!-- http://creativecommons.org/licenses/by/2.0/ -->
<!-- Original Author: M. David Peterson -->
<!-- Original Author's Contact Email: m.david@x2x2x.org -->
<!-- Original Author's Web Address: http://www.xsltblog.com -->
<!-- Original Release Date: December 20th, 2004 -->
<!-- Version Information: 0.1 -->
<!-- Any questions, comments, or concerns please visit my XSLT related blog at the address posted above. -->
<!-- This stylesheet requires a processor that supports the latest workking draft of the XSLT 2.0 specification -->
<!-- While there are several that are near completion and several more well on their way, the only processor -->
<!-- that can be considered completely up-to-date with the latest working draft specification -->
<!-- is Dr. Michaels Kays latest Saxon processor release.  Please visit http://www.Saxonica.com for more details -->
<!-- Enjoy! -->
<!-- <M:D/> -->

  <xsl:param name="output"/>
  <xsl:param name="result-parent"/>
  <xsl:param name="parent-bat-file"/>
  <xsl:param name="execution-directory"/>
  
  <xsl:variable name="bat-source-file" select="document(/files/config-files/file[@id = 'bat-config']/@name)"/>
  <xsl:variable name="source-file" select="document($bat-source-file/output/files/source/@href)"/>
  <xsl:variable name="source-file-elements" select="$source-file/booklist/book"/>
  <xsl:variable name="defaults" select="$bat-source-file/output/defaults"/>
  
  <xsl:variable name="xsl-file-names" select="/files/xsl-files"/>
  
  <xsl:output name="text" method="text" encoding="utf-8"/>
  <xsl:output name="xml" method="xml"/>

  <xsl:template match="/">
    <xsl:apply-templates select="files/output-files/file" mode="create-bat-file-collection"/>
    <xsl:result-document format="text" href="file:///{$output}/{$parent-bat-file}">
        <xsl:apply-templates select="files/output-files/file" mode="parent-bar-output-file"/>
    </xsl:result-document> 
  </xsl:template>
  
  <xsl:template match="file" mode="parent-bar-output-file">
    <xsl:variable name="bat-file-name" select="concat(@number-of-elements, '.bat')"/>
    <xsl:variable name="parent-bat-text-output">
        <xsl:apply-templates select="$xsl-file-names/file" mode="parent-bat-output">
          <xsl:with-param name="bat-file-name" select="$bat-file-name"/>
        </xsl:apply-templates>
    </xsl:variable>
    <xsl:value-of select="$parent-bat-text-output"/>
  </xsl:template>

  <xsl:template match="file" mode="create-bat-file-collection">
    <xsl:variable name="file-name" select="concat(@number-of-elements, '.xml')"/>
    <xsl:variable name="bat-file-name" select="concat(@number-of-elements, '.bat')"/>
    <xsl:variable name="recurse-source-file-number" select="round(@number-of-elements div count($source-file-elements))"/>
    <xsl:result-document href="file:///{$output}/{$file-name}">
      <xsl:element name="{$result-parent}">
        <xsl:call-template name="add-elements">
          <xsl:with-param name="recurse-source-file-number" select="$recurse-source-file-number"/>
        </xsl:call-template>
      </xsl:element>
    </xsl:result-document>
    <xsl:apply-templates select="$xsl-file-names/file" mode="xsl-files">
      <xsl:with-param name="in-xml-file-name" select="$file-name"/>
      <xsl:with-param name="bat-file-name" select="$bat-file-name"/>
      <xsl:with-param name="test-output-file-name" select="concat('o-', @number-of-elements, '.xml')"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template name="add-elements">
    <xsl:param name="recurse-source-file-number"/>
    <xsl:if test="$recurse-source-file-number != 0">
      <xsl:copy-of select="$source-file/booklist/book"/>
      <xsl:call-template name="add-elements">
        <xsl:with-param name="recurse-source-file-number" select="$recurse-source-file-number - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="file" mode="xsl-files">
    <xsl:param name="in-xml-file-name"/>
    <xsl:param name="bat-file-name"/>
    <xsl:param name="test-output-file-name"/>
    <xsl:apply-templates select="$bat-source-file/output/sequence">
      <xsl:with-param name="in-xml-file-name" select="$in-xml-file-name"/>
      <xsl:with-param name="in-xsl-file-name" select="@name"/>
      <xsl:with-param name="identifier" select="@identifier"/>
      <xsl:with-param name="bat-file-name" select="$bat-file-name"/>
      <xsl:with-param name="test-output-file-name" select="$test-output-file-name"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="file" mode="parent-bat-output">
    <xsl:param name="bat-file-name"/>
    <xsl:apply-templates select="$bat-source-file/output/sequence" mode="parent-bat-output">
      <xsl:with-param name="identifier" select="@identifier"/>
      <xsl:with-param name="bat-file-name" select="$bat-file-name"/>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="sequence" mode="parent-bat-output">
    <xsl:param name="identifier"/>
    <xsl:param name="bat-file-name"/>
    <xsl:variable name="sequence-bat-file-name" select="concat('s-', position(), '-', $identifier, '-', $bat-file-name)"/>
      <xsl:text>call </xsl:text>
      <xsl:value-of select="$sequence-bat-file-name"/>
      <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match="sequence">
    <xsl:param name="in-xml-file-name"/>
    <xsl:param name="in-xsl-file-name"/>
    <xsl:param name="identifier"/>
    <xsl:param name="bat-file-name"/>
    <xsl:param name="test-output-file-name"/>
    <xsl:variable name="sequence-bat-file-name" select="concat('s-', position(), '-', $identifier, '-', $bat-file-name)"/>
    <xsl:variable name="text-output">
      <xsl:variable name="command-line">
        <xsl:apply-templates select="$defaults/command-line"/>
      </xsl:variable>
      <xsl:apply-templates select="node">
        <xsl:with-param name="test-output-file-name" select="$test-output-file-name"/>
        <xsl:with-param name="in-xml" select="$in-xml-file-name"/>
        <xsl:with-param name="in-xsl" select="$in-xsl-file-name"/>
        <xsl:with-param name="identifier" select="concat($identifier, '-', position())"/>
        <xsl:with-param name="command-line" select="$command-line"/>
      </xsl:apply-templates>
    </xsl:variable>
    <xsl:result-document format="text" href="file:///{$output}/{$sequence-bat-file-name}">
      <xsl:value-of select="$text-output"/>
    </xsl:result-document>
  </xsl:template>

  <xsl:template match="command-line">
    <xsl:apply-templates select="switch">
      <xsl:with-param name="default-switch" select="@default-switch"/>
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="node[@call-id]">
    <xsl:param name="command-line"/>
    <xsl:value-of select="$command-line"/>
  </xsl:template>

  <xsl:template match="node[. = 'in-xml']">
    <xsl:param name="in-xml"/>
    <xsl:value-of select="$in-xml"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="switch[@call-id]">
    <xsl:param name="default-switch"/>
    <xsl:if test="@no-switch = 'false' or not(@no-switch)">
      <xsl:value-of select="$default-switch"/>
    </xsl:if>
    <xsl:value-of select="ancestor::defaults/*[@id = current()/@call-id]/@call"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="switch[@value]">
    <xsl:param name="default-switch"/>
    <xsl:if test="@no-switch = 'false' or not(@no-switch)">
      <xsl:value-of select="$default-switch"/>
    </xsl:if>
    <xsl:value-of select="@value"/>
    <xsl:if test="@use">
      <xsl:value-of select="@use"/>
    </xsl:if>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="node[. = 'in-xsl']">
    <xsl:param name="in-xsl"/>
    <xsl:value-of select="$in-xsl"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="node[. = 'o']">
    <xsl:param name="test-output-file-name"/>
    <xsl:text>-o </xsl:text>
    <xsl:value-of select="$test-output-file-name"/>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="node[. = 't']">
    <xsl:text>-t </xsl:text>
  </xsl:template>

  <xsl:template match="node[. = 'capture-t']">
    <xsl:param name="test-output-file-name"/>
    <xsl:param name="identifier"/>
    <xsl:text>2&gt;</xsl:text>
    <xsl:value-of select="concat($test-output-file-name, '-', $identifier)"/>
    <xsl:text>.txt</xsl:text>
  </xsl:template>

  <xsl:template match="node">
    <xsl:text>-</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text> </xsl:text>
  </xsl:template>
</xsl:stylesheet>
