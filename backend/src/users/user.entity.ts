import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
import {
  IsEmail,
  Length,
  IsNotEmpty,
  IsOptional,
  IsString,
  IsUrl,
  IsIn,
} from 'class-validator';
@Entity('users') // Ensure this matches the table name in your database
export class User {
  @PrimaryGeneratedColumn()
  user_id: number;

  @Column({ length: 50 })
  @IsNotEmpty()
  @IsString()
  @Length(4, 50)
  username: string;

  @Column({ length: 100 })
  @IsNotEmpty()
  @IsString()
  @Length(8, 50)
  password: string;

  @Column({ length: 100 })
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @Column({ length: 20 })
  @IsNotEmpty()
  @IsIn(['admin', 'user'])
  role: string;

  @Column({ length: 255 })
  @IsOptional()
  @IsUrl()
  profile_picture_url: string;

  @Column({ length: 255, unique: true })
  @IsString()
  key: string;

  @Column({ type: 'int', default: 0 })
  @IsOptional()
  failedLoginAttempts: number;

  @Column({ type: 'timestamp', nullable: true })
  @IsOptional()
  lockedUntil: Date | null;
}
