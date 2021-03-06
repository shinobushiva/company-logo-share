import { Module } from '@nestjs/common'
import { UsersService } from './users.service'
import { UsersResolver } from './users.resolver'
import { TypeOrmModule } from '@nestjs/typeorm'
import { User } from './entities/user.entity'
import { Repository } from 'typeorm'

@Module({
  imports: [TypeOrmModule.forFeature([User])],
  exports: [TypeOrmModule],
  providers: [UsersResolver, UsersService, Repository],
})
export class UsersModule {}
