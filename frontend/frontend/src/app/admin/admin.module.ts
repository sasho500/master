import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { AdminComponent } from './admin/admin.component';
import { ProductManagementComponent } from './product-management/product-management.component';
import { UserVisualizationComponent } from './user-visualization/user-visualization.component';
import { AdminRoutingModule } from './admin-routing.module';
import { AdminGuard } from '../guards/admin.guard';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
@NgModule({
  declarations: [ProductManagementComponent, UserVisualizationComponent],
  imports: [
    CommonModule,
    AdminRoutingModule,
    AdminComponent,
    FormsModule,
    ReactiveFormsModule,
  ],
  providers: [AdminGuard],
})
export class AdminModule {}
