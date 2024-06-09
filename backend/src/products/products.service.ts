import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Product } from './product.entity';

@Injectable()
export class ProductsService {
    private readonly logger = new Logger(ProductsService.name); // Corrected to ProductsService

    constructor(
        @InjectRepository(Product)
        private productsRepository: Repository<Product>,
    ) {}

    findAll(): Promise<Product[]> {
        return this.productsRepository.find();
    }

    findOne(id: number): Promise<Product> {
        return this.productsRepository.findOne({ where: { product_id: id } }); // Ensuring correct usage of findOne
    }

    async create(product: Product): Promise<Product> {
        return this.productsRepository.save(product);
    }

    async update(id: number, productData: Partial<Product>): Promise<Product> {
        const product = await this.productsRepository.findOne({ where: { product_id: id } });
        if (!product) throw new Error('Product not found');

        return this.productsRepository.save({
            ...product,
            ...productData
        });
    }

    async remove(id: number): Promise<void> {
        await this.productsRepository.delete(id);
    }
}