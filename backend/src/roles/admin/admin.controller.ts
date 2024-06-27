import { Controller, Post, Put, UseGuards, Body, Param  } from '@nestjs/common';
import { Roles } from '../roles.decorator';
import { RolesGuard } from '../roles.guard';
import { ProductsService } from '../../products/products.service';
import { Product } from '../../products/product.entity';

@Controller('admin')
@UseGuards(RolesGuard)
export class AdminController {
  constructor(private readonly productsService: ProductsService) {}

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
}