{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libgif',
			
			'toolsets': ['host', 'target'],

			'conditions':
			[
				[
					'use_system_libgif == 0 and use_prebuilt_thirdparty == 0',
					{
						# build static library
						'type': 'static_library',
						
						'variables':
						{
							'silence_warnings': 1,
						},
						
						'include_dirs':
						[
							'include',
							'src',
						],
						
						'sources':
						[
							'include/gif_lib.h',
							
							'src/gif_hash.h',
							'src/gif_lib_private.h',
							
							'src/dgif_lib.c',
							'src/egif_lib.c',
							'src/gif_err.c',
							'src/gif_font.c',
							'src/gif_hash.c',
							'src/gifalloc.c',
							'src/openbsd-reallocarray.c',
							'src/quantize.c',
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
					'use_system_libgif == 0 and use_prebuilt_thirdparty != 0',
					{
						# use prebuilt library
						'type': 'none',

						'dependencies':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_gif',
						],

						'export_dependent_settings':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_gif',
						],
					},
				],
				[
					'use_system_libgif != 0',
					{
						# use system library
						'type': 'none',
						
						'link_settings':
						{
							'libraries':
							[
								'-lgif',
							],
						},
					},
				],
			],
		},
	],
}
