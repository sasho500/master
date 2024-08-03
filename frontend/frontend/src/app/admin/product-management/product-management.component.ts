import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-product-management',
  templateUrl: './product-management.component.html',
  styleUrls: ['./product-management.component.scss'],
})
export class ProductManagementComponent implements OnInit {
  products: any[] = [];

  constructor(private apiService: ApiService) {}

  ngOnInit(): void {
    this.loadProducts();
  }

  loadProducts(): void {
    this.apiService.getProducts().subscribe((products) => {
      this.products = products;
    });
  }

  addProduct(): void {
    // Logic to add a product
  }

  editProduct(product: any): void {
    // Logic to edit a product
  }

  deleteProduct(productId: number): void {
    this.apiService.deleteProduct(productId).subscribe(() => {
      this.loadProducts();
    });
  }
}
