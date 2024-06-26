import { Module } from '@nestjs/common';
import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from './roles.guard';
import { AuthService } from '../auth/auth.service';
import { AdminController } from './admin/admin.controller';
import { ProductsService } from '../products/products.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Product } from '../products/product.entity';
import { UsersService } from '../users/users.service';
import { User } from '../users/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Product, User])],
  controllers: [AdminController],
  providers: [
    ProductsService,
    UsersService,
    AuthService,
    {
      provide: APP_GUARD,
      useClass: RolesGuard,
    },
  ],
})
export class RolesModule {}
