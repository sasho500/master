import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ApiService } from '../../services/api.service';
import { AuthService } from '../../services/auth.service';

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

  constructor(
    private apiService: ApiService,
    public authService: AuthService
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
}
