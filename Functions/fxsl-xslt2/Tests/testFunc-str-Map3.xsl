<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"

 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:testmap="testmap"
exclude-result-prefixes="xs f"
>
 <xsl:import href="../f/func-concat2.xsl"/>
 <xsl:import href="../f/func-str-dvc-map.xsl"/>
 <xsl:import href="../f/func-flip.xsl"/>

 <!-- To be applied on text.xml -->
 <xsl:output omit-xml-declaration="yes" indent="yes"/>

 <xsl:template match="/">
   <xsl:sequence select=
    "f:str-map(f:flip(f:concat2(), '|'), string(/*))"
    />
 </xsl:template>
</xsl:stylesheet>