import { Injectable } from '@nestjs/common'
import { User } from '../entity'
import { Repository } from 'typeorm/repository/Repository'
import { CreateUserInput } from './dto/create-user.input'
import { UpdateUserInput } from './dto/update-user.input'
import { ConnectionManager, getConnectionManager, getRepository } from 'typeorm'

@Injectable()
export class UsersService {
  get userRepostiory(): Repository<User> {
    const connectionManager: ConnectionManager = getConnectionManager()
    if (connectionManager.has('default')) {
      const entityMetadata = connectionManager
        .get('default')
        .entityMetadatas.find((metadata) => {
          return metadata.tableName === 'user'
        })
      if (entityMetadata) {
        return getRepository(entityMetadata.name)
      } else {
        return null
      }
    }
  }

  async create(createUserInput: CreateUserInput) {
    const user = this.userRepostiory.create(createUserInput)
    await this.userRepostiory.save(user)
    return user
  }

  findAll() {
    return this.userRepostiory.find()
  }

  async findOne(id: number) {
    return await this.userRepostiory.findOne({
      where: {
        id,
      },
    })
  }

  async update(id: number, updateUserInput: UpdateUserInput) {
    const user = this.findOne(id)
    if (user) {
      await this.userRepostiory.save(updateUserInput)
    }
  }

  async remove(id: number) {
    const result = await this.userRepostiory.delete(id)
    return result.affected > 0
  }
}
