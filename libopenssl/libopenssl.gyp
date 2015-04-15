{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libopenssl_stubs',
			'type': 'none',
			
			'variables':
			{
				'library_for_module': 1,
			},
			
			'sources':
			[
				'ssl.stubs',
			],
			
			'actions':
			[
				{
					'action_name': 'libopenssl_stubs',
					'inputs':
					[
						'../../util/weak_stub_maker.pl',
						'ssl.stubs',
					],
					'outputs':
					[
						'<(SHARED_INTERMEDIATE_DIR)/src/ssl.<(OS).stubs.cpp',
					],
					
					'action':
					[
						'<@(perl)',
						'../../util/weak_stub_maker.pl',
						'ssl.stubs',
						'<@(_outputs)',
					],
				},
			],
		},
		
		{
			'target_name': 'libopenssl',
			'type': 'static_library',
			
			'variables':
			{
				'library_for_module': 1,
			},
			
			'dependencies':
			[
				'libopenssl_stubs',
				#'../../prebuilt/libopenssl.gyp:libopenssl',
			],
			
			'sources':
			[
				'<(SHARED_INTERMEDIATE_DIR)/src/ssl.<(OS).stubs.cpp',
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
	
	'conditions':
	[
		[
			'OS == "mac"',
			{
				'targets':
				[
					{
						'target_name': 'revsecurity',
						'type': 'shared_library',
						'product_prefix': '',

						'dependencies':
						[
							'../../prebuilt/libopenssl.gyp:libopenssl',
							'libopenssl_symbol_list',
						],

						'sources':
						[
							'../../engine/src/dummy.cpp',
						],
						
						'xcode_settings':
						{
							'EXPORTED_SYMBOLS_FILE': '<(SHARED_INTERMEDIATE_DIR)/src/sslstubs.mac.symlist',
						},
					},
					
					{
						'target_name': 'libopenssl_symbol_list',
						'type': 'none',
						
						'actions':
						[
							{
								'action_name': 'libopenssl_symbol_list',
								'inputs':
								[
									'../../util/list_stub_symbols.pl'
									'ssl.stubs',
								],
								'outputs':
								[
									'<(SHARED_INTERMEDIATE_DIR)/src/sslstubs.mac.symlist',
								],
								
								'action':
								[
									'<@(perl)',
									'../../util/list_stub_symbols.pl',
									'_',
									'ssl.stubs',
									'<@(_outputs)',
								],
							},
						],
					},
				],
			},
		],
		[
			'OS == "linux" or OS == "android"',
			{
				'targets':
				[
					{
						# Setting this as a loadable module instead of a shared library
						# causes it to get placed next to the built executables rather
						# than in a library sub-directory.
						'target_name': 'revsecurity',
						'type': 'loadable_module',
						'product_prefix': '',
						
						'dependencies':
						[
							'../../prebuilt/libopenssl.gyp:libopenssl',
						],
					},
				],
			},
		],
		[
			'OS == "win"',
			{
				'targets':
				[
					# Revsecurity is a pre-built on windows
					{
						'target_name': 'revsecurity',
						'type': 'none',
					},
				],
			}
		],
		[
			'OS == "ios"',
			{
				'targets':
				[
					{
						'target_name': 'revsecurity',
						'type': 'loadable_module',
						'product_prefix': '',

						'dependencies':
						[
							'../../prebuilt/libopenssl.gyp:libopenssl',
							'libopenssl_symbol_list',
						],

						'sources':
						[
							'<(SHARED_INTERMEDIATE_DIR)/src/libopenssl-libinfo.ios.cpp',
						],
						
						'xcode_settings':
						{
							'EXPORTED_SYMBOLS_FILE': '<(SHARED_INTERMEDIATE_DIR)/src/sslstubs.mac.symlist',
						},
						
						'variables':
						{
							'ios_external_symbols': [],
							'ios_external_symbol_list': '<(SHARED_INTERMEDIATE_DIR)/src/sslstubs.ios.symlist',
						},
					},
					
					{
						'target_name': 'libopenssl_symbol_list',
						'type': 'none',
						
						'actions':
						[
							{
								'action_name': 'libopenssl_symbol_list',
								'inputs':
								[
									'../../util/list_stub_symbols.pl'
									'ssl.stubs',
								],
								'outputs':
								[
									'<(SHARED_INTERMEDIATE_DIR)/src/sslstubs.ios.symlist',
								],
								
								'action':
								[
									'<@(perl)',
									'../../util/list_stub_symbols.pl',
									'_',
									'ssl.stubs',
									'<@(_outputs)',
								],
							},
							{
								'action_name': 'libopenssl_libinfo',
								'inputs':
								[
									'../../util/build_libinfo.pl',
									'ssl.stubs',
								],
								'outputs':
								[
									'<(SHARED_INTERMEDIATE_DIR)/src/libopenssl-libinfo.ios.cpp',
								],
								
								'action':
								[
									'<@(perl)',
									'../../util/build_libinfo.pl',
									'revsecurity',
									'ssl.stubs',
									'<@(_outputs)',
								],
							},
						],
					},
				],
			},
		],
	],
}
