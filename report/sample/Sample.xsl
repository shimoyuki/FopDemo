<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">

	<!-- 根元素 -->
	<xsl:template match="/">
		<xsl:apply-templates select="ItemListReport" />
	</xsl:template>

	<!--主模板// -->
	<xsl:template match="ItemListReport">
		<xsl:processing-instruction name="cocoon-format">
			type="text/xslfo"
		</xsl:processing-instruction>
		<!--在此可以定义一些全局的风格信息，如字体等 -->
		<fo:root font-family="SimSun" xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!--版面定义// -->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="first"
					margin-top="1cm" margin-bottom="1cm" margin-left="1cm"
					margin-right="1cm">
					<!--主体// -->
					<fo:region-body margin-top="1cm" margin-bottom="1cm" />
					<!--页眉// -->
					<fo:region-before extent="1cm" />
					<!--页脚// -->
					<fo:region-after region-name="footer-first" extent="1cm" />
				</fo:simple-page-master>
				<fo:simple-page-master master-name="rest"
					margin-top="1cm" margin-bottom="1cm" margin-left="1cm"
					margin-right="1cm">
					<!--主体// -->
					<fo:region-body margin-top="1cm" margin-bottom="1cm" />
					<!--页眉// -->
					<fo:region-before extent="1cm" />
					<!--页脚// -->
					<fo:region-after region-name="footer-rest" extent="1cm" />
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="document">
					<fo:repeatable-page-master-alternatives>
						<fo:conditional-page-master-reference
							page-position="first" master-reference="first" />
						<fo:conditional-page-master-reference
							page-position="rest" master-reference="rest" />
					</fo:repeatable-page-master-alternatives>
				</fo:page-sequence-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="document">
				页眉显示内容
				<fo:static-content flow-name="xsl-region-before">
					<fo:block font-size="10pt" text-align="end" line-height="12pt" background-color="#267DD2" color="white">PDF
						报表样例</fo:block>
					<fo:block text-align="end">
					</fo:block>
				</fo:static-content>
				<!--页脚显示内容 -->
				<fo:static-content flow-name="footer-first">
					<fo:block line-height="10pt" font-size="10pt" text-align="center">
						首页
					</fo:block>
				</fo:static-content>
				<fo:static-content flow-name="footer-rest">
					<fo:block line-height="10pt" font-size="10pt" text-align="center">
						共
						<fo:page-number-citation ref-id="endofdoc" />
						页
						<xsl:text>       </xsl:text>
						第
						<fo:page-number />
						页
					</fo:block>
				</fo:static-content>
				<!--页面主体内容 -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<!--报表头 -->
						<xsl:apply-templates select="ReportHeader" />
						<!--报表体(若有多个部分内容，参照下面一行重复) -->
						<xsl:apply-templates select="ReportBody" />
					</fo:block>
					<xsl:apply-templates select="ImageBody" />
					<fo:block break-before="page" />
					<fo:block>
					<!--报表尾 -->
					<xsl:apply-templates select="ReportFooter" />
					<fo:block break-before="page" />
					<fo:block break-before="page" />
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!--报表头// -->
	<xsl:template match="ReportHeader">
		<!--标题 -->
		<fo:block font-size="24pt" font-weight="bold" line-height="30pt"
			vertical-align="top" text-align-last="center" space-before.optimum="12pt">
			<xsl:value-of select="Title" />
		</fo:block>
		<!--用一个表格来格式化显示其余信息 -->
		<fo:block font-size="12pt">
			<fo:table table-layout="fixed" width="100%" border-collapse="separate">
				<fo:table-column column-width="1.3cm" />
				<fo:table-column column-width="17.7cm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell text-align="start">
							<fo:block>
								<xsl:text>甲方：</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell text-align="start">
							<fo:block>
								<xsl:value-of select="PartyA" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell text-align="start">
							<fo:block>
								<xsl:text>乙方：</xsl:text>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell text-align="start">
							<fo:block>
								<xsl:value-of select="PartyB" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="ImageBody">
	<fo:block>
		<fo:block font-family="Helvetica, sans" font-size="12pt">
		<fo:float float="start"><fo:block>
			<fo:external-graphic src="{Image}" width="5cm"
				height="4cm" content-width="4.9cm" content-height="3.9cm"
				display-align="center" text-align="center">
				<xsl:value-of select="Image" />
			</fo:external-graphic>
			</fo:block></fo:float>
			<fo:block  text-align="center" padding-before="1cm" line-height="1cm">
			<fo:inline font-weight="bold">
				Figure 16-1:
			</fo:inline>
			</fo:block>
			<fo:block  text-align="center" padding-after="1cm" line-height="1cm">
			The PDF file displayed in Netscape Navigator
			</fo:block>
		</fo:block>
		Although PDF files are themselves ASCII text,
		this isn't a book about PostScript, so there's
		nothing to be gained by showing you the exact
		output of the above command. If you're curious,
		open the PDF file in any text editor.
		Instead, Figure 16-1 shows the rendered file displayed in
		Netscape Navigator using the Acrobat plug-in.
	</fo:block>
