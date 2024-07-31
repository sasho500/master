import { Injectable, Logger, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Product } from './product.entity';
import { UsersService } from '../users/users.service';

@Injectable()
export class ProductsService {
    private readonly logger = new Logger(ProductsService.name);

    constructor(
        @InjectRepository(Product)
        private productsRepository: Repository<Product>,
        private usersService: UsersService
    ) {}

    async findAll(name?: string, gender?: 'F' | 'M'): Promise<Product[]> {
        const where: any = {};
        if (name) {
            where.name = name;
        }
        if (gender) {
            where.gender = gender;
        }

        try {
            const products = await this.productsRepository.find({ where });
            this.logger.log(`Found ${products.length} products`);
            return products;
        } catch (error) {
            this.logger.error('Failed to retrieve products', error.stack);
            throw new Error('Error retrieving products');
        }
    }

    async findOne(id: number): Promise<Product> {
        try {
            const product = await this.productsRepository.findOne({ where: { product_id: id } });
            if (!product) {
                throw new NotFoundException('Product not found');
            }
            this.logger.log(`Found product: ${JSON.stringify(product)}`);
            return product;
        } catch (error) {
            this.logger.error('Failed to retrieve product', error.stack);
            throw new Error('Error retrieving product');
        }
    }

    async create(product: Product, userKey: string): Promise<Product> {
        // Example check - you might add more specific logic here
        const user = await this.usersService.findOne(userKey);
        // this.logger.debug("test log", user);
        // if (!user || user.role !== 'admin') {
        //     this.logger.error('Unauthorized attempt to create product');
        //     throw new Error('Unauthorized: Only admins can add products.');
        // }

        try {
            const newProduct = await this.productsRepository.save(product);
            this.logger.log(`Created product: ${JSON.stringify(newProduct)}`);
            return newProduct;
        } catch (error) {
            this.logger.error('Failed to create product', error.stack);
            throw new Error('Error creating product');
        }
    }

    async update(id: number, productData: Partial<Product>): Promise<Product> {
        const product = await this.productsRepository.findOne({ where: { product_id: id } });
        if (!product) {
            throw new NotFoundException('Product not found');
        }

        try {
            const updatedProduct = await this.productsRepository.save({
                ...product,
                ...productData
            });
            this.logger.log(`Updated product: ${JSON.stringify(updatedProduct)}`);
            return updatedProduct;
        } catch (error) {
            this.logger.error('Failed to update product', error.stack);
            throw new Error('Error updating product');
        }
    }

    async remove(id: number): Promise<void> {
        const product = await this.productsRepository.findOne({ where: { product_id: id } });
        this.logger.debug("delete product",JSON.stringify(product));
        if (!product) {
            throw new NotFoundException('Product not found');
        }

        try {
            await this.productsRepository.delete(id);
            this.logger.log(`Deleted product with id: ${id}`);
        } catch (error) {
            this.logger.error('Failed to delete product', error.stack);
            throw new Error('Error deleting product');
        }
    }
}