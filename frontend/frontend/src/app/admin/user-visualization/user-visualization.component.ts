import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-user-visualization',
  templateUrl: './user-visualization.component.html',
  styleUrls: ['./user-visualization.component.scss'],
})
export class UserVisualizationComponent implements OnInit {
  users: any[] = [];
  selectedUser: any = null;
  constructor(private apiService: ApiService) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.apiService.getUsers().subscribe((users) => {
      this.users = users;
    });
  }

  openEditModal(user: any): void {
    this.selectedUser = { ...user }; // Copy the user object for editing
  }

  closeModal(): void {
    this.selectedUser = null; // Close the modal by clearing selectedUser
  }

  updateUser(): void {
    if (this.selectedUser) {
      this.apiService
        .updateUser(this.selectedUser.key, this.selectedUser)
        .subscribe(() => {
          this.loadUsers();
          this.closeModal(); // Close modal after updating
        });
    }
  }

  deleteUser(userKey: string): void {
    if (confirm('Are you sure you want to delete this user?')) {
      this.apiService.deleteUser(userKey).subscribe(() => {
        this.loadUsers();
      });
    }
  }
}
