<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform exclude-result-prefixes="atom atomic" version="2.0"
  xmlns="http://www.w3.org/1999/xhtml" xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:atomic="http://x2x2x.org/atomicxml/system" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="base" select="document('./base.atom')" />
  <xsl:variable name="xml.base" select="$base/atom:feed/@xml:base" />
  <xsl:strip-space elements="*" />
  <xsl:output doctype-public="-//W3C//DTD XHTML 1.1//EN"
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1.1.dtd" include-content-type="yes"
    indent="yes" media-type="text/html" method="xhtml" />
  <xsl:template match="/">
    <xsl:apply-templates select="atomic:system" />
  </xsl:template>
  <xsl:template match="atomic:system">
    <html>
      <head>
        <title>
          <xsl:value-of select="$base/atom:feed/atom:title" />
          <xsl:text> :: </xsl:text>
          <xsl:value-of select="$base/atom:feed/atom:subtitle" />
        </title>
        <style type="text/css">
          <xsl:apply-templates select="$base/atom:feed/atom:link[@type = 'text/css']" />
        </style>
        <xsl:comment>compliance patch for microsoft browsers</xsl:comment>
        <xsl:comment>
          <![CDATA[[if lt IE 7]>
		    <script src="scripts/ie7/ie7-standard-p.js" type="text/javascript"></script>
		  <![endif]]]>
        </xsl:comment>
      </head>
      <body>
        <ul id="{generate-id()}">
          <xsl:apply-templates select="$base/atom:feed/atom:entry/atom:content" />
        </ul>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="atom:link[@type = 'text/css']">
    <xsl:text>@import "</xsl:text>
    <xsl:value-of
      select="if (@rel = 'current') then concat($xml.base, @href) else concat(@rel, @href)" />
    <xsl:text>";</xsl:text>
    <xsl:text>
    </xsl:text>
  </xsl:template>
  <xsl:template match="atomic:module">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="atom:content">
    <li id="{if (@id) then (@id) else generate-id()}">
      <xsl:attribute name="class">
        <xsl:text>list</xsl:text>
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(@direction)" />
      </xsl:attribute>
      <xsl:apply-templates />
    </li>
  </xsl:template>
  <xsl:template match="atomic:list|atomic:menu|atomic:sequence">
    <ul id="{if (@id) then (@id) else generate-id()}">
      <xsl:attribute name="class">
        <xsl:text>list</xsl:text>
        <xsl:text> </xsl:text>
        <xsl:value-of select="concat(normalize-space(@direction), ' ', normalize-space(@style))" />
      </xsl:attribute>
      <xsl:apply-templates />
    </ul>
  </xsl:template>
  <xsl:template
    match="atomic:sequence[ancestor::atomic:module/@implements = 'text::structured@omx' or ancestor::atomic:sequence/@implements = 'text::structured@omx']">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template
    match="atomic:list[ancestor::atomic:module/@implements = 'text::structured@omx' or ancestor::atomic:sequence/@implements = 'text::structured@omx']">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="atomic:navigation">
    <ul id="{if (@id) then (@id) else generate-id()}">
      <xsl:if test="@type">
        <xsl:attribute name="class">
          <xsl:value-of select="@type" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </ul>
  </xsl:template>
  <xsl:template match="atomic:location">
    <ul id="{if (@id) then (@id) else generate-id()}">
      <xsl:if test="@type">
        <xsl:attribute name="class">
          <xsl:value-of select="@type" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </ul>
  </xsl:template>
  <xsl:template match="atomic:item">
    <li id="{if (@id) then (@id) else generate-id()}">
      <xsl:copy-of select="@*" />
      <xsl:apply-templates />
    </li>
  </xsl:template>
  <xsl:template match="atomic:separator">
    <xsl:text> </xsl:text>
    <xsl:value-of select="." />
    <xsl:text> </xsl:text>
  </xsl:template>
  <xsl:template match="atomic:item[@type = 'cdata']">
    <li id="{if (@id) then (@id) else generate-id()}">
      <!-- place holder -->
      <xsl:apply-templates />
    </li>
  </xsl:template>
  <xsl:template match="atomic:image[@type = 'a']">
    <li id="{if (@id) then (@id) else generate-id()}">
      <a href="{@href}">
        <img alt="{normalize-space(.)}" height="{@height}" src="{@src}" width="{@width}" />
      </a>
    </li>
  </xsl:template>
  <xsl:template match="atomic:image[@type = 'menuitem']">
    <li id="{if (@id) then (@id) else generate-id()}">
      <img alt="{normalize-space(.)}" height="{@height}" src="{@src}" width="{@width}" />
    </li>
  </xsl:template>
  <xsl:template match="atomic:image">
    <ul id="{if (@id) then (@id) else generate-id()}">
      <li id="{generate-id()}">
        <img alt="{normalize-space(.)}" height="{@height}" src="{@src}" width="{@width}" />
      </li>
    </ul>
  </xsl:template>
  <xsl:template match="atomic:a|atomic:link">
    <a href="{if (not(contains(@href ,'http://'))) then $xml.base else ()}{@href}"
      id="{if (@id) then (@id) else generate-id()}">
      <xsl:apply-templates />
    </a>
  </xsl:template>
  <xsl:template match="atomic:u">
    <u>
      <xsl:value-of select="normalize-space(.)" />
      <xsl:apply-templates />
    </u>
  </xsl:template>
  <xsl:template match="text()|atomic:string">
    <xsl:value-of select="." />
  </xsl:template>
  <xsl:template match="atomic:span">
    <span>
      <xsl:attribute name="class" select="@style" />
      <xsl:apply-templates />
    </span>
  </xsl:template>
</xsl:transform>