</xsl:template>

	<!--报表主体（一般只有一个表格）// -->
	<xsl:template match="ReportBody">
		<xsl:apply-templates select="Table" />
	</xsl:template>

	<!--报表尾// -->
	<xsl:template match="ReportFooter">
		<fo:block font-size="12pt" line-height="15pt" text-align="start"
			space-before.optimum="12pt">
			<xsl:text>签订时间：</xsl:text>
			<xsl:value-of select="PrintDate" />
		</fo:block>
		<fo:block id="endofdoc"></fo:block>
		<fo:block font-family="Code39Seven" font-size="14px"
			line-height="18px">
			*
			<xsl:value-of select="ReportNo" />
			*
		</fo:block>
	</xsl:template>

	<!--表格数据// -->
	<xsl:template match="Table">
		<fo:block font-size="12pt">
			<fo:table table-layout="fixed" width="100%" border-collapse="separate"
				text-align="center" border-width="0.5pt" border-style="solid"
				space-before.optimum="12pt">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="4cm" />
				<fo:table-column column-width="8cm" />
				<fo:table-column column-width="7cm" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" font-size="13pt"
						border-width="0.5pt" border-style="solid">
						<fo:table-cell border-color="black" border-width="0.2pt"
							border-style="solid">
							<fo:block>图标</fo:block>
						</fo:table-cell>
						<fo:table-cell border-color="black" border-width="0.2pt"
							border-style="solid">
							<fo:block>条款名称</fo:block>
						</fo:table-cell>
						<fo:table-cell border-color="black" border-width="0.2pt"
							border-style="solid">
							<fo:block>录入时间</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="TableRow" />
				</fo:table-body>
			</fo:table>
		</fo:block>
		<fo:block space-before.optimum="20px">注意事项：……</fo:block>
	</xsl:template>

	<!--显示表格每一行的模板// -->
	<xsl:template match="TableRow">
		<fo:table-row space-before.optimum="3pt">
		<fo:table-cell border-color="black" border-width="0.2pt"
				border-style="solid">
		<fo:block>
		<fo:external-graphic src="{Image}" width="4cm"
				height="3cm" content-width="4cm" content-height="3cm"
				display-align="center" text-align="center">
				<xsl:value-of select="Image" />
			</fo:external-graphic>
		</fo:block>
		</fo:table-cell>
			<fo:table-cell border-color="black" border-width="0.2pt"
				border-style="solid">
				<fo:block>
					<xsl:value-of select="ItemName" />
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-color="black" border-width="0.2pt"
				border-style="solid">
				<fo:block>
					<xsl:value-of select="ItemTime" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
</xsl:stylesheet>