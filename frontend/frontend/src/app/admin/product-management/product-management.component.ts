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
      name: [
        '',
        [
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(100),
          Validators.pattern(/^[a-zA-Z0-9\s]+$/), // Alphanumeric only
        ],
      ],
      gender: [
        '',
        [
          Validators.required,
          Validators.pattern(/^[MF]$/), // 'M' or 'F' only
        ],
      ],
      image_url: [
        '',
        [
          Validators.required,
          Validators.pattern(/(https?:\/\/.*\.(?:png|jpg))/i), // URL ending with .png or .jpg
        ],
      ],
      description: [
        '',
        [
          Validators.required,
          Validators.minLength(10),
          Validators.maxLength(500),
          Validators.pattern(/^[a-zA-Z0-9\s.,!]+$/), // Alphanumeric and basic punctuation
        ],
      ],
      price: [
        '',
        [
          Validators.required,
          Validators.min(1),
          Validators.max(100000),
          Validators.pattern(/^\d+(\.\d{1,2})?$/), // Numbers with up to 2 decimal places
        ],
      ],
      quantity: [
        '',
        [
          Validators.required,
          Validators.min(1),
          Validators.max(1000),
          Validators.pattern(/^\d+$/), // Whole numbers only
        ],
      ],
    });

    this.editForm = this.fb.group({
      name: [
        '',
        [
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(100),
          Validators.pattern(/^[a-zA-Z0-9\s]+$/),
        ],
      ],
      gender: ['', [Validators.required, Validators.pattern(/^[MF]$/)]],
      description: [
        '',
        [
          Validators.required,
          Validators.minLength(10),
          Validators.maxLength(500),
          Validators.pattern(/^[a-zA-Z0-9\s.,!]+$/),
        ],
      ],
      image_url: [
        '',
        [
          Validators.required,
          Validators.pattern(/(https?:\/\/.*\.(?:png|jpg))/i),
        ],
      ],
      price: [
        '',
        [
          Validators.required,
          Validators.min(1),
          Validators.max(100000),
          Validators.pattern(/^\d+(\.\d{1,2})?$/),
        ],
      ],
      quantity: [
        '',
        [
          Validators.required,
          Validators.min(1),
          Validators.max(1000),
          Validators.pattern(/^\d+$/),
        ],
      ],
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
