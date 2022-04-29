import { CreateUserInput } from './create-user.input'
import { InputType, Field, Int, PartialType } from '@nestjs/graphql'
import { Max, MaxLength, Min } from 'class-validator'

@InputType()
export class UpdateUserInput extends PartialType(CreateUserInput) {
  @Field(() => Int)
  id: number

  @MaxLength(255)
  @Field()
  firstName: string

  @MaxLength(255)
  @Field()
  lastName: string

  @Field(() => Int)
  @Min(0)
  @Max(200)
  age: number
}
