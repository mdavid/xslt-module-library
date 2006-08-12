<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan" version="1.0"><!-- NOTE:  obligatory opening xslt statements-->
<!-- 

  Title:
    aspectXML version 0.8 Advanced Weave XSLT Stylesheet
    
  Description:
    When used with XML data files that adhere to the Schema set forth by the aspectXML working group (see aspectXML.org for Schema details) this stylesheet will weave an aspectDefinition file with the matching elements and attributes found in an instance file
    
  License:
    Subject to the LGPL license, see www.aspectXML.org for details
    
  Versions:
    0.1: M. David Peterson (m.david@mdptws.com), 11/04/2004
      - Proof of concept stylesheet. Not available for general download.
    0.2: M. David Peterson (m.david@mdptws.com), 13/04/2004
      - Extension to proof of concept stylesheet. Not available for general download.
    -.-
    0.8.Basic: M. David Peterson (m.david@mdptws.com), 16/04/2004
      - Please reference aspectXML_basic_weave.xslt for release notes
    0.8.0.Advanced: M. David Peterson (m.david@mdptws.com), 16/04/2004
      - Proof of concept refocused on real world Aspect Oriented data sets
      - Designed to utilized one definition file, one instance file, and one output definition file.
      - Output format designed explicitly through the seperate output definition file.
      - Flexibility in output format without changing stylesheet layout and output
    0.8.1.Advanced: M. David Peterson (m.david@mdptws.com), 12/05/2004
      - Updated to use same aspectDefinition.xml file as Basic stylesheet
-->

<xsl:variable name="aspectDef" select="document('aspectDefinition.xml')"/>

<xsl:variable name="outputDef" select="document('aspectOutputDefinition.xml')"/>

<xsl:strip-space elements="*"/>

<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
  <xsl:apply-templates select="root/*"/>
</xsl:template>

<xsl:template match="*">
  <xsl:variable name="name" select="name()"/>
  <xsl:variable name="outputDef" select="$outputDef/output/definition[@type = $name]"/>
  <xsl:variable name="aspect" select="$aspectDef/aspects/aspect[@name = $outputDef/aspect/@name]"/>
  <xsl:element name="{$outputDef/aspect/element/@value}">
    <xsl:apply-templates select="$outputDef/aspect/element/*">
      <xsl:with-param name="adviceDef" select="$aspect/adviceDefinition"/>
      <xsl:with-param name="instance" select="*"/>
    </xsl:apply-templates>
  </xsl:element>
</xsl:template>

<xsl:template match="elements">
<xsl:param name="adviceDef"/>
<xsl:param name="instance"/>
<xsl:variable name="name" select="@name"/>
<xsl:variable name="type" select="@type"/>
<xsl:apply-templates select="$adviceDef/child::*[name() = $name][@type = $type]/adviceContents/*" mode="adviceContents"/>
</xsl:template>

<xsl:template match="element">
<xsl:param name="adviceDef"/>
<xsl:param name="instance"/>
<xsl:variable name="name" select="@name"/>
<xsl:variable name="type" select="@type"/>
<xsl:variable name="elementsName" select="elements/@name"/>
<xsl:variable name="elementsType" select="elements/@type"/>
<xsl:variable name="attributesName" select="attributes/@name"/>
<xsl:variable name="attributesType" select="attributes/@type"/>
<xsl:variable name="bindInstanceAndAround" select="$instance | $adviceDef/child::*[name() = $elementsName][@type = $elementsType]/adviceContents/*"/>
<xsl:variable name="countBIAA" select="count($bindInstanceAndAround)"/>
<xsl:variable name="countInstance" select="count($instance)"/>
<xsl:variable name="countDiff" select="$countBIAA - $countInstance"/>
<xsl:apply-templates select="$bindInstanceAndAround[position() &gt; $countDiff]" mode="adviceContents">
  <xsl:with-param name="attFlow" select="$adviceDef/child::*[name() = $attributesName][@type = $attributesType]/*"/>
</xsl:apply-templates>
</xsl:template>

<xsl:template match="*" mode="adviceContents">
<xsl:param name="attFlow"/>
  <xsl:element name="{name()}">
    <xsl:apply-templates select="xalan:nodeset($attFlow)"/>
    <xsl:value-of select="."/>
  </xsl:element>
</xsl:template>

<xsl:template match="attribute">
  <xsl:attribute name="{name}"><xsl:value-of select="value"/></xsl:attribute>
</xsl:template>

</xsl:stylesheet>
