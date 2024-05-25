import { Entity, Column, PrimaryGeneratedColumn } from 'typeorm';
@Entity('users') // Ensure this matches the table name in your database
export class User {
  @PrimaryGeneratedColumn()
  user_id: number;

  @Column({ length: 50 })
  username: string;

  @Column({ length: 100 })
  password: string;

  @Column({ length: 100 })
  email: string;

  @Column({ length: 20 })
  role: string;

  @Column({ length: 255 })
  profile_picture_url: string;

  @Column({ length: 255, unique: true })
  key: string;
}
