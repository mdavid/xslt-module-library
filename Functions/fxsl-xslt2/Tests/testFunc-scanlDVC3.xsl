<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-scanlDVC.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>

  <!-- To be applied on testFunc-scanlDVC3.xml -->
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
  
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="set">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:for-each-group select="point" group-by="@x">
	      <xsl:sort select="current-grouping-key()" data-type="number"/>
		    <xsl:for-each select="f:scanl1(f:add(), current-group()/@y1)">
			      <point x="{current-group()[1]/@x}" y="{.}"/>
		    </xsl:for-each>
	    </xsl:for-each-group>
    </xsl:copy>
 </xsl:template>
</xsl:stylesheet>