<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- NOTE:  obligatory opening xslt statements. Use of xalan namespace to enable serialization of strings and/or Result Tree Fragments (RTF's) into parseable node sets using the node-set() function.-->
	<!-- 

  Title:
    aspectXML version 0.8 Basic Weave XSLT Stylesheet
    
  Description:
    When used with XML data files that adhere to the Schema set forth by the aspectXML working group (see aspectXML.org for Schema details) this stylesheet will weave an aspectDefinition file with the matching elements and attributes found in an instance file
    
  License:
    Subject to the LGPL license, see www.aspectXML.org for details
    
  Versions:
    0.1: M. David Peterson, 11/04/2004
      - Proof of concept stylesheet. Not available for general download.(would be kind of 
    0.2: M. David Peterson, 13/04/2004
      - Extension to proof of concept stylesheet. Not available for general download.
    -.-
    0.8.Basic: M. David Peterson, 18/04/2004
      - Proof of concept refocused on real world Aspect Oriented data sets
      - Designed to utilized one definition file and one instance file.
      - Output format designed implicitly through the stylesheet
    0.8.Advanced: M. David Peterson, 16/04/2004
      - Please reference aspectXML_advanced_weave.xslt for release notes
    0.9.Basic: M. David Peterson 2005.09.06
    	- Ousted the XSLT 1.0 Xalan specific node-set() and updated the transformation file
    	to be compliant with the current 2.0 specification.  Now we have something we can begin
    	to build a foundation on top of. :)
-->
	<xsl:variable name="aspectDef" select="document('aspectDefinition.xml')"/>
	<!-- NOTE:  the 'aspectDef' variable is created and then asked to hold the document 'aspectDefinition.xml' so that we can later access it using '$aspectDef' and follow that with an XPath statemnt locatin the element(s) and/or attrbbutes you are currently in the market for -->
	<xsl:strip-space elements="*"/>
	<!-- NOTE:  this elements tells the XSLT processor to take all of the EXTRA spaces, tabs and line breaks and condense the document using one space between-->
	<xsl:key match="@name" name="distinctElement_pointcuts" use="."/>
	<!-- NOTE:  key are used for indexing and grouping sets of data with similar values.  the 'distinctElement_pointcuts' key has been set up now so that it is available to us at runtime.  Keep in mind that this doesnt mean that the key has been serialized with the data contained in the elements and attribute prescriped in the match and use attribute.  In fact at this stage we havent envoked our first template which means there are no elements or attributes currently in context.  This part of of the stylesheet was designed to sumply act as a place to gather our eggs and prepare for the upcoming big event(the transformation).  Once inside and we have gained some context to our surrounding we can envoke this key using the XPath key() function.  I will comment on that process when we get to ot.-->
	<xsl:output indent="yes" method="xml"/>
	<!-- NOTE:  using the xsl:output allows you control the format in which the results  are written  -->
	<xsl:template match="/">
		<xsl:apply-templates mode="instance" select="root/*"/>
	</xsl:template>
	<xsl:template match="*" mode="instance">
		<!-- NOTE:  All children nodes of 'root' will be processed by this template.  An element will be created that takes the name of the current context element as it own, copys any attributes of this same element into the context of the current output element, and then continues its recursive processing by taking each child element of the current context element and matching and matching each one two the appropriate template within this or any other imported stylesheet (which in this case there are none) -->
		<!-- 2005.09.09 10:10 AM GMT : Deleted xsl:value-of instruction element.  Not even sure why it was here... -->
		<xsl:element name="{name()}">
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates mode="element" select="*"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="*" mode="element">
		<!-- NOTE:  All elements that are processed by the apply-templates in the above template will match to this template.  We first create a variable called name and select it actual local-name as its value -->
		<xsl:variable name="name" select="local-name()"/>
		<xsl:variable name="pointcuts" select="$aspectDef/aspects/aspect/pointcut"/>
		<xsl:variable name="matchPointcut">
			<xsl:element name="element">
				<xsl:attribute name="name">
					<xsl:value-of select="$name"/>
				</xsl:attribute>
				<xsl:attribute name="matchPointcut">
					<xsl:value-of select="$pointcuts[unaryPointcutExpr/@pattern = $name]/@name"/>
				</xsl:attribute>
			</xsl:element>
			<xsl:apply-templates mode="matchAttributes" select="@*">
				<xsl:with-param name="pointcuts"
					select="$pointcuts[unaryPointcutExpr[substring-before(@pattern, '/') = $name]]"
				/>
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:apply-templates select="$aspectDef/aspects/aspect">
			<xsl:with-param name="matchedPointcut" select="$matchPointcut"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="@*" mode="matchAttributes">
		<xsl:param name="pointcuts"/>
		<xsl:variable name="name" select="local-name()"/>
		<xsl:variable name="matchPointcut"
			select="$pointcuts[substring-after(unaryPointcutExpr/@pattern, '@') = $name]"/>
		<!-- TODO: decide what to do if attribute name doesnt match to a pointcut value.  Options are A)Write it to output as normal with no value for pointcut.  B)Write it to output with default value for Pointcut. C)Do not write it to output at all.  I am currently using option A until a decision is made one way or the other as to what needs to be done.  Option B would require us to create an interal "lookup" table or an external XML file that contains a value to match it against and then output the proper pointcut name based on the match.  Both the internal lookup and external file are both viable options and both are fairly straight forward, easy to implement, and cheap. -->
		<xsl:element name="attribute">
			<xsl:attribute name="matchPointcut">
				<xsl:value-of select="$matchPointcut/@name"/>
			</xsl:attribute>
			<xsl:element name="name">
				<xsl:value-of select="$name"/>
			</xsl:element>
			<xsl:element name="value">
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:element name="operator">
				<xsl:value-of select="$matchPointcut/unaryPointcutExpr/@operator"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="aspect">
		<xsl:param name="matchedPointcut"/>
		<xsl:apply-templates select="adviceDefinition/elementAdvice">
			<xsl:with-param name="attributeAdvice" select="adviceDefinition/attributeAdvice"/>
			<xsl:with-param name="matchedPointcut" select="$matchedPointcut"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="elementAdvice[@type = 'before']">
		<xsl:param name="attributeAdvice"/>
		<xsl:param name="matchedPointcut"/>
		<xsl:variable name="name" select="@name"/>
		<xsl:variable name="reference" select="pointcut/namedPointcutExpr/@reference"/>
		<xsl:variable name="matchElementToReference" select="$matchedPointcut/element[@matchPointcut
			= $reference]/@name"/>
		<xsl:copy-of select="adviceContents/*"/>
		<xsl:element name="{$matchElementToReference}">
			<xsl:apply-templates select="$attributeAdvice[@name = $name]">
				<xsl:with-param name="matchedPointcutAttributes" select="$matchedPointcut/attribute"
				/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
	<xsl:template match="elementAdvice[@type = 'around']">
		<xsl:param name="attributeAdvice"/>
		<xsl:param name="matchedPointcut"/>
		<xsl:variable name="name" select="@name"/>
		<xsl:variable name="reference" select="pointcut/namedPointcutExpr/@reference"/>
		<xsl:variable name="matchElementToReference" select="$matchedPointcut/element[@matchPointcut
			= $reference]/@name"/>
		<xsl:apply-templates mode="aroundChildren" select="adviceContents/*">
			<xsl:with-param name="attributeAdvice" select="$attributeAdvice[@name = $name]"/>
			<xsl:with-param name="matchedPointcutAttributes" select="$matchedPointcut/attribute"/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="*" mode="aroundChildren">
		<xsl:param name="attributeAdvice"/>
		<xsl:param name="matchedPointcutAttributes"/>
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="$attributeAdvice">
				<xsl:with-param name="matchedPointcutAttributes" select="$matchedPointcutAttributes"
				/>
			</xsl:apply-templates>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="elementAdvice[@type = 'after']">
		<xsl:param name="attributeAdvice"/>
		<xsl:param name="matchedPointcut"/>
		<xsl:variable name="name" select="@name"/>
		<xsl:variable name="reference" select="pointcut/namedPointcutExpr/@reference"/>
		<xsl:variable name="matchElementToReference" select="$matchedPointcut/element[@matchPointcut
			= $reference]/@name"/>
		<xsl:element name="{$matchElementToReference}">
			<xsl:apply-templates select="$attributeAdvice[@name = $name]">
				<xsl:with-param name="matchedPointcutAttributes" select="$matchedPointcut/attribute"
				/>
			</xsl:apply-templates>
		</xsl:element>
		<xsl:copy-of select="adviceContents/*"/>
	</xsl:template>
	<xsl:template match="attributeAdvice[@type = 'flow']">
		<xsl:param name="matchedPointcutAttributes"/>
		<xsl:variable name="reference" select="pointcut/namedPointcutExpr/@reference"/>
		<xsl:apply-templates select="attribute | $matchedPointcutAttributes[@matchPointcut =
			$reference]"/>
	</xsl:template>
	<xsl:template match="attributeAdvice[@type = 'around']">
		<xsl:apply-templates select="attribute"/>
	</xsl:template>
	<xsl:template match="attribute">
		<xsl:attribute name="{name}">
			<xsl:value-of select="value"/>
		</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
