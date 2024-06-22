import {
  Entity,
  Column,
  PrimaryGeneratedColumn,
  ManyToOne,
  OneToMany,
} from 'typeorm';

import { OrderDetails } from './order-details.entity';

@Entity('orders')
export class Order {
  @PrimaryGeneratedColumn()
  order_id: number;

  @Column({ length: 255 })
  auth_key: string;

  @Column({ type: 'date', default: () => 'CURRENT_DATE' })
  date: string;

  @Column({ type: 'decimal', precision: 10, scale: 2 })
  total_amount: number;

  @OneToMany(() => OrderDetails, (orderDetails) => orderDetails.order)
  orderDetails: OrderDetails[];
}
