import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-user-visualization',
  templateUrl: './user-visualization.component.html',
  styleUrls: ['./user-visualization.component.scss'],
})
export class UserVisualizationComponent implements OnInit {
  users: any[] = [];

  constructor(private apiService: ApiService) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.apiService.getUsers().subscribe((users) => {
      this.users = users;
    });
  }
}
