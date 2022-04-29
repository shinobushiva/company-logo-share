import { InputType, Int, Field } from '@nestjs/graphql'
import { Max, MaxLength, Min } from 'class-validator'

@InputType()
export class CreateUserInput {
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
