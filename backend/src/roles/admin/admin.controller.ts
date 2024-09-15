import { Controller,Get, Post, Put, Delete, UseGuards, Body, Param  } from '@nestjs/common';
import { Roles } from '../roles.decorator';
import { RolesGuard } from '../roles.guard';
import { ProductsService } from '../../products/products.service';
import { Product } from '../../products/product.entity';
import { UsersService } from '../../users/users.service'; 
import { User } from '../../users/user.entity';

@Controller('admin')
@UseGuards(RolesGuard)
export class AdminController {
  constructor(private readonly productsService: ProductsService , private readonly usersService: UsersService, ) {}

  @Get('users')
  @Roles('admin')  // Ensure only admins can access this
  async getAllUsers(): Promise<User[]> {
    return this.usersService.findAll();
  }

  @Post('upload')
  @Roles('admin')
  async uploadProduct(@Body() product: Product) {
    const createdProduct = await this.productsService.create(product, 'admin'); // Assuming 'admin' role is checked within service
    return { message: 'Product uploaded successfully', product: createdProduct };
  }


  @Put('update/:id')
  @Roles('admin')
  async updateProduct(@Param('id') id: number, @Body() productData: Partial<Product>) {
    const updatedProduct = await this.productsService.update(id, productData);
    return { message: 'Product updated successfully', product: updatedProduct };
  }

  @Delete('delete/:id')
  @Roles('admin')
  async removeProduct(@Param('id') id: number): Promise<any> {
    await this.productsService.remove(id);
    return { message: `Product with id ${id} deleted successfully` };
  }
}