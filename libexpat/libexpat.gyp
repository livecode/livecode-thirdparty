{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libexpat',
			'type': 'static_library',
			
			'include_dirs':
			[
				'.',
				'lib',
			],
			
			'defines':
			[
				'HAVE_EXPAT_CONFIG_H',
			],
			
			'sources':
			[
				'expat_config.h',
				'lib/ascii.h',
				'lib/asiitab.h',
				'lib/expat_external.h',
				'lib/expat.h',
				'lib/iasciitab.h',
				'lib/internal.h',
				'lib/latin1tab.h',
				'lib/nametab.h',
				'lib/utf8tab.h',
				'lib/xmlrole.h',
				'lib/xmltok_impl.h',
				'lib/xmltok.h',
				
				'lib/xmlparse.c',
				'lib/xmlrole.c',
				'lib/xmltok_impl.c',
				'lib/xmltok_ns.c',
				'lib/xmltok.c',
			],
			
			'direct_dependent_settings':
			{
				'include_dirs':
				[
					'.',
					'lib',
				],
			},
			
			'conditions':
			[
				[
					'OS != "android"',
					{
						'type': 'none',
					},
				],
			],
		},
	],
}
