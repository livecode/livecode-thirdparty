{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libpcre',
			
			'conditions':
			[
				[
					'use_system_libpcre == 0',
					{
						'type': 'static_library',
						
						'include_dirs':
						[
							'include',
							'src',
						],
						
						'sources':
						[
							'include/pcre.h',
							'include/pcreposix.h',
							
							'src/config.h',
							'src/pcre_internal.h',
							'src/ucp.h',
							
							'src/pcre_byte_order.c',
							'src/pcre_chartables.c',
							'src/pcre_compile.c',
							'src/pcre_config.c',
							'src/pcre_dfa_exec.c',
							'src/pcre_exec.c',
							'src/pcre_fullinfo.c',
							'src/pcre_get.c',
							'src/pcre_globals.c',
							'src/pcre_info_fullinfo.c',
							'src/pcre_jit_compile.c',
							'src/pcre_maketables.c',
							'src/pcre_newline.c',
							'src/pcre_ord2utf8.c',
							'src/pcre_refcount.c',
							'src/pcre_string_utils.c',
							'src/pcre_study.c',
							'src/pcre_tables.c',
							'src/pcre_ucd.c',
							'src/pcre_valid_utf8.c',
							'src/pcre_version.c',
							'src/pcre_xclass.c',
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
								'-lpcre',
							],
						},
					},
				],
			],
		},
	],
}
