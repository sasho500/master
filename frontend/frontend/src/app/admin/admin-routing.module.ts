import { NgModule } from '@angular/core';
import { AdminComponent } from './admin/admin.component';
import { RouterModule, Routes } from '@angular/router';
import { ProductManagementComponent } from './product-management/product-management.component';
import { UserVisualizationComponent } from './user-visualization/user-visualization.component';
import { AdminGuard } from '../guards/admin.guard';
const routes: Routes = [
  {
    path: '',
    component: AdminComponent,
    canActivate: [AdminGuard],
    children: [
      {
        path: 'product-management',
        component: ProductManagementComponent,
      },
      {
        path: 'user-visualization',
        component: UserVisualizationComponent,
      },
    ],
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class AdminRoutingModule {}
