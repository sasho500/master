import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AuthService } from '../../services/auth.service';
import { ApiService } from '../../services/api.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-orders',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './orders.component.html',
  styleUrl: './orders.component.scss',
})
export class OrdersComponent implements OnInit {
  orders: any[] = [];
  isLoading = false;

  constructor(
    private authService: AuthService,
    private apiService: ApiService,
    private router: Router
  ) {}

  ngOnInit() {
    if (this.authService.isAuthenticated()) {
      this.loadOrders();
    } else {
      this.router.navigate(['/login']);
    }
  }

  loadOrders() {
    this.isLoading = true;
    const authKey = this.authService.getToken();
    this.apiService.getOrders().subscribe(
      (orders: any) => {
        this.orders = orders;
        console.log('orders123', orders);
        this.isLoading = false;
      },
      (error: any) => {
        console.error('Failed to load orders', error);
        this.isLoading = false;
      }
    );
  }
}
