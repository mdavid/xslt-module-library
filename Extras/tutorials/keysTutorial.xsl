<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                version="1.0">
<xsl:strip-space elements="*"/>
<xsl:output method="html" indent="yes" encoding="iso-8859-1"/>
<xsl:key name="plans" match="benefit_plan" use="."/>

  <xsl:template match="form">
    <!-- obviously there is other code that goes here to transform the rest of the data, but I will leave that up to you -->
    <xsl:apply-templates select="page[@name = 'MEDICAL']"/>
    <!-- here is where you would put any data that is necessary to seperate the results of the the medical and dental transforms -->
    <br/>
    <xsl:apply-templates select="page[@name = 'DENTAL']"/>
    <!-- insert remaining transformation code that goes after DENTAL here -->
  </xsl:template>
  
  <xsl:template match="heading2">
    <!-- because heading2 is used for both medical and dental it makes sense to make it as a template -->
    <h2><xsl:value-of select="."/></h2>
  </xsl:template>
  
  <xsl:template match="pcp">
    <!-- now we will make two variables, one that contains only the name of the distinct benefit plans and one then contains a transformed version of the original XML that is grouped according to these distinct names -->
    <xsl:variable name="distinct_groups">
      <xsl:element name="distinct_groups">
        <!-- by using apply-templates along with our generate-id and key functions we can, again, allow the data to drive the transformation.  notice the use of "mode" as well.  this allows us to have multiple templates that match the same element name but are used for different purposes -->
        <xsl:apply-templates select="row[generate-id(benefit_plan) = generate-id(key('plans', benefit_plan))]/benefit_plan" mode="distinct_groups"/>
      </xsl:element>
    </xsl:variable>
    <xsl:variable name="grouped_content">
      <xsl:element name="grouped_content">
        <!-- with our distinct groups variable we can now take it and use it as the select attribute value of apply-templates.  Notice that use of the xalan:nodeset function.  Depending on what processor you use you will need to change the namespace decleration above to match what it requires to implement its version of nodeset and then change the xalan:nodeset to the proper namespace and name value.  e.g. Microsoft uses the "msxml" namespace as such .. msxsl="urn:schemas-microsoft-com:xslt" .. and you would replace xalan:nodeset with msxsl:node-set .-->
        <!-- note as well the use of the with-param to pass the full set of rows (using "*") along with each pass through the distinct_groups nodeset -->
        <xsl:apply-templates select="xalan:nodeset($distinct_groups)//benefit_plan" mode="group_related_rows">
          <xsl:with-param name="all_rows" select="*"/>
        </xsl:apply-templates>
      </xsl:element>
    </xsl:variable>
    <!-- with the resulting grouped RTF we can now use a simple apply-templates using xalan:nodeset to convert it to a nodeset that can be parsed normally by our processor -->
    <xsl:apply-templates select="xalan:nodeset($grouped_content)"/>
  </xsl:template>
  
  <xsl:template match="benefit_plan" mode="distinct_groups">
    <!-- in this template we simply copy the name of the benefit_plan to the attribute name plan and the plan_desc to the attribute name plan_desc.  This will allow us the ability to avoid conditional logic later on when we print out the name of the plan_desc for each group -->
    <xsl:copy>
        <xsl:attribute name="plan">
          <xsl:value-of select="."/>
        </xsl:attribute>
        <xsl:attribute name="plan_desc">
          <xsl:value-of select="following-sibling::plan_desc"/>
        </xsl:attribute>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="benefit_plan" mode="group_related_rows">
  <!-- now we take the rows we passed in the all_rows variable and compare each value the value of each element within our distinct group nodeset created in our last transformation.  If it makes a match it passes the RTF along to our next template to copy the elements and values into the correct group set -->
  <!-- keep in mind what is happeneing right now.  the processor just took the first value within our distinct groups XML data and matched it to this template.  So everything that happens within this template now will be associated with that element. -->
  <!-- so from within here we can apply-templates to the all_rows variable we passed along and create a nodeset of only those elements that match the value of the @plan attribute -->
  <!-- when the processor has finished going through each element of our distinct group dataset we will have all of our data matched and grouped into a nodeset that we can then parse without using any sort of logic.  We just use apply-templates and create templates that know each element -->
  <xsl:param name="all_rows"/>
  <xsl:variable name="plan" select="@plan"/>
    <xsl:copy>
      <xsl:attribute name="plan"><xsl:value-of select="@plan"/></xsl:attribute>
      <xsl:attribute name="plan_desc"><xsl:value-of select="@plan_desc"/></xsl:attribute>
      <xsl:apply-templates select="$all_rows[benefit_plan = $plan]" mode="group_related_rows"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="row" mode="group_related_rows">
  <!-- the processor goes through every row element within the all_rows variable from our preceding template and passed those that match our criteria to this template.  Now all we have to do is copy it into RTF --> 
    <row number="{@number}">
      <xsl:copy-of select="*"/>
    </row>
  </xsl:template>
  
  <!-- heres where the transformation of the finalized grouped XML will begin -->
  
  <xsl:template match="grouped_content">
    <!-- a simple apply-templates using the element benefit_plan will allow us to access each set of grouped data individually and transform the contents as a group -->
    <xsl:apply-templates select="benefit_plan"/>
  </xsl:template>
  
  <xsl:template match="benefit_plan">
    <table>
      <tr>
        <td colspan="2">
          <hr/>
        </td>
      </tr>
      <tr>
      <!-- because we copied the plan description name during the first phase of our transformation we dont need any conditional logic to test for it. So now we can just print it out into the first column of our table -->
        <td valign="top">
          <xsl:value-of select="@plan_desc"/>
        </td>
        <td valign="top">
        <!-- in the second column we can apply-templates to each row using the number attribute to sort them correctly -->
          <table>
            <xsl:apply-templates select="row" mode="plan_members">
              <xsl:sort select="@number"/>
            </xsl:apply-templates>
          </table>
        </td>
      </tr>
    </table>
  </xsl:template>
  
  <xsl:template match="row" mode="plan_members">
  <!-- each row is matched to this template which prints out the value of covrg_desc to a row within our column and thats it, transformation complete -->
    <tr>
      <td> | </td>
      <td>
        <xsl:value-of select="covrg_desc"/>
      </td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet>
