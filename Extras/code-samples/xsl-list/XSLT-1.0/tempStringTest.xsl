<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exslt="http://exslt.org/common" version="1.0" exclude-result-prefixes="exslt">
  <xsl:strip-space elements="*"/>
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/newsletter/content">
    <xsl:variable name="temp">
      <xsl:apply-templates select="article" mode="temp"/>
    </xsl:variable>
    <xsl:apply-templates select="exslt:node-set($temp)" mode="writeContents"/>
  </xsl:template>
  <xsl:template match="article" mode="temp">
    <xsl:copy>
      <xsl:if test="contains(metadata/article-classification, 'Biz-Webcast')">
        <xsl:attribute name="passStringTest">true</xsl:attribute>
      </xsl:if>
      <xsl:copy-of select="* | @*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="article[@passStringTest][1]" mode="writeContents">
    <hr/>
    <p>
      <xsl:value-of select="'This is the first instance of an element that passed the string test'"/>
    </p>
    <p>
      <xsl:value-of select="."/>
    </p>
    <hr/>
  </xsl:template>
  <xsl:template match="article" mode="writeContents">
    <hr/>
    <p>
      <xsl:value-of select="."/>
    </p>
    <hr/>
  </xsl:template>
</xsl:stylesheet>
<!-- Stylus Studio meta-information - (c)1998-2004. Sonic Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="tempStringTest.xml" htmlbaseurl="" outputurl="" processortype="saxon7" profilemode="7" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no"/><MapperBlockPosition></MapperBlockPosition></MapperMetaTag>
</metaInformation>
-->
