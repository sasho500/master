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
    public authService: AuthService,
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
        this.orders = orders.map((order: any) => {
          const mergedOrderDetails: any = {};

          order.orderDetails.forEach((detail: any) => {
            const productName = detail.product.name;
            const detailSubtotal = parseFloat(detail.subtotal);
            if (mergedOrderDetails[productName]) {
              mergedOrderDetails[productName].quantity += detail.quantity;
              mergedOrderDetails[productName].subtotal = parseFloat(
                (
                  mergedOrderDetails[productName].subtotal + detailSubtotal
                ).toFixed(2)
              );
            } else {
              mergedOrderDetails[productName] = { ...detail };
              mergedOrderDetails[productName].subtotal = parseFloat(
                detailSubtotal.toFixed(2)
              );
            }
          });

          order.orderDetails = Object.values(mergedOrderDetails);
          return order;
        });

        this.isLoading = false;
      },
      (error: any) => {
        console.error('Failed to load orders', error);
        this.isLoading = false;
      }
    );
  }

  isAuthenticated(): boolean {
    if (typeof window !== 'undefined') {
      return this.authService.isAuthenticated();
    }
    return false;
  }
}
