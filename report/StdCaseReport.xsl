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
				<fo:simple-page-master master-name="content" page-height="317mm" page-width="230mm" margin="10mm">
					<!--主体// -->
					<fo:region-body />
					<!--页脚// -->
					<fo:region-after extent="1cm" />
				</fo:simple-page-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="content">
				<!--页面主体内容 -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<!--报表头 -->
						<xsl:apply-templates select="CaseHeader" />
						<!--报表体(若有多个部分内容，参照下面一行重复) -->
						<xsl:apply-templates select="CaseBody" />
					</fo:block>
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!--报表头// -->
	<xsl:template match="CaseHeader">
		<fo:block height="100px">
			<fo:table table-layout="fixed" width="100%" text-align="center"
				border-after-width="0.5px" border-after-style="dotted">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="90px" />
				<fo:table-column column-width="400px" />
				<fo:table-column column-width="90px" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block height="80px" float="start" margin-top="5px">
								<fo:external-graphic src="{Icon}" width="80px"
									height="80px" content-width="80px" content-height="80px"
									display-align="center" text-align="center">
									<xsl:value-of select="Icon" />
								</fo:external-graphic>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block height="50px" margin-top="5px" font-size="20px"
								font-weight="bold" color="#337ab7">
								交城县天宁派出所案件报告
							</fo:block>
							<fo:block height="45px" float="start" margin-top="5px">
								<fo:block margin-top="20px" height="20px" color="#434344">
									<xsl:text>报告时间：</xsl:text>
									<fo:inline color="#337ab7" font-size="9px"
										padding-right="60px">
										<xsl:value-of select="Time" />
									</fo:inline>
									<xsl:text>案件编号：</xsl:text>
									<fo:inline color="#337ab7" font-size="9px">
										<xsl:value-of select="Code" />
									</fo:inline>
								</fo:block>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell>
							<fo:block width="80px" height="80px" float="end" margin-top="5px">
								<fo:block>
									<fo:external-graphic src="{QRCode}" width="80px"
										height="80px" content-width="80px" content-height="80px"
										float="end">
										<xsl:value-of select="QRCode" />
									</fo:external-graphic>
								</fo:block>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--报表第一页// -->
	<xsl:template match="CaseBody">
		<xsl:apply-templates select="CaseTable" />
		<xsl:apply-templates select="OfficialTable" />
		<xsl:apply-templates select="RelevantTable" />
		<xsl:apply-templates select="ArticlesTable" />
		<xsl:apply-templates select="RecordTable" />
		<xsl:apply-templates select="ArchiveTable" />
		<xsl:apply-templates select="SceneTable" />
	</xsl:template>

	<!--案件信息表格数据// -->
	<xsl:template match="CaseTable">
	<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7">案件基本信息</fo:block>
			
		<fo:block margin-top="10px" margin-left="10px" height="20px"
			color="#337ab7" font-weight="bold" font-size="14px">
			<xsl:text>案件名称：</xsl:text>
			<fo:inline color="#6b6c6c">
				<xsl:value-of select="Name" />
			</fo:inline>
		</fo:block>
		
		<fo:block margin-left="10px" font-size="10px">
			<fo:table table-layout="fixed" width="100%" text-align="start"  margin-left="0px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="270px" />
				<fo:table-column column-width="270px" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#337ab7">
								<xsl:text>案件卷宗号：</xsl:text>
								<fo:inline color="#6b6c6c">
									<xsl:value-of select="FileNo" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#337ab7">
								<xsl:text>办案单位：</xsl:text>
								<fo:inline color="#6b6c6c">
									<xsl:value-of select="Unit" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#337ab7">
								<xsl:text>保管位置：</xsl:text>
								<fo:inline color="#6b6c6c">
									<xsl:value-of select="Position" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#337ab7">
								<xsl:text>案件类型：</xsl:text>
								<fo:inline color="#6b6c6c">
									<xsl:value-of select="Type" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#337ab7">
								<xsl:text>案发时间：</xsl:text>
								<fo:inline color="#6b6c6c">
									<xsl:value-of select="StartTime" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#337ab7">
								<xsl:text>案件流转状态：</xsl:text>
								<fo:inline color="#6b6c6c">
									<xsl:value-of select="Status" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#337ab7">
								<xsl:text>结案时间：</xsl:text>
								<fo:inline color="#6b6c6c">
									<xsl:value-of select="EndTime" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		
		<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7">案件描述</fo:block>
		<fo:block margin-top="10px" line-height="20px" text-align="start" font-size="10px" border-width="0.5px" border-style="solid" color="#6b6c6c">
		<xsl:value-of select="Description" />
		</fo:block>
		
		<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7">关联案件</fo:block>
		<fo:block margin-top="10px" line-height="20px" text-align="start" font-size="10px" border-width="0.5px" border-style="solid" color="#6b6c6c">
		<xsl:value-of select="Relevant" />
		</fo:block>
	</xsl:template>
	
	<!--执法人员表格数据// -->
	<xsl:template match="OfficialTable">
	<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7">执法人员</fo:block>
	<fo:table table-layout="fixed" width="100%" text-align="center" margin-top="10px" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="15%" />
				<fo:table-column column-width="30%" />
				<fo:table-column column-width="15%" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#337AB7" color="white">
						<xsl:apply-templates select="Caption" />
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="Row" />
				</fo:table-body>
			</fo:table>
	</xsl:template>
	
	<!--涉案人员表格数据// -->
	<xsl:template match="RelevantTable">
	<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7"><xsl:value-of select="Title" /></fo:block>
	<fo:table table-layout="fixed" width="100%" text-align="center" margin-top="10px" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="8%" />
				<fo:table-column column-width="8%" />
				<fo:table-column column-width="8%" />
				<fo:table-column column-width="8%" />
				<fo:table-column column-width="24%" />
				<fo:table-column column-width="20%" />
				<fo:table-column column-width="24%" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#337AB7" color="white">
						<xsl:apply-templates select="Caption" />
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="Row" />
				</fo:table-body>
			</fo:table>
	</xsl:template>

	<!--涉案物品表格数据// -->
	<xsl:template match="ArticlesTable">
	<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7">涉案物品</fo:block>
	<fo:table table-layout="fixed" width="100%" text-align="center" margin-top="10px" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="20%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="5%" />
				
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#337AB7" color="white">
						<xsl:apply-templates select="Caption" />
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="Row" />
				</fo:table-body>
			</fo:table>
	</xsl:template>

	<!--涉案人员笔录档案表格数据// -->
	<xsl:template match="RecordTable">
	<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7">涉案人员笔录档案</fo:block>
	<fo:table table-layout="fixed" width="100%" text-align="center" margin-top="10px" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="20%" />
				<fo:table-column column-width="15%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#337AB7" color="white">
						<xsl:apply-templates select="Caption" />
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="Row" />
				</fo:table-body>
			</fo:table>
	</xsl:template>

	<!--涉案人员档案材料表格数据// -->
	<xsl:template match="ArchiveTable">
	<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7">涉案人员档案材料</fo:block>
	<fo:table table-layout="fixed" width="100%" text-align="center" margin-top="10px" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="20%" />
				<fo:table-column column-width="20%" />
				<fo:table-column column-width="30%" />
				<fo:table-column column-width="5%" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#337AB7" color="white">
						<xsl:apply-templates select="Caption" />
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="Row" />
				</fo:table-body>
			</fo:table>
	</xsl:template>
	
	<!--现场勘查表格数据// -->
	<xsl:template match="SceneTable">
	<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7">现场勘察</fo:block>
	<fo:table table-layout="fixed" width="100%" text-align="center" margin-top="10px" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="25%" />
				<fo:table-column column-width="20%" />
				<fo:table-column column-width="10%" />
				<fo:table-column column-width="5%" />
				<fo:table-column column-width="5%" />
				
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#337AB7" color="white">
						<xsl:apply-templates select="Caption" />
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="Row" />
				</fo:table-body>
			</fo:table>
	</xsl:template>
	
	<!--自定义表格数据// -->
	<xsl:template match="ExtraTable">
	<fo:block color="red" font-size="10px" height="20px" line-height="20px"
			margin-top="10px" margin-right="500px" border-after-width="0.5px"
			border-after-style="solid" border-after-color="#337AB7"><xsl:value-of select="Title" /></fo:block>
	<fo:table table-layout="fixed" width="100%" text-align="center" margin-top="10px" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->

				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#267DD2" color="white">
						<xsl:apply-templates select="Caption" />
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="Row" />
				</fo:table-body>
			</fo:table>
	</xsl:template>
	
	<!--表格每一行的模板// -->
	<xsl:template match="Row">
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<xsl:apply-templates select="Col" />
		</fo:table-row>
	</xsl:template>

	<xsl:template match="Caption">
		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="TH" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>

	<xsl:template match="Col">
		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="TD" />
			</fo:block>
		</fo:table-cell>
	</xsl:template>

</xsl:stylesheet>