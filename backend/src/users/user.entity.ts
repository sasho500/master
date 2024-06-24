import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
import { IsEmail, Length, IsNotEmpty } from 'class-validator';
@Entity('users') // Ensure this matches the table name in your database
export class User {
  @PrimaryGeneratedColumn()
  user_id: number;

  @Column({ length: 50 })
  @Length(4, 50)
  username: string;

  @Column({ length: 100 })
  @Length(8, 100)
  password: string;

  @Column({ length: 100 })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @Column({ length: 20 })
  @IsNotEmpty()
  role: string;

  @Column({ length: 255 })
  profile_picture_url: string;

  @Column({ length: 255, unique: true })
  key: string;
}
