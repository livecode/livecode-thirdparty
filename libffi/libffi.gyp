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
		
		'libffi_all_platform_sources':
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
		
		'conditions':
		[
			[ 
				'OS=="mac" or OS=="ios"',
				{ 
					'libffi_public_headers_dir': '<(libffi_public_headers_darwin_dir)'
				}
			],
			
			# Only build the appropriate x86(_64) files for OSX
			[ 
				'OS == "mac"',
				{
					'libffi_platform_sources':
					[
						'src/x86/darwin.S',
						'src/x86/darwin64.S',
						'src/x86/ffi.c',
						'src/x86/ffi64.c',
						'src/x86/win32.S',
						'src/x86/win64.S',
					],
				},
			],
			
			# Only build the appropriate files for iOS
			[
				'OS == "ios"',
				{
					'libffi_platform_sources':
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
						'src/x86/win64.S'
					],
				},
			],
			
			# Only build the appropriate x86(_64) files for Win32
			[
				'OS == "win"',
				{
					'libffi_public_headers_dir': '<(libffi_public_headers_win32_dir)',
					
					'libffi_platform_sources':
					[
						'src/x86/ffi.c',
						'src/x86/win32.asm',
					],
				},
			],
			
			# Only build the appropriate files for Linux and Android x86(_64)
			[
				'(OS == "linux" or OS == "android") and (target_arch == "x86" or target_arch == "x86_64")',
				{
					'libffi_public_headers_dir': '<(libffi_public_headers_linux_x86_64_dir)',
					
					'libffi_platform_sources':
					[
						'src/x86/ffi.c',
						'src/x86/ffi64.c',
						'src/x86/sysv.S',
						'src/x86/unix64.S',
					],
				},
			],
			
			# Only build the appropriate files for Linux and Android ARM
			[
				'(OS == "linux" or OS == "android") and target_arch == "arm"',
				{
					'libffi_public_headers_dir': '<(libffi_public_headers_android_dir)',
					
					'libffi_platform_sources':
					[
						'src/arm/ffi.c',
						'src/arm/sysv.S',
						'src/arm/trampoline.S',
					],
				},
			],
		],
	},
	
	'targets':
	[
		{
			'target_name': 'libffi',
			'type': 'static_library',
			
			'toolsets': ['host','target'],
			
			'include_dirs':
			[
				'<(libffi_public_headers_dir)',
			],
			'sources':
			[
				'<@(libffi_platform_sources)',
				'<@(libffi_generic_sources)',
			],
			'direct_dependent_settings':
			{
				'include_dirs': [ '<(libffi_public_headers_dir)', ],
			},
		},
	],
}
