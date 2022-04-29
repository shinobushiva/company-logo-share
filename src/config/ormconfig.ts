/** 全て追加 **/
import { DataSourceOptions } from 'typeorm'

const ormconfig: DataSourceOptions = {
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
  // acquireTimeout: 30 * 1000,
  entities: [process.cwd() + '/dist/src/entity/**/*.ts'],
  migrations: [process.cwd() + '/dist/src/database/migrations/**/*.ts'],
  // 今回subscriberは扱いません。
  // subscribers: [__dirname + '/dist/subscriber/**/*.ts'],
}
export default ormconfig
