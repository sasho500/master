import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { AuthService } from '../../services/auth.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-main',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './main.component.html',
  styleUrl: './main.component.scss',
})
export class MainComponent implements OnInit {
  products: any[] = [];
  isLoading = false;
  searchQuery = '';
  genderFilter = '';
  cart: any[] = [];

  constructor(
    private apiService: ApiService,
    public authService: AuthService,
    private router: Router
  ) {}

  ngOnInit() {
    this.loadProducts();
  }

  loadProducts() {
    this.isLoading = true;
    this.apiService.getProducts(this.searchQuery, this.genderFilter).subscribe(
      (products) => {
        this.products = products;
        this.isLoading = false;
      },
      (error) => {
        console.error('Failed to load products', error);
        this.isLoading = false;
      }
    );
  }

  onSearch() {
    this.loadProducts();
  }

  filterByGender(gender: string = '') {
    this.genderFilter = gender;
    this.loadProducts();
  }

  isAuthenticated(): boolean {
    if (typeof window !== 'undefined') {
      return this.authService.isAuthenticated();
    }
    return false;
  }

  addToCart(product: any) {
    this.cart.push({
      product_id: product.product_id,
      quantity: 1,
      subtotal: product.price,
    });
    alert('Product added to cart!');
  }

  createOrder() {
    if (this.cart.length === 0) {
      alert('Cart is empty!');
      return;
    }
    const order = {
      total_amount: this.cart.reduce(
        (total, item) => total + Number(item.subtotal),
        0
      ),
      orderDetails: this.cart.map((item) => ({
        product_id: item.product_id,
        quantity: item.quantity,
        subtotal: Number(item.subtotal),
      })),
    };
    this.apiService.createOrder(order).subscribe(
      (response) => {
        alert('Order created successfully!');
        this.cart = [];
      },
      (error) => {
        console.error('Failed to create order', error);
        alert('Failed to create order');
      }
    );
  }

  viewOrders() {
    this.router.navigate(['/orders']);
  }
}
