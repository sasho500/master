import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-user-visualization',
  templateUrl: './user-visualization.component.html',
  styleUrls: ['./user-visualization.component.scss'],
})
export class UserVisualizationComponent implements OnInit {
  users: any[] = [];
  userForm: FormGroup;
  selectedUser: any = null;

  constructor(private apiService: ApiService, private fb: FormBuilder) {
    // Define the form structure
    this.userForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      role: ['', [Validators.required]],
      password: [
        '',
        [
          Validators.minLength(8),
          Validators.maxLength(20),
          Validators.pattern(/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,20}$/),
        ],
      ],
    });
  }

  ngOnInit(): void {
    this.loadUsers(); // Load users when component initializes
  }

  loadUsers(): void {
    this.apiService.getUsers().subscribe((users) => {
      this.users = users;
    });
  }

  // Open the edit modal and populate the form
  openEditModal(user: any): void {
    this.selectedUser = { ...user }; // Clone the user object for editing
    this.userForm.patchValue({
      email: this.selectedUser.email,
      role: this.selectedUser.role,
      password: '', // Do not pre-fill the password for security reasons
    });
  }

  // Close the modal
  closeModal(): void {
    this.selectedUser = null;
    this.userForm.reset(); // Reset form when modal is closed
  }

  // Update user data
  updateUser(): void {
    if (this.userForm.valid) {
      const updatedUser = {
        ...this.selectedUser, // Spread the current user data
        ...this.userForm.value, // Overwrite with form data
      };
      this.apiService
        .updateUser(this.selectedUser.key, updatedUser)
        .subscribe(() => {
          this.loadUsers(); // Reload users after update
          this.closeModal(); // Close modal after updating
        });
    }
  }

  // Delete user
  deleteUser(userKey: string): void {
    if (confirm('Are you sure you want to delete this user?')) {
      this.apiService.deleteUser(userKey).subscribe(() => {
        this.loadUsers(); // Reload users after deletion
      });
    }
  }
}
