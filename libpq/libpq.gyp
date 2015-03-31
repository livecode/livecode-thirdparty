{
	'includes':
	[
		'../../common.gypi',
	],
	
	'targets':
	[
		{
			'target_name': 'libpq',
			
			'conditions':
			[
				[
					'use_system_libpq == 0',
					{
						'type': 'static_library',
						
						'variables':
						{
							'library_for_module': 1,
						},
						
						'include_dirs':
						[
							'include',
							'src',
						],
						
						'defines':
						[
							'HAVE_CONFIG_H',
						],
						
						'sources':
						[
							'include/libpq-fe.h',
							'include/postgres_ext.h',
							
							'src/c.h',
							'src/fe-auth.h',
							'src/fmgr.h',
							'src/getaddrinfo.h',
							'src/libpq-int.h',
							'src/miscadmin.h',
							'src/my_pg_config.h',
							'src/pg_config_manual.h',
							'src/pg_config_os.h',
							'src/pg_config_paths.h',
							'src/pg_config.h',
							'src/pg_config.linux.h',
							'src/pg_config.mac.i386.h',
							'src/pg_config.mac.ppc.h',
							'src/pg_config.win32.h',
							'src/port.h',
							'src/postgres_fe.h',
							'src/postgres.h',
							'src/pqexpbuffer.h',
							'src/pgsignal.h',
							'src/pthread-win32.h',
							'src/strdup.h',
							'src/win32.h',
							
							'src/copydir.c',
							'src/crypt.c',
							'src/dirmod.c',
							'src/elog.c',
							'src/encnames.c',
							'src/error.c',
							'src/exec.c',
							'src/fe-auth.c',
							'src/fe-connect.c',
							'src/fe-exec.c',
							'src/fe-lobj.c',
							'src/fe-misc.c',
							'src/fe-print.c',
							'src/fe-protocol2.c',
							'src/fe-protocol3.c',
							'src/fe-secure.c',
							'src/fseeko.c',
							'src/getaddrinfo.c',
							'src/gethostname.c',
							'src/getopt_long.c',
							'src/getopt.c',
							'src/getrusage.c',
							'src/gettimeofday.c',
							'src/inet_aton.c',
							'src/ip.c',
							'src/isinf.c',
							'src/kill.c',
							'src/md5.c',
							'src/memcmp.c',
							'src/noblock.c',
							'src/open.c',
							'src/path.c',
							'src/pgsleep.c',
							'src/pgstrcasecmp.c',
							'src/pipe.c',
							'src/pqexpbuffer.c',
							'src/pqsignal.c',
							'src/pthread-win32.c',
							'src/qsort.c',
							'src/rand.c',
							'src/random.c',
							'src/rint.c',
							'src/security.c',
							'src/sema.c',
							'src/shmem.c',
							'src/signal.c',
							'src/snprintf.c',
							'src/socket.c',
							'src/sprompt.c',
							'src/srandom.c',
							'src/strdup.c',
							'src/strerror.c',
							'src/strtol.c',
							'src/strtoul.c',
							'src/thread.c',
							'src/timer.c',
							'src/unsetenv.c',
							'src/wchar.c',
							'src/win32.c',
						],
						
						# Be quite selective about the bits of libpq that we actually compile
						'sources/':
						[
							['exclude', '^src/.*\\.c$'],
							['include', '^src/fe-.*\\.c$'],
							['include', '^src/pg.*\\.c$'],
							['include', '^src/pq.*\\.c$'],
							['include', '^src/(md5|pipe|fseeko|open|noblock|wchar|kill|dirmod|encnames|memcmp|isinf|inet_aton|qsort|snprintf|rint|random|rand|ip|thread)\\.c$'],
						],
						
						'direct_dependent_settings':
						{
							'include_dirs':
							[
								'include',
							],
						},
						
						'conditions':
						[
							[
								# Remove source files that don't work on Windows and add some others that are needed
								'OS == "win"',
								{
									'sources/':
									[
										['exclude', '^src/(pgsleep|snprintf|dirmod)\\.c$'],
										['include', '^src/(crypt|getaddrinfo|ip|win32)\\.c$'],
									],
									
									'link_settings':
									{
										'libraries':
										[
											'-ladvapi32',
											'-lshell32',
											'-lws2_32',
										],
									},
								}
							],
						],
					},
					{
						'type': 'none',
						
						'link_settings':
						{
							'libraries':
							[
								'-lpq',
							],
						},
					},
				],
			],
		},
	],
}
