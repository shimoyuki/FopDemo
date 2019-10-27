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
		<fo:block width="760px" height="142px" margin-left="12px" background-image="{Banner}" background-repeat ="no-repeat" font-size="10px">
			<fo:block margin-top="90px" height="20px" margin-bottom="35px" margin-left="120px" color="#22608e">
			<xsl:text>报告时间：</xsl:text>
			<fo:inline color="#717273" padding-right="160px"><xsl:value-of select="Time" /></fo:inline>
			<xsl:text>案件编号：</xsl:text>
			<fo:inline color="#717273"><xsl:value-of select="Code" /></fo:inline>
			</fo:block>
		</fo:block>
	</xsl:template>

	<!--报表第一页// -->
	<xsl:template match="CaseBody">
		<xsl:apply-templates select="CaseTable" />
		<xsl:apply-templates select="RelevantTable" />
	</xsl:template>

	<!--案件信息表格数据// -->
	<xsl:template match="CaseTable">
		<fo:block margin-top="10px" margin-left="12px" height="25px"
			color="#717273" font-weight="bold" font-size="12px">
			<xsl:text>案件名称：</xsl:text>
			<fo:inline>
				<xsl:value-of select="Name" />
			</fo:inline>
		</fo:block>
		<fo:block margin-left="12px" font-size="10px">
			<fo:table table-layout="fixed" width="100%" text-align="start">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="180px" />
				<fo:table-column column-width="180px" />
				<fo:table-column column-width="180px" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#1d6495">
								<xsl:text>案件卷宗号：</xsl:text>
								<fo:inline color="#666">
									<xsl:value-of select="FileNo" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#1d6495">
								<xsl:text>保管位置：</xsl:text>
								<fo:inline color="#666">
									<xsl:value-of select="Position" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#1d6495">
								<xsl:text>案发时间：</xsl:text>
								<fo:inline color="#666">
									<xsl:value-of select="StartTime" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#1d6495">
								<xsl:text>结案时间：</xsl:text>
								<fo:inline color="#666">
									<xsl:value-of select="EndTime" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#1d6495">
								<xsl:text>案件状态：</xsl:text>
								<fo:inline color="#666">
									<xsl:value-of select="Status" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-top="5px" line-height="20px" color="#1d6495">
								<xsl:text>案件类型：</xsl:text>
								<fo:inline color="#666">
									<xsl:value-of select="Type" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		<fo:block height="20px" margin-left="12px" margin-right="12px" margin-top="20px" text-align="center" font-size="10px" background-color="#00a0e9" color="#fff">案件描述</fo:block>
		<fo:block height="120px" content-height="120px" line-height="20px" margin-left="12px" margin-right="12px" text-align="start" font-size="10px" border-width="0.2px" border-style="solid" border-color="#00a0e9">
		<xsl:value-of select="Content" />
		</fo:block>
	</xsl:template>

	<!--相关人员表格数据// -->
	<xsl:template match="RelevantTable">
		<fo:block height="20px" margin-left="12px" margin-right="12px"
			margin-top="20px" text-align="center" font-size="10px"
			background-color="#00a0e9" color="#fff">相关人员</fo:block>
		<fo:block font-size="10px" margin-left="12px" margin-right="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="10px" border-after-width="0.2px" border-after-style="solid"
				border-after-color="#00a0e9">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="90px" />
				<fo:table-column column-width="480px" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row border-after-width="0.2px" border-after-style="solid" border-after-color="#00a0e9">
						<fo:table-cell>
							<fo:block margin-top="10px">
								<fo:external-graphic src="{PolicePhoto}"
									width="80px" height="80px" content-width="80px"
									content-height="80px">
									<xsl:value-of select="PolicePhoto" />
								</fo:external-graphic>
							</fo:block>
							<fo:block height="20px" text-align="start" font-size="8px"
								color="#00a0e9">
								侦办人员
								<fo:inline padding-left="10px">(</fo:inline>
								<fo:inline color="black">
									<xsl:value-of select="PoliceNumber" />
								</fo:inline>
								)
							</fo:block>
						</fo:table-cell>

						<fo:table-cell>
							<fo:block font-size="10px">
								<fo:table table-layout="fixed" width="100%" text-align="start">
									<!-- 定义列（与实际列数严格一致） // -->
									<fo:table-column column-width="80px" />
									<fo:table-column column-width="400px" />
									<!-- 表格数据 // -->
									<fo:table-body>
										<fo:table-row border-after-width="0.2px" border-after-style="solid" border-after-color="#00a0e9">
											<fo:table-cell>
												<fo:block height="30px" line-height="30px"
													text-align="start" font-size="14px" color="#00a0e9">
													组长
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block height="30px" line-height="30px"
													text-align="start" font-size="14px">
													<xsl:value-of select="Leader" />
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell>
												<fo:block height="30px" line-height="30px"
													text-align="start" font-size="14px" color="#00a0e9">
													组员
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block height="60px" line-height="30px"
													text-align="start" font-size="14px">
													<xsl:value-of select="Members" />
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
					
					<fo:table-row border-after-width="0.2px" border-after-style="solid" border-after-color="#00a0e9">
						<fo:table-cell>
							<fo:block margin-top="10px">
								<fo:external-graphic src="{SuspectPhoto}"
									width="80px" height="80px" content-width="80px"
									content-height="80px">
									<xsl:value-of select="SuspectPhoto" />
								</fo:external-graphic>
							</fo:block>
							<fo:block height="20px" text-align="start" font-size="8px"
								color="#00a0e9">
								嫌疑人
								<fo:inline padding-left="18px">(</fo:inline>
								<fo:inline color="black">
									<xsl:value-of select="SuspectNumber" />
								</fo:inline>
								)
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-left="20px">
							<fo:block height="60px" line-height="30px"
													text-align="start" font-size="14px">
													<xsl:value-of select="Suspects" />
												</fo:block>
						</fo:table-cell>
					</fo:table-row>
					
					<fo:table-row border-after-width="0.2px" border-after-style="solid" border-after-color="#00a0e9">
						<fo:table-cell>
							<fo:block margin-top="10px">
								<fo:external-graphic src="{WitnessPhoto}"
									width="80px" height="80px" content-width="80px"
									content-height="80px">
									<xsl:value-of select="WitnessPhoto" />
								</fo:external-graphic>
							</fo:block>
							<fo:block height="20px" text-align="start" font-size="8px"
								color="#00a0e9">
								证人
								<fo:inline padding-left="26px">(</fo:inline>
								<fo:inline color="black">
									<xsl:value-of select="WitnessNumber" />
								</fo:inline>
								)
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-left="20px">
							<fo:block height="60px" line-height="30px"
													text-align="start" font-size="14px">
													<xsl:value-of select="Witnesses" />
												</fo:block>
						</fo:table-cell>
					</fo:table-row>
					
					<fo:table-row border-after-width="0.2px" border-after-style="solid" border-after-color="#00a0e9">
						<fo:table-cell>
							<fo:block margin-top="10px">
								<fo:external-graphic src="{VictimPhoto}"
									width="80px" height="80px" content-width="80px"
									content-height="80px">
									<xsl:value-of select="VictimPhoto" />
								</fo:external-graphic>
							</fo:block>
							<fo:block height="20px" text-align="start" font-size="8px"
								color="#00a0e9">
								被害人
								<fo:inline padding-left="18px">(</fo:inline>
								<fo:inline color="black">
									<xsl:value-of select="VictimNumber" />
								</fo:inline>
								)
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-left="20px">
							<fo:block height="60px" line-height="30px"
													text-align="start" font-size="14px">
													<xsl:value-of select="Victims" />
												</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

</xsl:stylesheet>