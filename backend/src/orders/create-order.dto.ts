import {
  IsNotEmpty,
  IsNumber,
  IsString,
  IsArray,
  ValidateNested,
} from 'class-validator';
import { Type } from 'class-transformer';
import { Product } from '../products/product.entity';

class OrderDetailDto {
  @IsNumber()
  product_id: number;

  @IsNumber()
  quantity: number;

  @IsNumber()
  subtotal: number;
}

export class CreateOrderDto {
  @IsNotEmpty()
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => OrderDetailDto)
  orderDetails: OrderDetailDto[];

  @IsNumber()
  total_amount: number;
}
