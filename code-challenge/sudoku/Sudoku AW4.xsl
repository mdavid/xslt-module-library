<xsl:stylesheet version="2.0"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:fn="sudoku">

<xsl:param name="board" select="$testBoard6"/>
<!--
<xsl:param name="board" select="(
1,0,0,  3,0,0,  6,0,0,
0,2,0,  5,0,0,  0,0,4,
0,0,9,  0,0,0,  5,2,0,

0,0,0,  9,6,3,  0,0,0,
7,1,6,  0,0,0,  0,0,0,
0,0,0,  0,8,0,  0,4,0,

9,0,0,  0,0,5,  3,0,7,
8,0,0,  4,0,6,  0,0,0,
3,5,0,  0,0,0,  0,0,1
)" as="xs:integer+"/>
-->

<xsl:param name="verbose" select="false()" as="xs:boolean"/>

<xsl:variable name="rowStarts" select="(1, 10, 19, 28, 37, 46, 55, 64, 73)" as="xs:integer+"/>
<xsl:variable name="topLeftGroup"     select="(1, 2, 3,     10, 11, 12,  19, 20, 21)" as="xs:integer+"/>
<xsl:variable name="topGroup"         select="(4, 5, 6,     13, 14, 15,  22, 23, 24)" as="xs:integer+"/>
<xsl:variable name="topRightGroup"    select="(7, 8, 9,     16, 17, 18,  25, 26, 27)" as="xs:integer+"/>
<xsl:variable name="midLeftGroup"     select="(28, 29, 30,  37, 38, 39,  46, 47, 48)" as="xs:integer+"/>
<xsl:variable name="center"           select="(31, 32, 33,  40, 41, 42,  49, 50, 51)" as="xs:integer+"/>
<xsl:variable name="midRightGroup"    select="(34, 35, 36,  43, 44, 45,  52, 53, 54)" as="xs:integer+"/>
<xsl:variable name="bottomLeftGroup"  select="(55, 56, 57,  64, 65, 66,  73, 74, 75)" as="xs:integer+"/>
<xsl:variable name="bottomGroup"      select="(58, 59, 60,  67, 68, 69,  76, 77, 78)" as="xs:integer+"/>
<xsl:variable name="bottomRightGroup" select="(61, 62, 63,  70, 71, 72,  79, 80, 81)" as="xs:integer+"/>

<xsl:function name="fn:getRow" as="xs:integer+">
 <xsl:param name="board" as="xs:integer+"/>
 <xsl:param name="index" as="xs:integer+"/>
 <xsl:variable name="rowStart" select="floor(($index - 1) div 9) * 9"/>
 <xsl:sequence select="$board[position() > $rowStart and position() &lt;= $rowStart + 9]"/>
</xsl:function>

<xsl:function name="fn:getCol" as="xs:integer+">
 <xsl:param name="board" as="xs:integer+"/>
 <xsl:param name="index" as="xs:integer+"/>
 <xsl:variable name="gap" select="($index - 1) mod 9"/>
 <xsl:variable name="colIndexes" select="for $x in $rowStarts return $x + $gap" as="xs:integer+"/>
 <xsl:sequence select="$board[some $x in position() satisfies $x = $colIndexes]"/>
</xsl:function>

<xsl:function name="fn:getGroup" as="xs:integer+">
 <xsl:param name="board" as="xs:integer+"/>
 <xsl:param name="index" as="xs:integer+"/>
 <xsl:choose>
  <xsl:when test="$index = $topLeftGroup">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $topLeftGroup]"/>
  </xsl:when>
  <xsl:when test="$index = $topGroup">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $topGroup]"/>
  </xsl:when>
  <xsl:when test="$index = $topRightGroup">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $topRightGroup]"/>
  </xsl:when>
  <xsl:when test="$index = $midLeftGroup">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $midLeftGroup]"/>
  </xsl:when>
  <xsl:when test="$index = $center">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $center]"/>
  </xsl:when>
  <xsl:when test="$index = $midRightGroup">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $midRightGroup]"/>
  </xsl:when>
  <xsl:when test="$index = $bottomLeftGroup">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $bottomLeftGroup]"/>
  </xsl:when>
  <xsl:when test="$index = $bottomGroup">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $bottomGroup]"/>
  </xsl:when>
  <xsl:when test="$index = $bottomRightGroup">
   <xsl:sequence select="$board[some $x in position() satisfies $x = $bottomRightGroup]"/>
  </xsl:when>
 </xsl:choose>
</xsl:function>

<xsl:function name="fn:getAllowedValues" as="xs:integer*">
 <xsl:param name="board" as="xs:integer+"/>
 <xsl:param name="index" as="xs:integer+"/>
 <xsl:variable name="existingValues" select="(fn:getRow($board, $index), fn:getCol($board, $index), fn:getGroup($board, $index))" as="xs:integer+"/>
 <xsl:sequence select="for $x in (1 to 9) return
                               if (not($x = $existingValues))
                                 then $x
                               else ()"/>
