{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libz',

			'toolsets': ['host', 'target'],
			
			'conditions':
			[
				[
					'use_system_libz == 0 and use_prebuilt_thirdparty == 0',
					{
						# build static library
						'type': 'static_library',
						
						'product_prefix': '',
						'product_name': 'libz',
						
						'variables':
						{
							'library_for_module': 1,
							'silence_warnings': 1,
						},
						
						'include_dirs':
						[
							'include',
							'src',
						],
						
						'sources':
						[
							'include/zconf.h',
							'include/zlib.h',
							
							'src/crc32.h',
							'src/deflate.h',
							'src/gzguts.h',
							'src/inffast.h',
							'src/inffixed.h',
							'src/inflate.h',
							'src/inftrees.h',
							'src/trees.h',
							'src/zutil.h',
							
							'src/adler32.c',
							'src/compress.c',
							'src/crc32.c',
							'src/deflate.c',
							'src/gzclose.c',
							'src/gzlib.c',
							'src/gzread.c',
							'src/gzwrite.c',
							'src/infback.c',
							'src/inffast.c',
							'src/inflate.c',
							'src/inftrees.c',
							'src/trees.c',
							'src/uncompr.c',
							'src/zutil.c',
						],
						
						'direct_dependent_settings':
						{
							'include_dirs':
							[
								'include',
							],
						},
						
						'target_conditions':
						[
							[
								'_toolset != "target"',
								{
									'product_name': 'libz->(_toolset)',
								},
							],
						],
					},
				],
				[
					'use_system_libz == 0 and use_prebuilt_thirdparty != 0',
					{
						# use prebuilt library
						'type': 'none',

						'dependencies':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_z',
						],

						'export_dependent_settings':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_z',
						],
					},
				],
				[
					'use_system_libz != 0',
					{
						# use system library
						'type': 'none',
						
						'link_settings':
						{
							'libraries':
							[
								'-lz',
							],
						},
					},
				],
			],
		},
	],
}
