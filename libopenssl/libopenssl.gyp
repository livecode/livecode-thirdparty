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
						'../../tools/weak_stub_maker.lc',
						'ssl.stubs',
					],
					'outputs':
					[
						'<(SHARED_INTERMEDIATE_DIR)/src/ssl.<(OS).stubs.cpp',
					],
					
					'action':
					[
						'<(revolution_path)',
						'../../tools/weak_stub_maker.lc',
						'ssl.stubs',
						'<@(_outputs)',
					],
				},
			],
		},
		
		{
			'target_name': 'libopenssl',
			'type': 'static_library',
			
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
									'../../tools/list_stub_symbols.lc'
									'ssl.stubs',
								],
								'outputs':
								[
									'<(SHARED_INTERMEDIATE_DIR)/src/sslstubs.mac.symlist',
								],
								
								'action':
								[
									'<(revolution_path)',
									'../../tools/list_stub_symbols.lc',
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
			'OS == "linux"',
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
	],
}
