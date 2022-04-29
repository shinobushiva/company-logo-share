import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { Repository } from 'typeorm/repository/Repository'
import { CreateUserInput } from './dto/create-user.input'
import { UpdateUserInput } from './dto/update-user.input'
import { User } from './entities/user.entity'

@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private userRepostiory: Repository<User>,
  ) {}

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
