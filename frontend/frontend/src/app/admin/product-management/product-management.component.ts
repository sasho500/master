import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-product-management',
  templateUrl: './product-management.component.html',
  styleUrls: ['./product-management.component.scss'],
})
export class ProductManagementComponent implements OnInit {
  products: any[] = [];
  showAddModal: boolean = false;
  showEditModal: boolean = false;
  productForm: FormGroup;
  editForm: FormGroup;
  currentProduct: any = null;

  constructor(private apiService: ApiService, private fb: FormBuilder) {
    this.productForm = this.fb.group({
      name: ['', Validators.required],
      gender: ['', Validators.required],
      image_url: ['', Validators.required],
      description: ['', Validators.required],
      price: ['', Validators.required],
      quantity: ['', Validators.required],
    });

    this.editForm = this.fb.group({
      name: ['', Validators.required],
      gender: ['', Validators.required],
      description: ['', Validators.required],
      image_url: ['', Validators.required],
      price: ['', Validators.required],
      quantity: ['', Validators.required],
    });
  }

  ngOnInit(): void {
    this.loadProducts();
  }

  loadProducts(): void {
    this.apiService.getProducts().subscribe((products) => {
      this.products = products;
    });
  }

  toggleAddModal(): void {
    this.showAddModal = !this.showAddModal;
  }

  toggleEditModal(product?: any): void {
    this.currentProduct = product || null;
    if (this.currentProduct) {
      this.editForm.patchValue(this.currentProduct);
    }
    this.showEditModal = !this.showEditModal;
  }

  addProduct(): void {
    if (this.productForm.valid) {
      const newProduct = this.productForm.value;
      this.apiService.addProduct(newProduct).subscribe(() => {
        this.loadProducts();
        this.toggleAddModal();
      });
    }
  }

  editProduct(): void {
    if (this.editForm.valid) {
      const updatedProduct = this.editForm.value;
      this.apiService
        .updateProduct(this.currentProduct.product_id, updatedProduct)
        .subscribe(() => {
          this.loadProducts();
          this.toggleEditModal();
        });
    }
  }

  deleteProduct(productId: number): void {
    this.apiService.deleteProduct(productId).subscribe(() => {
      this.loadProducts();
    });
  }
}
