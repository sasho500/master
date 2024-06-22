import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from './order.entity';
import { OrderDetails } from './order-details.entity';
import { CreateOrderDto } from './create-order.dto';
import { Product } from '../products/product.entity';

@Injectable()
export class OrdersService {
  constructor(
    @InjectRepository(Order)
    private ordersRepository: Repository<Order>,
    @InjectRepository(OrderDetails)
    private orderDetailsRepository: Repository<OrderDetails>,
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
  ) {}

  async createOrder(createOrderDto: CreateOrderDto, authKey: string): Promise<Order> {
    const order = new Order();
    order.auth_key = authKey;
    order.total_amount = createOrderDto.total_amount;

    const savedOrder = await this.ordersRepository.save(order);

    for (const detail of createOrderDto.orderDetails) {
      const product = await this.productsRepository.findOne({ where: { product_id: detail.product_id } });
      if (!product) {
        throw new Error(`Product with ID ${detail.product_id} not found`);
      }

      const orderDetail = new OrderDetails();
      orderDetail.order = savedOrder;
      orderDetail.product = product;
      orderDetail.quantity = detail.quantity;
      orderDetail.subtotal = detail.subtotal;
      await this.orderDetailsRepository.save(orderDetail);
    }

    return this.ordersRepository.findOne({ where: { order_id: savedOrder.order_id }, relations: ['orderDetails', 'orderDetails.product'] });
  }

  async getOrdersByAuthKey(authKey: string): Promise<Order[]> {
    return this.ordersRepository.find({
      where: { auth_key: authKey },
      relations: ['orderDetails', 'orderDetails.product'],
    });
  }
}