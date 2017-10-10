<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" />
    <xsl:template name="collection_type">
        <details open="open">
            <summary>
                <img src="images/allow.png" class="icon" />
                <xsl:value-of select="./@allowDenyText" />
            </summary>
            <div class="level2">
                <img src="images/group.png" class="icon" />
                Applies To: <xsl:value-of select="./@users" /><br />
				<details open="open">
				    <summary><img src="images/condition.png" class="icon" />Conditions</summary>
					<div class="level3">
					    <xsl:for-each select="./Condition">
						    <xsl:choose>
							    <xsl:when test="@type='HASH'">
								    <img src="images/hash.png" class="icon" /><strong>Source: </strong><xsl:value-of select="./@sourceFile" /><strong> Size: </strong><xsl:value-of select="./@size" /><strong> Hash: </strong><xsl:value-of select="./@SHA256Authenticode" /><br />
								</xsl:when>
								<xsl:when test="@type='PUBLISHER'">
								    <img src="images/publisher.png" class="icon" /><strong>Publisher: </strong><xsl:value-of select="./@publisher" /><strong> Binary: </strong><xsl:value-of select="./@binary" /><strong> Product: </strong><xsl:value-of select="./@product" /><br />
								</xsl:when>
								<xsl:when test="@type='PATH'">
								    <img src="images/path.png" class="icon" /><strong>Path: </strong><xsl:value-of select="./@path" /><br />
								</xsl:when>
							</xsl:choose>
						</xsl:for-each>
					</div>
				</details>
			</div>
        </details>
        <br />
    </xsl:template>
    <xsl:template match="/">
        <html>
            <head>
                <link href="https://fonts.googleapis.com/css?family=Raleway:400,300,600" rel="stylesheet" type="text/css" />
                <link rel="stylesheet" href="css/normalize.css" />
                <link rel="stylesheet" href="css/skeleton.css" />
                <link rel="stylesheet" href="css/xsl.css" />
            </head>
            <body>
                <div class="container">
                    <h1>AirLock Digital - AppLocker Auditor</h1>
                    <div class="row">
                        <div class="twelve columns">
                            <h2>ISM Control Summary</h2>
                            <xsl:for-each select="AIRLOCKAUDITOR/ISMCONTROLS/Control">
                                <h3>Control: <xsl:value-of select="./@Test" /></h3>
                                <p>
                                    <xsl:value-of select="./@Text" />
                                </p>
                            </xsl:for-each>
                        </div>
                    </div>
                    <div class="row">
                        <div class="twelve columns" style="margin-top: 5%">
                            <h2>Rules</h2>
							<h3>Icon Legend</h3>
						</div>
						<div class="three columns">
						    <img src="images/user.png" class="icon" />User<br />
						    <img src="images/group.png" class="icon" />Group<br />   
						</div>
						<div class="three columns">
						    <img src="images/path.png" class="icon" />Path Rule<br />
						    <img src="images/hash.png" class="icon" />Hash Rule<br />
						    <img src="images/publisher.png" class="icon" />Publisher Rule<br />
							<img src="images/condition.png" class="icon" />Condition<br />
						</div>
						<div class="three columns">
						    <img src="images/allow.png" class="icon" />Allow Rule<br />
						    <img src="images/deny.png" class="icon" />Deny Rule<br />
						    <img src="images/exception.png" class="icon" />Exception<br />
						</div>
						<div class="twelve columns">
						<h3>Rule Categories</h3>
                            <details>
                                <summary>Executables</summary>
                                <div class="level1">
                                    <xsl:for-each select="AIRLOCKAUDITOR/APPLOCKER/EXECollection/Rule">
                                        <xsl:call-template name="collection_type" />
                                    </xsl:for-each>
                                </div>
                            </details>
                            <details>
                                <summary>DLL</summary>
                                <div class="level1">
                                    <xsl:for-each select="AIRLOCKAUDITOR/APPLOCKER/DLLCollection/Rule">
                                        <xsl:call-template name="collection_type" />
                                    </xsl:for-each>
                                </div>
                            </details>
                            <details>
                                <summary>MSI</summary>
                                <div class="level1">
                                    <xsl:for-each select="AIRLOCKAUDITOR/APPLOCKER/MSICollection/Rule">
                                        <xsl:call-template name="collection_type" />
                                    </xsl:for-each>
                                </div>
                            </details>
                            <details>
                                <summary>Script</summary>
                                <div class="level1">
                                    <xsl:for-each select="AIRLOCKAUDITOR/APPLOCKER/SCRIPTCollection/Rule">
                                        <xsl:call-template name="collection_type" />
                                    </xsl:for-each>
                                </div>
                            </details>
                        </div>
                    </div>
                    <div class="row">
                        <div class="twelve columns" style="margin-top: 5%">
                            <h2>Execution Results</h2>
                            <table class="u-max-full-width" style="font-size:0.8em;">
                                <thead>
                                    <tr>
                                        <th>Path</th>
                                        <th>EXE</th>
                                        <th>DLL</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:for-each select="AIRLOCKAUDITOR/EXECUTIONTESTRESULTS/ExecutionResult[(@EXE='Executed') or (@DLL='Executed')]">
                                        <xsl:sort select="@EXE"/>
										<xsl:variable name="css-class">
                                            <xsl:choose>
                                                <xsl:when test="@EXE='Executed'">error</xsl:when>
                                                <xsl:when test="@DLL='Executed'">warning</xsl:when>
                                                <xsl:otherwise>info</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>
                                        <tr class="{$css-class}">
                                            <td style="max-width:750px; word-wrap: break-word;">
                                                <xsl:value-of select="./@FolderPath" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="./@EXE" />
                                            </td>
                                            <td>
                                                <xsl:value-of select="./@DLL" />
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>