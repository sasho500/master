import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { ProductsService } from './products.service';
import { Product } from './product.entity';

@Controller('products')
export class ProductsController {
    constructor(private productsService: ProductsService) {}

    @Get()
    getAll(): Promise<Product[]> {
        return this.productsService.findAll();
    }

    @Get(':id')
    getOne(@Param('id') id: number): Promise<Product> {
        return this.productsService.findOne(id);
    }

    @Post()
    create(@Body() product: Product): Promise<Product> {
        return this.productsService.create(product);
    }

    @Post(':id')
    update(@Param('id') id: number, @Body() productData: Partial<Product>): Promise<Product> {
        return this.productsService.update(id, productData);
    }

    @Delete(':id')
    remove(@Param('id') id: number): Promise<void> {
        return this.productsService.remove(id);
    }
}