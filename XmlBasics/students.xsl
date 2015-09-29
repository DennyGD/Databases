<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template match="/students">
        <html>
            <body>
                <h1>Students</h1>
                <xsl:for-each select="student">
                    <div><xsl:value-of select="name"/></div>
                    <ul>
                        <li>
                            Birth date: <xsl:value-of select="birthDate"/>
                        </li>
                        <li>
                            Gender: <xsl:value-of select="gender"/>
                        </li>
                        <li>
                            Phone: <xsl:value-of select="phone"/>
                        </li>
                        <li>
                            E-mail: <xsl:value-of select="email"/>
                        </li>
                        <li>
                            Course: <xsl:value-of select="course"/>
                        </li>
                        <li>
                            Specialty: <xsl:value-of select="specialty"/>
                        </li>
                        <li>
                            Faculty number: <xsl:value-of select="facultyNumber"/>
                        </li>
                        <li>
                            Endorsements: <xsl:value-of select="endorsements"/>
                        </li>
                        <div><strong>Exams:</strong></div>
                        <xsl:for-each select="exams/exam">
                            <em><xsl:value-of select="name"/></em>
                            <ul>
                                <li>
                                    Tutor: <xsl:value-of select="tutor"/>
                                </li>
                                <li>
                                   Score: <xsl:value-of select="score"/>
                                </li>
                            </ul>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>