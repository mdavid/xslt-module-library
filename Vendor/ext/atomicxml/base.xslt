<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns="http://www.w3.org/1999/xhtml" 
  xmlns:atom="http://www.w3.org/2005/Atom" 
  xmlns:omx="http://x2x2x.org/atomicxml/system"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="atom xs omx">

  <xsl:import href="./omx/omx.xsl"/>

  <xsl:variable name="xml.base" select="/atom:feed/@xml:base" />
  <xsl:variable name="css-base-class" select="'base'" as="xs:string" />

  <xsl:strip-space elements="*" />
  
  <xsl:output doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1.1.dtd" include-content-type="yes" indent="yes" media-type="text/html" method="xhtml" />
  
  <xsl:template match="/">
    <xsl:apply-templates select="atom:feed" />
  </xsl:template>
  
  <xsl:template match="atom:feed">
    <html>
      <head>
        <title>
          <xsl:value-of select="atom:title" />
          <xsl:text> :: </xsl:text>
          <xsl:value-of select="atom:subtitle" />
        </title>
        <xsl:apply-templates select="atom:link[@type = 'text/javascript']" />
        <style type="text/css">
          <xsl:apply-templates select="atom:link[@type = 'text/css']" />
        </style>
        <xsl:comment>compliance patch for microsoft browsers</xsl:comment>
        <xsl:comment>
          <![CDATA[[if lt IE 7]>
		        <script src="/scripts/ie7/ie7-standard-p.js" type="text/javascript"></script>
		      <![endif]]]>
        </xsl:comment>
      </head>
      <body>
        <ul id="{generate-id()}">
          <xsl:apply-templates select="atom:entry/atom:content" />
        </ul>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="atom:link[@type = 'text/css']">
    <xsl:text>
</xsl:text>
    <xsl:text>@import "</xsl:text>
    <xsl:value-of select="if (@rel = 'current') then concat($xml.base, @href) else concat(@rel, @href)" />
    <xsl:text>";</xsl:text>
  </xsl:template>
  
  <xsl:template match="atom:link[@type = 'text/javascript']">
    <xsl:text>
</xsl:text>
    <script src="{if (@rel = 'current') then concat($xml.base, @href) else concat(@rel, @href)}" type="text/javascript">
      <xsl:text>/* */</xsl:text>
    </script>
  </xsl:template>
  
  <xsl:template match="atom:content">
    <xsl:apply-templates select="document(@src)/atom:entry/atom:content/omx:module" />
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(.)" />
    <xsl:apply-templates />
  </xsl:template>
  
</xsl:transform>
