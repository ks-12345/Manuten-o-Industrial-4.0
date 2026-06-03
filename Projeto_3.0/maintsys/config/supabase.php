<?php

return [
    'url' => env('SUPABASE_URL', ''),
    'anon_key' => env('SUPABASE_ANON_KEY', ''),
    'service_role_key' => env('SUPABASE_SERVICE_ROLE_KEY', ''),
    'database_url' => env('SUPABASE_DATABASE_URL', env('DATABASE_URL')),
    'storage' => [
        'bucket' => env('SUPABASE_STORAGE_BUCKET', env('AWS_BUCKET', '')),
    ],
];
