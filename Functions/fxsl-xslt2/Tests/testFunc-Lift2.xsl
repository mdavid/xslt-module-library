<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:func-transform2="f:func-transform2"
exclude-result-prefixes="f func-transform2"
>
   <xsl:import href="../f/func-lift.xsl"/>
   <xsl:import href="../f/func-Operators.xsl"/>
   <xsl:import href="../f/func-projection.xsl"/>
   <xsl:import href="../f/func-compose.xsl"/>
   <xsl:import href="../f/func-hex-to-decimal.xsl"/>

   <!-- to be applied on testTransform-and-sum2.xml -->
   
   <xsl:output method="text"/>
   
    <xsl:template match="/">
      <xsl:value-of select=
      "f:lift2(f:add(),
               f:compose(f:hex-to-decimal(),f:first()),
               f:compose(f:hex-to-decimal(),f:second()),
               /*/*
               )"
      />
    </xsl:template>
</xsl:stylesheet>