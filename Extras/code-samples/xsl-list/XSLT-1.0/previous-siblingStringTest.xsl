<?xml version='1.0' encoding='UTF-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:strip-space elements="*"/>
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/newsletter/content/article">
	<hr/>
	<xsl:if test="contains(metadata/article-classification, 'Biz-Webcast')">
      <xsl:variable name="checkString">
        <xsl:for-each select="preceding-sibling::article/metadata/article-classification">
          <xsl:value-of select="."/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:if test="not(contains($checkString, 'Biz-Webcast'))">
        This is the first instance of the element article/metadata/article-classification that contains the string 'Biz-Webcast'.
      </xsl:if>
    </xsl:if>
	<xsl:value-of select="metadata/article-classification"/>
	<hr/>
</xsl:template>
</xsl:stylesheet><!-- Stylus Studio meta-information - (c)1998-2004. Sonic Software Corporation. All rights reserved.
<metaInformation>
<scenarios ><scenario default="yes" name="Scenario1" userelativepaths="yes" externalpreview="no" url="tempStringTest.xml" htmlbaseurl="" outputurl="" processortype="saxon7" profilemode="7" profiledepth="" profilelength="" urlprofilexml="" commandline="" additionalpath="" additionalclasspath="" postprocessortype="none" postprocesscommandline="" postprocessadditionalpath="" postprocessgeneratedext=""/></scenarios><MapperMetaTag><MapperInfo srcSchemaPathIsRelative="yes" srcSchemaInterpretAsXML="no" destSchemaPath="" destSchemaRoot="" destSchemaPathIsRelative="yes" destSchemaInterpretAsXML="no" ><SourceSchema srcSchemaPath="tempStringTest.xml" srcSchemaRoot="newsletter" AssociatedInstance="" loaderFunction="document" loaderFunctionUsesURI="no"/></MapperInfo><MapperBlockPosition><template match="/newsletter/content/article"><block path="xsl:if/contains[0]" x="151" y="0"/><block path="xsl:if" x="197" y="0"/><block path="xsl:if/xsl:if" x="307" y="0"/><block path="" x="257" y="0"/><block path="xsl:value&#x2D;of" x="137" y="0"/><block path="xsl:if[1]/contains[0]" x="151" y="38"/><block path="xsl:if[1]" x="197" y="40"/><block path="xsl:if[1]/xsl:if" x="27" y="0"/><block path="xsl:value&#x2D;of[1]" x="257" y="40"/><block path="xsl:if[2]/contains[0]" x="31" y="38"/><block path="xsl:if[2]" x="77" y="40"/><block path="xsl:if[2]/xsl:if" x="147" y="40"/><block path="xsl:value&#x2D;of[2]" x="17" y="40"/><block path="xsl:if[3]/contains[0]" x="151" y="78"/><block path="xsl:if[3]" x="197" y="80"/><block path="xsl:if[3]/xsl:if" x="307" y="80"/><block path="xsl:value&#x2D;of[3]" x="137" y="80"/><block path="xsl:if[4]/contains[0]" x="151" y="118"/><block path="xsl:if[4]" x="197" y="120"/><block path="xsl:if[4]/xsl:if" x="27" y="80"/><block path="xsl:value&#x2D;of[4]" x="257" y="120"/><block path="xsl:if[5]/contains[0]" x="31" y="118"/><block path="xsl:if[5]" x="77" y="120"/><block path="xsl:if[5]/xsl:if" x="147" y="120"/><block path="xsl:value&#x2D;of[5]" x="17" y="120"/></template></MapperBlockPosition></MapperMetaTag>
</metaInformation>
-->
