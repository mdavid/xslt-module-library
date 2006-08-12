<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xsd xsi"
                version="1.0">
<xsl:variable name="userFile" select="document('attendanceTest.xml')"/>
<xsl:key name="fullName" match="student" use="@fullName"/>
<xsl:output method="xml" indent="yes"/>

<xsl:template match="main_Customer_data_file">
  <xsl:variable name="create_new_student_process">
    <xsl:element name="create_new_student_process">
        <xsl:apply-templates select="create_new_student_process"/>
    </xsl:element>
  </xsl:variable>
  <xsl:copy-of select="$create_new_customer_process"/>
</xsl:template>

<xsl:template match="create_new_student_process">
    <xsl:element name="students">
      <xsl:apply-templates select="$userFile//Attendance">
        <xsl:with-param name="studentSchema" select="studentSchema"/>
        <xsl:with-param name="student_id_generator" select="student_id_generator"/>
      </xsl:apply-templates>
    </xsl:element>
</xsl:template>

<xsl:template match="Attendance">
  <xsl:param name="studentSchema"/>
  <xsl:param name="student_id_generator"/>
  <xsl:variable name="studentDetails">
  <xsl:element name="fullName"><xsl:value-of select="concat(FirstName, ' ' , LastName"/></xsl:element>
    <xsl:element name="student">
      <xsl:attribute name="fullName"></xsl:attribute>
      <xsl:copy-of select="*"/>
    </xsl:element>
  </xsl:variable>
  <xsl:apply-templates select="$studentSchema" mode="schema">
    <xsl:with-param name="studentElements" select="*"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="customerSchema">
  
</xsl:template>

<xsl:template match="student_id_generator">
  <xsl:variable name="from" select="translate/from/@sequence"/>
  <xsl:variable name="to" select="translate/to/@sequence"/>
</xsl:template>
</xsl:stylesheet>
