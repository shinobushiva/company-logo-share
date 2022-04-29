import { Field, ID, Int, ObjectType } from '@nestjs/graphql'
import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm'

@Entity()
@ObjectType()
export class User {
  @PrimaryGeneratedColumn()
  @Field(() => ID)
  id: number

  @Column({ length: '255' })
  @Field()
  firstName: string

  @Column({ length: '255' })
  @Field()
  lastName: string

  @Column({ type: 'int', unsigned: true })
  @Field(() => Int)
  age: number
}
