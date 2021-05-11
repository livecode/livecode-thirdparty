{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libiodbc',
			
			'conditions':
			[
				[
					'use_system_libiodbc == 0 and use_prebuilt_thirdparty == 0',
					{
						# build static library
						'type': 'static_library',
						
						'variables':
						{
							'library_for_module': 1,
							'silence_warnings': 1,
						},
						
						'include_dirs':
						[
							'include',
							'src',
							'src/inst',
							'src/trace',
						],
						
						'defines':
						[
							'HAVE_CONFIG_H',
						],
						
						'sources':
						[
							'include/iodbcunix.h',
							'include/sql.h',
							'include/sqlext.h',
							'include/sqltypes.h',
							'include/sqlucode.h',
							
							'src/config.h',
							'src/config.linux.h',
							'src/config.mac.ppc.h',
							'src/config.mac.x86.h',
							'src/dlproc.h',
							'src/hdbc.h',
							'src/hdesc.h',
							'src/henv.h',
							'src/herr.h',
							'src/hstmt.h',
							'src/iodbc.h',
							'src/iodbcadm.h',
							'src/iodbcext.h',
							'src/iodbcinst.h',
							'src/isql.h',
							'src/isqlext.h',
							'src/isqltypes.h',
							'src/ithread.h',
							'src/itrace.h',
							'src/odbcinst.h',
							'src/inst/dlf.h',
							'src/inst/inifile.h',
							'src/inst/iodbc_error.h',
							'src/inst/misc.h',
							'src/inst/unicode.h',
							'src/trace/proto.h',
							'src/trace/trace.h',
							
							'src/catalog.c',
							'src/connect.c',
							'src/dlproc.c',
							'src/execute.c',
							'src/fetch.c',
							'src/hdbc.c',
							'src/henv.c',
							'src/herr.c',
							'src/hstmt.c',
							'src/info.c',
							'src/main.c',
							'src/misc.c',
							'src/odbc3.c',
							'src/prepare.c',
							'src/result.c',
							'src/inst/dlf.c',
							'src/inst/Info.c',
							'src/inst/inifile.c',
							'src/inst/iodbc_error.c',
							'src/inst/misc.c',
							'src/inst/SQLConfigDataSource.c',
							'src/inst/SQLConfigDriver.c',
							'src/inst/SQLCreateDataSource.c',
							'src/inst/SQLGetAvailableDrivers.c',
							'src/inst/SQLGetConfigMode.c',
							'src/inst/SQLGetInstalledDrivers.c',
							'src/inst/SQLGetPrivateProfileString.c',
							'src/inst/SQLGetTranslator.c',
							'src/inst/SQLInstallDriver.c',
							'src/inst/SQLInstallDriverEx.c',
							'src/inst/SQLInstallDriverManager.c',
							'src/inst/SQLInstallerError.c',
							'src/inst/SQLInstallODBC.c',
							'src/inst/SQLInstallTranslator.c',
							'src/inst/SQLInstallTranslatorEx.c',
							'src/inst/SQLManageDataSource.c',
							'src/inst/SQLPostInstallerError.c',
							'src/inst/SQLReadFileDSN.c',
							'src/inst/SQLRemoveDefaultDataSource.c',
							'src/inst/SQLRemoveDriver.c',
							'src/inst/SQLRemoveDriverManager.c',
							'src/inst/SQLRemoveDSNFromIni.c',
							'src/inst/SQLRemoveTranslator.c',
							'src/inst/SQLSetConfigMode.c',
							'src/inst/SQLValidDSN.c',
							'src/inst/SQLWriteDSNToIni.c',
							'src/inst/SQLWritePrivateProfileString.c',
							'src/inst/unicode.c',
							'src/trace/AllocConnect.c',
							'src/trace/AllocEnv.c',
							'src/trace/AllocHandle.c',
							'src/trace/AllocStmt.c',
							'src/trace/BindCol.c',
							'src/trace/BindParameter.c',
							'src/trace/BrowseConnect.c',
							'src/trace/BulkOperations.c',
							'src/trace/Cancel.c',
							'src/trace/CloseCursor.c',
							'src/trace/ColAttribute.c',
							'src/trace/ColumnPrivileges.c',
							'src/trace/Columns.c',
							'src/trace/Connect.c',
							'src/trace/CopyDesc.c',
							'src/trace/DataSources.c',
							'src/trace/DescribeCol.c',
							'src/trace/DescribeParam.c',
							'src/trace/Disconnect.c',
							'src/trace/DriverConnect.c',
							'src/trace/Drivers.c',
							'src/trace/EndTran.c',
							'src/trace/Error.c',
							'src/trace/ExecDirect.c',
							'src/trace/Execute.c',
							'src/trace/ExtendedFetch.c',
							'src/trace/Fetch.c',
							'src/trace/FetchScroll.c',
							'src/trace/ForeignKeys.c',
							'src/trace/FreeConnect.c',
							'src/trace/FreeEnv.c',
							'src/trace/FreeHandle.c',
							'src/trace/FreeStmt.c',
							'src/trace/GetConnectAttr.c',
							'src/trace/GetConnectOption.c',
							'src/trace/GetCursorName.c',
							'src/trace/GetData.c',
							'src/trace/GetDescField.c',
							'src/trace/GetDescRec.c',
							'src/trace/GetDiagField.c',
							'src/trace/GetDiagRec.c',
							'src/trace/GetEnvAttr.c',
							'src/trace/GetFunctions.c',
							'src/trace/GetStmtAttr.c',
							'src/trace/GetStmtOption.c',
							'src/trace/GetTypeInfo.c',
							'src/trace/Info.c',
							'src/trace/MoreResults.c',
							'src/trace/NativeSql.c',
							'src/trace/NumParams.c',
							'src/trace/NumResultCols.c',
							'src/trace/ParamData.c',
							'src/trace/ParamOptions.c',
							'src/trace/Prepare.c',
							'src/trace/PrimaryKeys.c',
							'src/trace/ProcedureColumns.c',
							'src/trace/Procedures.c',
							'src/trace/PutData.c',
							'src/trace/RowCount.c',
							'src/trace/SetConnectAttr.c',
							'src/trace/SetConnectOption.c',
							'src/trace/SetCursorName.c',
							'src/trace/SetDescField.c',
							'src/trace/SetDescRec.c',
							'src/trace/SetEnvAttr.c',
							'src/trace/SetPos.c',
							'src/trace/SetScrollOptions.c',
							'src/trace/SetStmtAttr.c',
							'src/trace/SetStmtOption.c',
							'src/trace/SpecialColumns.c',
							'src/trace/Statistics.c',
							'src/trace/TablePrivileges.c',
							'src/trace/Tables.c',
							'src/trace/trace.c',
							'src/trace/Transact.c',
						],
						
						'direct_dependent_settings':
						{
							'include_dirs':
							[
								'include',
							],
						},
						
						'conditions':
						[
							[
								# Not used on Windows
								'OS == "win"',
								{
									'type': 'none',
								},
							],
						],
					},
				],
				[
					'use_system_libiodbc == 0 and use_prebuilt_thirdparty != 0',
					{
						# use prebuilt library
						'type': 'none',

						'dependencies':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_iodbc',
						],

						'export_dependent_settings':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_iodbc',
						],
					},
				],
				[
					'use_system_libiodbc != 0',
					{
						# use system library
						'type': 'none',
						
						'link_settings':
						{
							'libraries':
							[
								'-liodbc',
							],
						},
					},
				],
			],
		},
	],
}
