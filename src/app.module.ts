import { Module } from '@nestjs/common'
import { AppController } from './app.controller'
import { AppService } from './app.service'
import { TypeOrmModule } from '@nestjs/typeorm'
import { UsersModule } from './users/users.module'
import ormconfig from './config/ormconfig'

@Module({
  imports: [UsersModule, TypeOrmModule.forRoot(ormconfig)],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
