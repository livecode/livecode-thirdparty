{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libxslt',
			
			'dependencies':
			[
				'../libxml/libxml.gyp:libxml',
			],
			
			'conditions':
			[
				[
					'use_system_libxslt == 0 and use_prebuilt_thirdparty == 0',
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
							'include/libxslt',
							'src',
						],
						
						'sources':
						[
							'include/libxslt/attributes.h',
							'include/libxslt/config.h',
							'include/libxslt/documents.h',
							'include/libxslt/extensions.h',
							'include/libxslt/extra.h',
							'include/libxslt/functions.h',
							'include/libxslt/imports.h',
							'include/libxslt/keys.h',
							'include/libxslt/libxslt.h',
							'include/libxslt/namespaces.h',
							'include/libxslt/numbersInternals.h',
							'include/libxslt/pattern.h',
							'include/libxslt/preproc.h',
							'include/libxslt/security.h',
							'include/libxslt/templates.h',
							'include/libxslt/transform.h',
							'include/libxslt/trio.h',
							'include/libxslt/triodef.h',
							'include/libxslt/variables.h',
							'include/libxslt/win32config.h',
							'include/libxslt/xslt.h',
							'include/libxslt/xsltconfig.h',
							'include/libxslt/xsltexports.h',
							'include/libxslt/xsltInternals.h',
							'include/libxslt/xsltlocale.h',
							'include/libxslt/xsltutils.h',
							'include/libxslt/xsltwin32config.h',
							
							'src/attributes.c',
							'src/attrvt.c',
							'src/documents.c',
							'src/extensions.c',
							'src/extra.c',
							'src/functions.c',
							'src/imports.c',
							'src/keys.c',
							'src/namespaces.c',
							'src/numbers.c',
							'src/pattern.c',
							'src/preproc.c',
							'src/security.c',
							'src/templates.c',
							'src/transform.c',
							'src/variables.c',
							'src/xslt.c',
							'src/xsltlocale.c',
							'src/xsltutils.c',
						],
						
						'direct_dependent_settings':
						{
							'include_dirs':
							[
								'include',
							],
						},
					},
				],
				[
					'use_system_libxslt == 0 and use_prebuilt_thirdparty != 0',
					{
						# use prebuilt library
						'type': 'none',

						'dependencies':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_xslt',
						],

						'export_dependent_settings':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_xslt',
						],
					},
				],
				[
					'use_system_libxslt != 0',
					{
						# use system library
						'type': 'none',
						
						'link_settings':
						{
							'libraries':
							[
								'-lxslt',
							],
						},
					},
				],
			],
		},
	],
}
