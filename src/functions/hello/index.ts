import schema from './schema'
import { handlerPath } from '@libs/handler-resolver'

export default {
  // handler: `${handlerPath(__dirname)}/handler.main`,
  image: {
    name: 'appimage',
    // command: [`${handlerPath(__dirname)}/main.main`],
  },
  events: [
    {
      http: {
        method: 'post',
        path: 'hello',
        request: {
          schemas: {
            'application/json': schema,
          },
        },
      },
    },
  ],
}
