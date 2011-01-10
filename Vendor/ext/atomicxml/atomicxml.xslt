<xsl:transform exclude-result-prefixes="atomic" version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:atomic="http://x2x2x.org/atomicxml/system" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="xml.base" />
  <xsl:param name="css-base-class" />
  <xsl:template match="atomic:module">
    <li class="{if (@class) then (@class) else if (@type) then (@type) else $css-base-class}" id="{if (@id) then (@id) else generate-id()}">
      <xsl:apply-templates />
    </li>
  </xsl:template>
  <xsl:template match="atomic:list[@type = 'xhtml']">
    <ul id="{if (@id) then (@id) else generate-id()}">
      <xsl:attribute name="class">
        <xsl:text>list</xsl:text>
        <xsl:text> </xsl:text>
        <xsl:value-of select="normalize-space(@direction)" />
      </xsl:attribute>
      <xsl:apply-templates />
    </ul>
  </xsl:template>
  <xsl:template match="atomic:list">
    <ul id="{if (@id) then (@id) else generate-id()}">
      <xsl:attribute name="class">
        <xsl:text>list</xsl:text>
        <xsl:if test="@direction">
          <xsl:text> </xsl:text>
          <xsl:value-of select="normalize-space(@direction)" />
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates />
    </ul>
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
  <xsl:template match="atomic:image">
      <li id="{generate-id()}">
        <img alt="{normalize-space(.)}" height="{@height}" src="{@src}" width="{@width}" />
      </li>
  </xsl:template>
  <xsl:template match="atomic:a">
    <a href="{if (not(contains(@href ,'http://'))) then $xml.base else ()}{@href}" id="{if (@id) then (@id) else generate-id()}">
      <xsl:apply-templates />
    </a>
  </xsl:template>
  <xsl:template match="atomic:a[parent::atomic:item/@class = 'up' or ancestor::atomic:module/@id = 'location']">
    <a href="{if (not(contains(@href ,'http://'))) then $xml.base else ()}{@href}" id="{if (@id) then (@id) else generate-id()}">
      <xsl:value-of select="." />
    </a>
  </xsl:template>
  <xsl:template match="atomic:control">
    <label id="{if (@id) then (@id) else generate-id()}" onclick="{@onclick}">
      <xsl:value-of select="." />
    </label>
  </xsl:template>
  <xsl:template match="atomic:u">
    <u>
      <xsl:value-of select="normalize-space(.)" />
      <xsl:apply-templates />
    </u>
  </xsl:template>
  <xsl:template match="atomic:del">
    <del>
      <xsl:apply-templates />
    </del>
  </xsl:template>
  <xsl:template match="atomic:p">
    <p>
      <xsl:apply-templates />
    </p>
  </xsl:template>
  <xsl:template match="atomic:h2|atomic:h3">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="atomic:date">
    <label id="{if (@id) then (@id) else generate-id()}">
      <xsl:value-of select="format-date(current-date(), @format)" />
    </label>
  </xsl:template>
  <xsl:template match="atomic:script">
    <script type="{@type}" src="{@src}" />
  </xsl:template>
</xsl:transform>
