import { Injectable, Logger, UnauthorizedException  } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Order } from './order.entity';
import { OrderDetails } from './order-details.entity';
import { CreateOrderDto } from './create-order.dto';
import { Product } from '../products/product.entity';
import { UpdateOrderDto } from './update-order.dto';
import * as jwt from 'jsonwebtoken';

@Injectable()
export class OrdersService {
  private readonly logger = new Logger(OrdersService.name);

  constructor(
    @InjectRepository(Order)
    private ordersRepository: Repository<Order>,
    @InjectRepository(OrderDetails)
    private orderDetailsRepository: Repository<OrderDetails>,
    @InjectRepository(Product)
    private productsRepository: Repository<Product>,
  ) {}
  async createOrder(createOrderDto: CreateOrderDto, token: string): Promise<Order> {
    try {
      const decoded = jwt.decode(token) as any;
      if (!decoded || !decoded.key) {
        throw new UnauthorizedException('Invalid token');
      }

      const authKey = decoded.key;
      const order = new Order();
      order.auth_key = authKey;
      order.total_amount = createOrderDto.total_amount;

      this.logger.log('Saving order...');
      const savedOrder = await this.ordersRepository.save(order);
      this.logger.log(`Order saved with ID: ${savedOrder.order_id}`);

      for (const detail of createOrderDto.orderDetails) {
        this.logger.log(`Checking product with ID: ${detail.product_id}`);
        const product = await this.productsRepository.findOne({ where: { product_id: detail.product_id } });
        if (!product) {
          throw new Error(`Product with ID ${detail.product_id} not found`);
        }

        if (product.quantity <= 0) {
          throw new Error(`Product with ID ${detail.product_id} is out of stock`);
        }

        const orderDetail = new OrderDetails();
        orderDetail.order = savedOrder;
        orderDetail.product = product;
        orderDetail.quantity = detail.quantity;
        orderDetail.subtotal = detail.subtotal;

        this.logger.log('Saving order detail...');
        await this.orderDetailsRepository.save(orderDetail);
        this.logger.log('Order detail saved');
      }

      this.logger.log('Fetching saved order with details...');
      const result = await this.ordersRepository.findOne({ where: { order_id: savedOrder.order_id }, relations: ['orderDetails', 'orderDetails.product'] });
      this.logger.log('Order fetched successfully');
      return result;
    } catch (error) {
      this.logger.error('Error creating order', error.stack);
      throw error;
    }
  }

  async updateOrder(authKey: string, orderId: number, updateOrderDto: UpdateOrderDto): Promise<Order> {
    try {
      const order = await this.ordersRepository.findOne({ where: { order_id: orderId, auth_key: authKey }, relations: ['orderDetails'] });

      if (!order) {
        throw new Error(`Order with ID ${orderId} not found`);
      }

      // Update order details
      order.total_amount = updateOrderDto.total_amount;

      // Clear existing order details
      await this.orderDetailsRepository.delete({ order });

      for (const detail of updateOrderDto.orderDetails) {
        const product = await this.productsRepository.findOne({ where: { product_id: detail.product_id } });
        if (!product) {
          throw new Error(`Product with ID ${detail.product_id} not found`);
        }

        if (product.quantity <= 0) {
          throw new Error(`Product with ID ${detail.product_id} is out of stock`);
        }

        const orderDetail = new OrderDetails();
        orderDetail.order = order;
        orderDetail.product = product;
        orderDetail.quantity = detail.quantity;
        orderDetail.subtotal = detail.subtotal;

        await this.orderDetailsRepository.save(orderDetail);
      }

      return this.ordersRepository.findOne({ where: { order_id: orderId }, relations: ['orderDetails', 'orderDetails.product'] });
    } catch (error) {
      this.logger.error('Error updating order', error.stack);
      throw error;
    }
  }


  async getOrdersByAuthKey(token: string): Promise<Order[]> {
    try {
      const decoded = jwt.decode(token) as any;
      if (!decoded || !decoded.key) {
        throw new UnauthorizedException('Invalid token');
      }

      const authKey = decoded.key;
      return this.ordersRepository.find({
        where: { auth_key: authKey },
        relations: ['orderDetails', 'orderDetails.product'],
      });
    } catch (error) {
      this.logger.error('Error fetching orders by auth key', error.stack);
      throw error;
    }
  }
}