</xsl:function>

<xsl:function name="fn:tryValues" as="xs:integer*">
 <xsl:param name="board" as="xs:integer+"/>
 <xsl:param name="emptyCells" as="xs:integer+"/>
 <xsl:param name="possibleValues" as="xs:integer+"/>
 
 <xsl:variable name="index" select="$emptyCells[1]" as="xs:integer"/>
 <xsl:variable name="newBoard" select="($board[position() &lt; $index], $possibleValues[1], $board[position() > $index])" as="xs:integer+"/>
 
 <xsl:if test="$verbose">
  <xsl:message>Trying 
   <xsl:value-of select="$possibleValues[1]"/> out of a possible 
   <xsl:value-of select="$possibleValues"/> at index 
   <xsl:value-of select="$index"/>
  </xsl:message>
 </xsl:if>
 
 <xsl:variable name="result" select="fn:populateValues($newBoard, $emptyCells[position() != 1])" as="xs:integer*"/>
 
 <xsl:sequence select="if (empty($result)) then
                               if (count($possibleValues) > 1) then
                                 fn:tryValues($board, $emptyCells, $possibleValues[position() != 1])
                               else
                                 ()
                             else
                               $result"/>
</xsl:function>

<xsl:function name="fn:populateValues" as="xs:integer*">
 <xsl:param name="board" as="xs:integer+"/>
 <xsl:param name="emptyCells" as="xs:integer*"/>
 
 <xsl:choose>
  <xsl:when test="not(empty($emptyCells))">
   <xsl:variable name="index" select="$emptyCells[1]" as="xs:integer"/>
   <xsl:variable name="possibleValues" select="distinct-values(fn:getAllowedValues($board, $index))" as="xs:integer*"/>
   <xsl:choose>
    <xsl:when test="count($possibleValues) > 1">
     <xsl:sequence select="fn:tryValues($board, $emptyCells, $possibleValues)"/>
    </xsl:when>
    <xsl:when test="count($possibleValues) = 1">
     <xsl:variable name="newBoard" select="($board[position() &lt; $index], $possibleValues[1], $board[position() > $index])" as="xs:integer+"/>
     
     <xsl:if test="$verbose">
      <xsl:message>Only one value
       <xsl:value-of select="$possibleValues[1]"/> for index
       <xsl:value-of select="$index"/>
      </xsl:message>
     </xsl:if>
     
     <xsl:sequence select="fn:populateValues($newBoard, $emptyCells[position() != 1])"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:if test="$verbose">
      <xsl:message>! Cannot go any further !</xsl:message>
     </xsl:if>
     <xsl:sequence select="()"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:when>
  <xsl:otherwise>
   <xsl:message>Done!</xsl:message>
   <xsl:sequence select="$board"/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:function>

<xsl:function name="fn:solveSudoku" as="xs:integer+">
 <xsl:param name="startBoard" as="xs:integer+"/>
 
 <!-- First process the cells in the center column, then the sides starting with the 
      cells with the least number of options.  This gives much better performance 
      than starting top-left and working from there. -->
 <xsl:variable name="theSides" select="for $x in 1 to 81 return $x[not($x = $center)][not($x = $topGroup)][not($x = $bottomGroup)]" as="xs:integer+"/>
 
 <xsl:variable name="emptyCenterColumnCells" select="for $x in ($topGroup, $center, $bottomGroup) return if ($startBoard[$x] = 0) then $x else ()" as="xs:integer*"/>
 <xsl:variable name="emptySideCells" select="for $x in ($theSides) return if ($startBoard[$x] = 0) then $x else ()" as="xs:integer*"/>

 <xsl:variable name="theSidesOrdered" as="xs:integer+">
 	<xsl:for-each select="$emptySideCells">
 	  <xsl:sort select="count(fn:getAllowedValues($startBoard, .))" data-type="number" order="ascending"/>
 	  <xsl:sequence select="."/>
 	</xsl:for-each>
 </xsl:variable>
 
 <xsl:variable name="endBoard" select="fn:populateValues($startBoard, ($emptyCenterColumnCells, $theSidesOrdered))" as="xs:integer*"/>
 
 <xsl:choose>
  <xsl:when test="empty($endBoard)">
   <xsl:message>! Invalid board - The starting board is not correct</xsl:message>
   <xsl:sequence select="$startBoard"/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:sequence select="$endBoard"/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:function>

<xsl:template match="/" name="main">
 <xsl:call-template name="drawResult">
  <xsl:with-param name="board" select="fn:solveSudoku($board)"/>
 </xsl:call-template>
