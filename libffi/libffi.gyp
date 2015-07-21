{
	'includes':
	[
		'../../common.gypi',
	],
	
	'variables':
	{
		'libffi_public_headers_darwin_dir':
		[
			'./include_darwin'
		],
		
		'libffi_public_headers_win32_dir':
		[
			'./include_win32',
		],
		
		'libffi_public_headers_linux_x86_dir':
		[
			'./include_linux/x86',
		],
		
		'libffi_public_headers_linux_x86_64_dir':
		[
			'./include_linux/x86_64',
		],
		
		'libffi_public_headers_android_dir':
		[
			'./include_android',
		],

		'libffi_generic_sources':
		[
			'src/closures.c',
			'src/debug.c',
			'src/java_raw_api.c',
			'src/prep_cif.c',
			'src/raw_api.c',
			'src/types.c',
		],
		
		'libffi_all_platform_source_files':
		[
			'src/aarch64/ffi.c',
			'src/aarch64/sysv.S',
			'src/arm/ffi.c',
			'src/arm/sysv.S',
			'src/arm/trampoline.S',
			'src/x86/darwin.S',
			'src/x86/darwin64.S',
			'src/x86/ffi.c',
			'src/x86/ffi64.c',
			'src/x86/freebsd.S',
			'src/x86/sysv.S',
			'src/x86/unix64.S',
			'src/x86/win32.S',
			'src/x86/win64.S',
		],

		'libffi_mac_source_files':
		[
			'src/x86/darwin.S',
			'src/x86/darwin64.S',
			'src/x86/ffi.c',
			'src/x86/ffi64.c',
			'src/x86/win32.S',
		],
		
		'libffi_ios_source_files':
		[
			'src/aarch64/ffi.c',
			'src/aarch64/sysv.S',
			'src/arm/ffi.c',
			'src/arm/sysv.S',
			'src/arm/trampoline.S',
			'src/x86/darwin.S',
			'src/x86/darwin64.S',
			'src/x86/ffi.c',
			'src/x86/ffi64.c',
			'src/x86/win32.S',
		],
		
		'libffi_win_source_files':
		[
			'src/x86/ffi.c',
			'src/x86/win32.asm',
		],
		
		'libffi_linux_x86_source_files':
		[
			'src/x86/ffi.c',
			'src/x86/ffi64.c',
			'src/x86/sysv.S',
			'src/x86/unix64.S',
			'src/x86/win32.S',
		],
		
		'libffi_linux_arm_source_files':
		[
			'src/arm/ffi.c',
			'src/arm/sysv.S',
			'src/arm/trampoline.S',
		],
	},
	
	'targets':
	[
		{
			'target_name': 'libffi',
			'type': 'static_library',
			
			'toolsets': ['host','target'],
			
			'product_prefix': '',
			'product_name': 'libffi',
			
			'variables':
			{
				'conditions':
				[
					[
						'_toolset == "host"',
						{
							'toolset_os': '<(host_os)',
							'toolset_arch': '<(host_arch)',
						},
						{
							'toolset_os': '<(OS)',
							'toolset_arch': '<(target_arch)',
						},
					],
				],

				'silence_warnings': 1,
			},
			
			'sources':
			[
				'<@(libffi_generic_sources)'
			],
			
			'include_dirs':
			[
				'<@(_platform_include_dirs)',
			],
			
			'direct_dependent_settings':
			{
				'include_dirs':
				[
					'<@(_platform_include_dirs)',
				],
			},
			
			'conditions':
			[
				[
					'toolset_os == "mac"',
					{
						'platform_include_dirs':
						[
							'<@(libffi_public_headers_darwin_dir)',
						],
						
						'sources':
						[
							'<@(libffi_mac_source_files)',
						],
					},
				],
				[
					'toolset_os == "ios"',
					{
						'platform_include_dirs':
						[
							'<@(libffi_public_headers_darwin_dir)',
						],
						
						'sources':
						[
							'<@(libffi_ios_source_files)',
						],
					},
				],
				[
					'toolset_os == "win"',
					{
						'platform_include_dirs':
						[
							'<@(libffi_public_headers_win32_dir)',
						],
						
						'sources':
						[
							'<@(libffi_win_source_files)',
						],
					},
				],
				[
					'(toolset_os == "linux" or toolset_os == "android") and toolset_arch == "x86"',
					{
						'platform_include_dirs':
						[
							'<@(libffi_public_headers_linux_x86_dir)',
						],
						
						'sources':
						[
							'<@(libffi_linux_x86_source_files)',
						],
					},
				],
				[
					'(toolset_os == "linux" or toolset_os == "android") and toolset_arch == "x86_64"',
					{
						'platform_include_dirs':
						[
							'<@(libffi_public_headers_linux_x86_64_dir)',
						],
						
						'sources':
						[
							'<@(libffi_linux_x86_source_files)',
						],
					},
				],
				[
					'(toolset_os == "linux" or toolset_os == "android") and (toolset_arch == "armv6" or toolset_arch == "armv6hf")',
					{
						'platform_include_dirs':
						[
							'<@(libffi_public_headers_android_dir)',
						],
						
						'sources':
						[
							'<@(libffi_linux_arm_source_files)',
						],
						
						# Disable VFP
						'cflags':
						[
							'-U__ARM_EABI__',
						],
					},
				],
			],
			
			'target_conditions':
			[
				[
					'_toolset != "target"',
					{
						'product_name': 'libffi->(_toolset)',
					},
				],
			],
		},
	],
}
