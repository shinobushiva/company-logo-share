// 'use strict'

// module.exports.hello = async (event) => {
//   return {
//     statusCode: 200,
//     body: JSON.stringify(
//       {
//         message: 'Go Serverless v3.0! Your function executed successfully!',
//         input: event,
//       },
//       null,
//       2,
//     ),
//   }
// }

import { Context, Handler } from 'aws-lambda'
import { NestFactory } from '@nestjs/core'
import { AppModule } from './app.module'
import { Server } from 'http'
import { ExpressAdapter } from '@nestjs/platform-express'
import * as serverless from 'aws-serverless-express'
import * as express from 'express'
import { Logger } from '@nestjs/common'
import { logger } from './common/middleware/logger.middleware'

let cachedServer: Server

async function bootstrapServer(): Promise<Server> {
  // Logger.log('bootstrapServer')
  const expressApp = express()
  const adapter = new ExpressAdapter(expressApp)
  // Logger.log('appModule')
  const module = AppModule
  // Logger.log('appModule:end')
  // Logger.log('create')
  const app = await NestFactory.create(module, adapter)
  // app.use(logger)
  // Logger.log('created1')
  await NestFactory.createApplicationContext(module)
  // Logger.log('created2')
  app.enableCors()
  await app.init()
  // Logger.log('initialized')
  return serverless.createServer(expressApp)
}

export const handler: Handler = async (event: any, context: Context) => {
  if (!cachedServer) {
    cachedServer = await bootstrapServer()
  }

  return serverless.proxy(cachedServer, event, context, 'PROMISE').promise
}