</xsl:template>

<xsl:template name="drawResult">
 <xsl:param name="board" as="xs:integer+"/>
 <html>
  <head>
   <title>Sudoku - XSLT</title>
   <style>
    table { border-collapse: collapse;
    border: 1px solid black; }
    td { padding: 10px; }
    .norm { border-left: 1px solid #CCC;
      border-top: 1px solid #CCC;}
    .csep { border-left: 1px solid black; }
    .rsep { border-top: 1px solid black; }
   </style>
  </head>
  <body>
   <xsl:call-template name="drawBoard">
    <xsl:with-param name="board" select="$board"/>
   </xsl:call-template>
  </body>
 </html>
</xsl:template>

<xsl:template name="drawBoard">
 <xsl:param name="board" as="xs:integer+"/>
 <table>
  <xsl:for-each select="1 to 9">
   <xsl:variable name="i" select="."/>
   <tr>
    <xsl:for-each select="1 to 9">
     <xsl:variable name="pos" select="(($i - 1) * 9) + ."/>
     <td class="{if (position() mod 3 = 1) then 'csep' else ('norm')} {if ($i mod 3 = 1) then 'rsep' else ('norm')}">
      <xsl:value-of select="$board[$pos]"/>
     </td>
    </xsl:for-each>
   </tr>
  </xsl:for-each>
 </table>
</xsl:template>

<!-- Easy board, 32 existing numbers -->
<xsl:variable name="testBoard1" select="(
0,2,0,  0,0,0,  0,3,6,
0,0,7,  4,0,0,  0,9,0,
0,0,5,  6,0,0,  0,4,8,

0,0,0,  9,3,0,  0,1,2,
2,9,0,  0,0,0,  0,7,5,
1,5,0,  0,8,2,  0,0,0,

6,7,0,  0,0,9,  1,0,0,
0,3,0,  0,0,7,  6,0,0,
4,8,0,  0,0,0,  0,2,0
)" as="xs:integer+"/>

<!-- Hard board, 24 existing numbers -->
<xsl:variable name="testBoard2" select="(
1,0,0,  5,6,0,  0,0,0,
9,0,0,  0,0,0,  2,0,8,
0,0,0,  0,0,0,  7,0,0,

0,8,0,  9,0,7,  0,0,2,
2,0,0,  0,0,0,  0,0,1,
6,0,0,  3,0,2,  0,4,0,

0,0,5,  0,0,0,  0,0,0,
4,0,3,  0,0,0,  0,0,9,
0,0,0,  0,4,1,  0,0,6
)" as="xs:integer+"/>

<!-- Extremely Hard board -->
<xsl:variable name="testBoard3" select="(
4,0,6,  7,8,0,  2,0,0,
0,5,7,  0,0,0,  0,0,0,
8,0,0,  0,0,0,  4,0,0,

0,0,0,  0,5,0,  0,9,0,
9,1,2,  0,0,0,  0,0,0,
0,4,0,  0,1,0,  0,0,3,

0,0,4,  3,0,0,  0,2,0,
7,0,3,  0,0,6,  0,0,0,
0,0,0,  5,0,7,  6,0,8
)" as="xs:integer+"/>

<!-- Fiendish board -->
<xsl:variable name="testBoard4" select="(
0,0,0,  0,0,5,  0,0,0,
0,0,0,  0,2,0,  9,0,0,
0,8,4,  9,0,0,  7,0,0,

2,0,0,  0,9,0,  4,0,0,
0,3,0,  6,0,2,  0,8,0,
0,0,7,  0,3,0,  0,0,6,

0,0,2,  0,0,9,  8,1,0,
0,0,6,  0,4,0,  0,0,0,
0,0,0,  5,0,0,  0,0,0
)" as="xs:integer+"/>

<xsl:variable name="testBoard5" select="(
0,2,0,0,0,0,0,8,0,
7,0,0,0,9,0,0,0,2,
0,0,8,7,0,3,5,0,0,

0,0,5,9,4,7,2,0,0,
0,4,0,5,0,8,0,3,0,
0,0,7,6,3,2,8,0,0,

0,0,2,3,0,9,4,0,0,
3,0,0,0,5,0,0,0,8,
0,9,0,0,0,0,0,7,0
)" as="xs:integer+"/>

<!-- Fiendish board 2-->
<xsl:variable name="testBoard6" select="(
0,0,0,0,0,5,1,0,0,
0,3,5,0,0,0,0,4,0,
8,0,0,4,0,0,0,2,0,

9,0,0,0,3,0,5,0,0,
0,0,0,2,0,8,0,0,0,
0,0,7,0,9,0,0,0,8,

