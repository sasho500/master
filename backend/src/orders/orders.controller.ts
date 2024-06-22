import { Controller, Post, Body, Get,Param, Req, Res, UseGuards } from '@nestjs/common';
import { OrdersService } from './orders.service';
import { CreateOrderDto } from './create-order.dto';
import { Request, Response } from 'express';

@Controller('orders')
export class OrdersController {
  constructor(private readonly ordersService: OrdersService) {}

  @Post()
  async createOrder(@Body() createOrderDto: CreateOrderDto, @Req() req: Request, @Res() res: Response) {
    const authKey = req.cookies['auth_key'];
    if (!authKey) {
      return res.status(401).send('Unauthorized');
    }

    try {
      const order = await this.ordersService.createOrder(createOrderDto, authKey);
      return res.status(201).json(order);
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }

  @Get('by-auth/:authKey')
  async getOrdersByAuthKey(@Param('authKey') authKey: string, @Res() res: Response) {
    try {
      const orders = await this.ordersService.getOrdersByAuthKey(authKey);
      if (!orders.length) {
        return res.status(404).json({ message: 'No orders found for the provided auth key' });
      }
      return res.status(200).json(orders);
    } catch (error) {
      return res.status(400).json({ message: error.message });
    }
  }
}