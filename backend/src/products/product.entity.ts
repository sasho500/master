import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';
import {
  IsNotEmpty,
  IsString,
  IsNumber,
  IsOptional,
  IsUrl,
  Length,
  IsIn,
} from 'class-validator';

@Entity('products')
export class Product {
  @PrimaryGeneratedColumn()
  product_id: number;

  @Column({ length: 100 })
  @IsNotEmpty()
  @IsString()
  @Length(1, 100)
  name: string;

  @Column('text')
  @IsNotEmpty()
  @IsString()
  description: string;

  @Column('decimal', { precision: 10, scale: 2 })
  @IsNotEmpty()
  @IsNumber()
  price: number;

  @Column('int')
  @IsNotEmpty()
  @IsNumber()
  quantity: number;

  @Column({ length: 255, nullable: true })
  @IsOptional()
  @IsUrl()
  image_url: string;

  @Column({ type: 'char', length: 1 })
  @IsNotEmpty()
  @IsIn(['F', 'M'])
  gender: string;
}
