SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'medusa-medusa-dentalanti' AND pid <> pg_backend_pid();
DROP DATABASE "medusa-medusa-dentalanti";
CREATE DATABASE "medusa-medusa-dentalanti";
