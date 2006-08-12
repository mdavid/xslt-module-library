<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:variable name="files" select="document('xfiles.xml')/*"/>

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>XaMeLeon Webtop Project - Early Alpha</title>
        <style type="text/css"><![CDATA[
        textarea {width:100%; height:60%; padding:2px;overflow: scroll;}
        a {display:block;cursor:pointer; color:#999; text-decoration: none; padding:1px 5px 1px 5px;font-weight:600; border-top:1px solid #ccc;  border-left:1px solid #ccc; border-right:1px solid #ccc;background:#fff; }
        a:hover{background:#ffe; color:#555 }
        .focus {background:#ffe; }
        .focus:hover{color:#111 }
        #target{background:#ffe;width:750px; border:1px solid #ccc; padding:15px; padding-right:10px; float:right;clear:both;z-index:20}
        #nav {float:right;margin-left:1px;display:block;cursor:pointer; color:#999; text-decoration: none;font-weight:600;}
        #topbar {position:relative;background:#fff; width:100%; padding:2px; height:20px;border-bottom:3px solid #b4cceb; border-top:3px solid #b4cceb; font-size:14px;}
        #topbar a {display:block;cursor:pointer;color:#333;text-decoration:none;padding:1px 5px 1px 5px;margin-bottom:20px;font-weight:600;background:#fff;float:left;position:relative;}
        #topbar a:hover{color:#933}
        ]]>
        </style>
        <script language="javascript" type="text/javascript" src="xslclient.js" />
      </head>
      <body onload="setDiv('{translate(substring-before($files//file[1]/@src, '.'), '-', '')}')">
        <div id="topbar">
          <div style="float:left;">
            <a href="#" onclick="changeDivVis('nav')">Change Flight Plan Format</a>
          </div>
          <div style="float:left; margin:0px 5px 0px 5px">
            <xsl:text>|</xsl:text>
          </div>
          <div style="float:left;">
            <a href="#" onclick="changeDivVis('psettings')">Edit Personal Settings</a>
          </div>
          <div style="float:right;">
            <a href="#" onclick="changeDivVis('help')">Access System Help</a>
          </div>
        </div>
        <div id="form-commands">
          <xsl:apply-templates select="$files//file" mode="nav"/>
        </div>

        <div id="target">
          <xsl:apply-templates select="$files//file" mode="body"/>
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="file" mode="nav">
    <div id="nav">
      <a href="#" onclick="changeDivVis('{translate(substring-before(@src, '.'), '-', '')}')">
        <xsl:value-of select="@src"/>
      </a>
    </div>
  </xsl:template>
  <xsl:template match="file" mode="body">
    <xsl:variable name="display">
      <xsl:choose>
        <xsl:when test="position() = 1">
          <xsl:text>inline</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>none</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="file" select="document(@src)"/>
    <div id="{translate(substring-before(@src, '.'), '-', '')}" style="display:{$display};">
      <h3>
        <xsl:value-of select="@src"/>
      </h3>
      <hr/>
      <textarea>
        <xsl:copy-of select="$file/*"/>
      </textarea>
    </div>
  </xsl:template>
</xsl:stylesheet>