0,5,0,0,0,9,0,0,2,
0,4,0,0,0,0,9,8,0,
0,0,1,7,0,0,0,0,0
)" as="xs:integer+"/>
<!-- Fiendish board ???-->
<xsl:variable name="testBoard7" select="(
  5,0,0,0,0,0,0,0,8,
  0,1,0,0,9,0,0,2,0,
  0,0,9,0,2,0,3,0,0,
  0,0,0,2,0,4,0,0,0,
  0,7,2,0,0,0,6,4,0,
  0,0,0,5,0,8,0,0,0,
  0,0,6,0,5,0,9,0,0,
  0,8,0,0,1,0,0,7,0,
  9,0,0,0,0,0,0,0,3
)" as="xs:integer+"/>
<!-- Fiendish board ????-->
<xsl:variable name="testBoard8" select="(
  1,0,0,0,0,0,0,0,5,
  0,3,0,0,2,0,0,7,0,
  0,0,5,0,9,0,1,0,0,
  0,0,0,2,0,8,0,0,0,
  0,2,7,0,0,0,6,4,0,
  0,0,0,3,0,4,0,0,0,
  0,0,8,0,1,0,5,0,0,
  0,7,0,0,4,0,0,2,0,
  6,0,0,0,0,0,0,0,3
)" as="xs:integer+"/>

<!-- Fiendish board 060301-->
<xsl:variable name="testBoard9" select="(
  0,0,5,1,0,0,0,0,0,
  0,3,0,0,6,0,8,9,0,
  0,6,0,0,8,4,0,0,1,
  0,0,2,0,7,0,0,0,5,
  0,7,6,4,0,8,1,3,0,
  3,0,0,0,5,0,7,0,0,
  1,0,0,6,4,0,0,7,0,
  0,9,8,0,1,0,0,4,0,
  0,0,0,0,0,5,6,0,0
)" as="xs:integer+"/>

<!-- Fiendish board 060302-->
<xsl:variable name="testBoard10" select="(
  0,5,0,0,0,8,0,0,0,
  0,7,0,0,0,9,4,8,1,
  0,6,0,0,0,3,0,0,0,
  6,3,2,0,0,0,0,0,0,
  0,0,0,0,1,0,0,0,0,
  0,0,0,0,0,0,9,2,7,
  0,0,0,5,0,0,0,7,0,
  5,9,4,7,0,0,0,1,0,
  0,0,0,8,0,0,0,6,0
)" as="xs:integer+"/>

<!-- Fiendish board 060303-->
<xsl:variable name="testBoard11" select="(
  0,0,5,0,9,0,4,0,0,
  1,0,0,0,0,0,0,0,5,
  0,0,9,0,1,0,8,0,0,
  0,4,0,0,0,0,0,1,0,
  9,0,0,2,8,7,0,0,3,
  0,5,0,0,0,0,0,2,0,
  0,0,4,0,5,0,1,0,0,
  8,0,0,0,0,0,0,0,6,
  0,0,6,0,3,0,9,0,0
)" as="xs:integer+"/>


<!-- Fiendish board 060304-->
<xsl:variable name="testBoard12" select="(
  5,0,0,0,0,9,7,0,0,
  0,2,0,0,8,0,0,5,0,
  0,0,3,0,0,0,0,6,0,
  0,0,0,5,9,7,4,0,0,
  0,0,0,0,0,0,0,0,0,
  0,0,2,4,3,1,0,0,0,
  0,7,0,0,0,0,5,0,0,
  0,9,0,0,6,0,0,1,0,
  0,0,6,9,0,0,0,0,2
)" as="xs:integer+"/>

<!-- Fiendish board 060305-->
<xsl:variable name="testBoard13" select="(
  0,0,0,0,5,0,0,0,0,
  0,0,1,0,6,0,2,0,0,
  0,9,0,7,0,8,0,6,0,
  0,0,4,0,2,0,9,0,0,
  2,7,0,6,0,4,0,1,5,
  0,0,5,0,8,0,4,0,0,
  0,3,0,9,0,1,0,2,0,
  0,0,9,0,4,0,6,0,0,
  0,0,0,0,3,0,0,0,0
)" as="xs:integer+"/>

<!-- Failing board, an erroneous 9 has been added at index 1 -->
<xsl:variable name="testBoard_Fail" select="(
9,2,0,  0,0,0,  0,3,6,
0,0,7,  4,0,0,  0,9,0,
0,0,5,  6,0,0,  0,4,8,

0,0,0,  9,3,0,  0,1,2,
2,9,0,  0,0,0,  0,7,5,
1,5,0,  0,8,2,  0,0,0,

6,7,0,  0,0,9,  1,0,0,
0,3,0,  0,0,7,  6,0,0,
4,8,0,  0,0,0,  0,2,0
)" as="xs:integer+"/>

</xsl:stylesheet>



