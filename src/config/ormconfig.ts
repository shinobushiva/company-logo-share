/** 全て追加 **/
import { DataSourceOptions } from 'typeorm'

type DBConfigs = {
  local: DataSourceOptions
  test: DataSourceOptions
  dev: DataSourceOptions
}

const common: DataSourceOptions = {
  name: 'default', // 標準で読み込まれる設定
  type: 'mysql',
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT, 10),
  username: process.env.DB_USERNAME,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE,
  synchronize: false,
  logging: false,
  connectTimeout: 30 * 1000,
  // entities: [process.cwd() + '/dist/**/entities/**/*.entity.js'],
  // entities: ['dist/entity/**/*.ts'],
  // entities: ['User'],
  entities: ['dist/entity/index.js'],
  migrations: [process.cwd() + '/dist/database/migrations/**/*.js'],
  // 今回subscriberは扱いません。
  // subscribers: [__dirname + '/dist/subscriber/**/*.ts'],
  charset: 'utf8mb4_general_ci',
  extra: {
    timezone: '+09:00',
    charset: 'utf8mb4_general_ci',
  },
}

const ormconfigs: DBConfigs = {
  local: {
    ...common,
  },
  test: {
    ...common,
  },
  dev: {
    ...common,
  },
}
export default ormconfigs[process.env.NODE_ENV || 'local']
