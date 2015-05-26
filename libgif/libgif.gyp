{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libgif',
			
			'conditions':
			[
				[
					'use_system_libgif == 0',
					{
						'type': 'static_library',
						
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
					{
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
