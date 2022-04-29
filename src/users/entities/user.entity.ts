import { Column, PrimaryGeneratedColumn, Entity } from 'typeorm'

@Entity('users')
export class User {
  @PrimaryGeneratedColumn({
    comment: 'Account ID',
  })
  readonly id: number

  @Column('varchar', { comment: 'アカウント名' })
  name: string

  constructor(name: string) {
    this.name = name
  }
}
