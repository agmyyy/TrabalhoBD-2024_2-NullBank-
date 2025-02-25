import fs from 'fs';
import ini from 'ini';

// Lendo o arquivo config.ini
const config = ini.parse(fs.readFileSync('../config.ini', 'utf-8'));

export default config;