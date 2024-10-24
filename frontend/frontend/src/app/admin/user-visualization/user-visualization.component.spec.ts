import { ComponentFixture, TestBed } from '@angular/core/testing';

import { UserVisualizationComponent } from './user-visualization.component';

describe('UserVisualizationComponent', () => {
  let component: UserVisualizationComponent;
  let fixture: ComponentFixture<UserVisualizationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [UserVisualizationComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(UserVisualizationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
