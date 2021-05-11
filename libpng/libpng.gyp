{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libpng',
			
			'toolsets': ['host', 'target'],

			'dependencies':
			[
				'../libz/libz.gyp:libz',
			],
			
			'conditions':
			[
				[
					'use_system_libpng == 0 and use_prebuilt_thirdparty == 0',
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
							'include/png.h',
							'include/pngconf.h',
							'include/pngdebug.h',
							'include/pnginfo.h',
							'include/pnglibconf.h',
							'include/pngstruct.h',
							
							'src/pngpriv.h',
							'src/png.c',
							'src/pngerror.c',
							'src/pngget.c',
							'src/pngmem.c',
							'src/pngpread.c',
							'src/pngread.c',
							'src/pngrio.c',
							'src/pngrtran.c',
							'src/pngrutil.c',
							'src/pngset.c',
							'src/pngtrans.c',
							'src/pngwio.c',
							'src/pngwrite.c',
							'src/pngwtran.c',
							'src/pngwutil.c',
						],
						
						'direct_dependent_settings':
						{
							'include_dirs':
							[
								'include',
							],
						},
						
                        'defines':
                        [
                            'PNG_ARM_NEON_OPT=0',
                        ],
					},
				],
				[
					'use_system_libpng == 0 and use_prebuilt_thirdparty != 0',
					{
						# use prebuilt library
						'type': 'none',

						'dependencies':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_png',
						],

						'export_dependent_settings':
						[
							'../../prebuilt/thirdparty.gyp:thirdparty_prebuilt_png',
						],
					},
				],
				[
					'use_system_libpng != 0',
					{
						# use system library
						'type': 'none',
					
						'link_settings':
						{
							'libraries':
							[
								'-lpng',
							],
						},
					},
				],
			],
		},
	],
}
